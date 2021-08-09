#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>

// Problem parameters
const long n = 1e7;

// Algorithm parameters
const long bound = n;

// Static variables
std::vector<long> s_partial_memo = {};

void init() {
    // Init
    s_partial_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        s_partial_memo[x - 1] = x;
    }

    // Sieve
    std::vector<bool> slots = {};
    slots.reserve(bound);
    for (long k = 1; k <= bound; k += 1) {
        slots[k - 1] = true;
    }

    slots[1 - 1] = false;
    for (long p = 2; p <= bound; p += 1) {
        if (slots[p - 1]) {
            // Calculate gamma
            long gamma_p = 1;
            for (long idx = 0; idx < p; idx += 1) {
                gamma_p *= p;
                // If gamma is too large we shall ignore it
                if (gamma_p > n) {
                    gamma_p = 0;
                    break;
                }
            }

            for (long k = 2 * p; k <= bound; k += p) {
                slots[k - 1] = false;
            }

            for (long k = p; k <= bound; k += p) {
                // Calculate values of s_partial
                if (gamma_p == 0) {
                    s_partial_memo[k - 1] /= p;
                } else {
                    long v = 1;
                    long acc = p * p;
                    while (k % acc == 0) {
                        v += 1;
                        acc *= p;
                    }
                    if (v % p != 0) {
                        s_partial_memo[k - 1] /= p;
                    }
                }
            }
        }
    }
}

int main() {
    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    long result = 0;

    // Solution
    init();
    for (long x = 1; x <= n; x += 1) {
        result += s_partial_memo[x - 1];
    }

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
