/*
Approach:
*/

#include <chrono>
#include <math.h>
#include <stdio.h>
#include <thread>
#include <vector>

// Problem parameters
const long n = 2e9;

// Algorithm parameters

// Static variables
char* flags = new char[n];

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

long icbrt(long n) {
    long t = (long) cbrt(n);
    if ((t + 1) * (t + 1) * (t + 1) <= n) {
        return t + 1;
    } else if (t * t * t <= n) {
        return t;
    } else {
        return t - 1;
    }
}

long iroot(long x, long n) {
    if (n == 1) {
        return x;
    } else if (n == 2) {
        return isqrt(x);
    } else if (n == 3) {
        return icbrt(x);
    } else {
        long fl = (long) pow(x, 1.0 / n);
        long cl = (long) pow(x, 1.0 / n);
        if (pow(cl, n) <= x) {
            return cl;
        } else {
            return fl;
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
    for (int i = 0; i < n; i += 1) {
        flags[i] = 0;
    }

    long limit_a = isqrt(n);
    for (long a = 1; a <= limit_a; a += 1) {
        long a_2 = a * a;
        for (long b = 1; a_2 + b * b <= n; b += 1) {
            long k = a * a + b * b;
            flags[k - 1] |= 1;
        }
        for (long b = 1; a_2 + 2 * b * b <= n; b += 1) {
            long k = a * a + 2 * b * b;
            flags[k - 1] |= 2;
        }
        for (long b = 1; a_2 + 3 * b * b <= n; b += 1) {
            long k = a * a + 3 * b * b;
            flags[k - 1] |= 4;
        }
        for (long b = 1; a_2 + 7 * b * b <= n; b += 1) {
            long k = a * a + 7 * b * b;
            flags[k - 1] |= 8;
        }
    }

    for (int i = 0; i < n; i += 1) {
        if (flags[i] == 15) {
            result += 1;
        }
    }

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
