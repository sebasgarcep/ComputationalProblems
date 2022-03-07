#include <chrono>
#include <math.h>
#include <stdio.h>

// Problem parameters
const long limit = 10000000;
const long mod_size = 1000000000 + 7;

// Algorithm parameters

// Static variables

long mod(long a, long b) {
    long r = a % b;
    return r >= 0 ? r : r + b;
}

long isqrt(long n) {
    long t = (long) sqrt(n);
    if ((t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

long sigma(long n, long m) {
    long d = isqrt(4 * n + 1);
    if (d * d != 4 * n + 1) return 0;
    if (mod(d - 1, 4) == 0) {
        long k = (d - 1) / 4;
        return mod((k & 1 == 1 ? -1 : 1), m);
    }
    if (mod(d + 1, 4) == 0) {
        long k = (d + 1) / 4;
        return mod((k & 1 == 1 ? -1 : 1), m);
    }
    return 0;
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
    long* p_memo { new long[limit + 1]() };
    p_memo[0] = 1;
    for (long n = 1; n <= limit; n += 1) {
        // Calculate P(n)
        long value = sigma(n, mod_size);
        long k = 1;
        while (n >= 2 * k * k - k) {
            if (n >= 2 * k * k + k) {
                value -= (k & 1 == 1 ? -1 : 1) * p_memo[n - (2 * k * k + k)];
            }
            value -= (k & 1 == 1 ? -1 : 1) * p_memo[n - (2 * k * k - k)];
            k += 1;
        }
        value = mod(value, mod_size);
        p_memo[n] = value;

        // Add P(n) to accumulator
        result = mod(result + value, mod_size);
    }

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
