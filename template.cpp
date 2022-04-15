#include <chrono>
#include <math.h>
#include <stdio.h>

constexpr long long mod(long long a, long long b) {
    long long r = a % b;
    return r >= 0 ? r : r + b;
}

constexpr long long isqrt(long long x) {
    long long q = 1;
    while (q <= x)
        q <<= 2;
    long long r = 0;
    while (q > 1) {
        q >>= 2;
        long long t = x - r - q;
        r >>= 1;
        if (t >= 0) {
            x = t;
            r += q;
        }
    }
    return r;
}

constexpr long long icbrt(long long n) {
    long long t = (long long) cbrt(n);
    if ((t + 1) * (t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

long long iroot(long long x, long long n) {
    if (n == 1) {
        return x;
    } else if (n == 2) {
        return isqrt(x);
    } else if (n == 3) {
        return icbrt(x);
    } else {
        long long test = (long long) pow(x, 1.0 / n);
        if (pow(test + 1, n) <= x) {
            return test + 1;
        } else {
            return test;
        }
    }
}

// Problem parameters

// Algorithm parameters

// Static variables

int main() {
    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    long long result = 0;

    // Solution

    // Show result
    printf("%lld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
