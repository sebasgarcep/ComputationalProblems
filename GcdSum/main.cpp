#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>

// Problem parameters
const long n_problem = 100000000000;
const long mod_size = 998244353;

long mod(long n) {
    return ((n % mod_size) + mod_size) % mod_size;
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

// Algorithm parameters
const long cache_size = isqrt(n_problem);

// Static variables
std::vector<long> totientsum_lo_cache;
std::vector<long> totientsum_hi_cache;


// Solution
long triangular(long n) {
    long a = mod((n & 1) == 0 ? (n >> 1) : n);
    long b = mod(((n + 1) & 1) == 0 ? ((n + 1) >> 1) : (n + 1));
    return mod(a * b);
}

long totientsum(long n) {
    if (n == 1) {
        return 1;
    }
    if (n <= cache_size) {
        if (totientsum_lo_cache[n - 1] >= 0) {
            return totientsum_lo_cache[n - 1];
        }
    } else {
        if (totientsum_hi_cache[(n_problem / n) - 1] >= 0) {
            return totientsum_hi_cache[(n_problem / n) - 1];
        }
    }
    long s = triangular(n);
    long max_u = isqrt(n);
    if (max_u == (n / max_u)) {
        max_u -= 1;
    }
    for (long u = 1; u <= max_u; u += 1) {
        s -= mod(totientsum(u) * mod(((n / u) - (n / (u + 1)))));
        s = mod(s);
    }
    long max_m = isqrt(n);
    for (long m = 2; m <= max_m; m += 1) {
        s -= totientsum(n / m);
        s = mod(s);
    }
    if (n <= cache_size) {
        totientsum_lo_cache[n - 1] = s;
    } else {
        totientsum_hi_cache[(n_problem / n) - 1] = s;
    }
    return s;
}

long g(long n) {
    long value = 0;
    long max_u = isqrt(n);
    if (max_u == (n / max_u)) {
        max_u -= 1;
    }
    for (long u = 1; u <= max_u; u += 1) {
        value += mod(totientsum(u) * (triangular(n / u) - triangular(n / (u + 1))));
        value = mod(value);
    }
    long max_k = isqrt(n);
    for (long k = max_k; k >= 1; k -= 1) {
        value += mod(mod(k) * totientsum(n / k));
        value = mod(value);
    }
    return value;
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
    totientsum_lo_cache.reserve(cache_size);
    totientsum_hi_cache.reserve(cache_size);
    for (long pos = 0; pos < cache_size; pos += 1) {
        totientsum_lo_cache[pos] = -1;
        totientsum_hi_cache[pos] = -1;
    }

    result = g(n_problem);

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
