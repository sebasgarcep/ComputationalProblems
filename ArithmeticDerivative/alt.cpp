#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>

// Problem parameters
const long n = 5e15;

// Algorithm parameters
const long bound = (long) sqrt(n);

// Static variables
std::vector<long> prime_list;

long explore(long limit, long start_pos) {
    long result = limit;

    for (long pos = start_pos; pos < prime_list.size(); pos += 1) {
        long p = prime_list[pos];
        long next_limit = limit / (p * p);

        if (next_limit <= 0) { break; }

        long k = 2;

        if (p == 2) {
            long g_curr = p * p;
            long g_prev = 1;
            while (next_limit > 0) {
                result += (g_curr - g_prev) * explore(next_limit, pos + 1);
                if ((k + 1) % p == 0) { g_curr *= p * p; }
                if (k % p == 0) { g_prev *= p * p; }
                next_limit /= p;
                k += 1;
            }
        } else {
            long g_curr = p;
            long g_prev = 1;
            while (next_limit > 0) {
                result += (g_curr - g_prev) * explore(next_limit, pos + 1);
                if ((k + 1) % p == 0) { g_curr *= p * p; } else if (k % p != 0) { g_curr *= p; }
                if (k % p == 0) { g_prev *= p * p; } else if ((k - 1) % p != 0) { g_prev *= p; }
                next_limit /= p;
                k += 1;
            }
        }
    }

    return result;
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
    prime_list.reserve(1.5 * bound / log(bound));

    // Sieve
    std::vector<bool> slots = {};
    slots.reserve(bound);
    for (long k = 1; k <= bound; k += 1) {
        slots[k - 1] = true;
    }

    slots[1 - 1] = false;
    for (long p = 2; p <= bound; p += 1) {
        if (slots[p - 1]) {
            prime_list.push_back(p);
            for (long k = 2 * p; k <= bound; k += p) {
                slots[k - 1] = false;
            }
        }
    }

    result = explore(n, 0) - 1;

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
