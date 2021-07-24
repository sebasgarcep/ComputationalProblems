#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>

// Problem parameters
const long limit = 150e6;

// Algorithm parameters

// Static variables
std::vector<long> primes;

bool is_prime(long n, long l) {
    if (n == 1) { return false; }
    if (n == 2) { return true; }
    for (long p : primes) {
        if (p > l) { break; }
        if (n % p == 0) {
            return false;
        }
    }
    return true;
}

bool is_set_prime(long n_2, long l) {
    for (long p : primes) {
        if (p > l) { break; }
        if (
            (n_2 + 1) % p == 0 ||
            (n_2 + 3) % p == 0 ||
            (n_2 + 7) % p == 0 ||
            (n_2 + 9) % p == 0 ||
            (n_2 + 13) % p == 0 ||
            (n_2 + 27) % p == 0
        ) {
            return false;
        }
    }
    return true;
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
    // Calculate all primes up to the limit to perform the primality test
    // Prime sieve
    bool* slots = new bool[limit];

    long prime_capacity = 1.3 * limit / log(limit);
    primes.reserve(prime_capacity);

    for (long i = 1; i <= limit; i += 1) {
        slots[i - 1] = i % 2 == 1;
    }

    primes.push_back(2);
    for (long i = 3; i <= limit; i += 2) {
        if (slots[i - 1]) {
            primes.push_back(i);
            for (long j = 2 * i; j <= limit; j += i) {
                slots[j - 1] = false;
            }
        }
    }

    for (long n = 10; n < limit; n += 10) {
        if (n % 13 == 0) {
            continue;
        }
        long n_2 = n * n;
        if (n_2 % 3 != 1 || n_2 % 7 != 2) {
            continue;
        }
        // isqrt(n^2 + 27) = n for n > 13. Otherwise just use a large enough value
        long l = n > 13 ? n : n_2;
        if (
            is_set_prime(n_2, l) &&
            !is_prime(n_2 + 21, l)
        ) {
            result += n;
        }
    }

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
