#include <assert.h>
#include <chrono>
#include <math.h>
#include <stdio.h>

// Problem parameters
const long l = 2000;
const long k = 1e18;
const long m = 20092010;

// Algorithm parameters

// Static variables
long mr_memory[l];

long mod(long a, long b) {
    long r = a % b;
    return r >= 0 ? r : r + b;
}

// Instead of returning a new array overwrite a
void multiply_reduce(long a[], long b[]) {
    for (long i = 0; i < l; i += 1) {
        mr_memory[i] = 0;
    }
    for (long i = 0; i < l; i += 1) {
        for (long j = 0; j < l; j += 1) {
            long pos = i + j;
            long coefficient = mod(a[i] * b[j], m);
            if (pos < l) {
                mr_memory[pos] = mod(mr_memory[pos] + coefficient, m);
            } else {
                pos -= l;
                mr_memory[pos] = mod(mr_memory[pos] + coefficient, m);
                mr_memory[pos + 1] = mod(mr_memory[pos + 1] + coefficient, m);
            }
        }
    }
    for (long i = 0; i < l; i += 1) {
        a[i] = mr_memory[i];
    }
}

int main() {
    assert(l >= 2 && "The value of l should be >= 2.");

    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    long result = 0;

    // Solution
    long e = 1;
    long base[l];
    base[0] = 0;
    base[1] = 1;
    for (long i = 2; i < l; i += 1) {
        base[i] = 0;
    }
    long polynomial[l];
    polynomial[0] = 1;
    for (long i = 1; i < l; i += 1) {
        polynomial[i] = 0;
    }
    while (true) {
        if ((e & k) != 0) {
            multiply_reduce(polynomial, base);
        }
        e *= 2;
        if (e > k) { break; }
        multiply_reduce(base, base);
    }
    for (long i = 0; i < l; i += 1) {
        result = mod(result + polynomial[i], m);
    }

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
