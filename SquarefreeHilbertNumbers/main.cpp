#include <algorithm>
#include <chrono>
#include <math.h>
#include <numeric>
#include <stdio.h>
#include <vector>

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

// Problem parameters
const long n = 1e16 - 1;
const long n_sq = isqrt(n);

// Algorithm parameters

// Static variables
std::vector<long> primes;
std::vector<long> smallest;
std::vector<long> largest;

long num_multiples(long n, long m) {
    if (m > n) { return 0; }
    if ((m & 1) == 0) { return 0; }
    long r = m & 3;
    long v = (n + (4 - r) * m) / (4 * m);
    return v;
}

long smallest_prime_factor(long n) {
    if (n <= 2) {
        return n;
    } else if ((n & 1) == 0) {
        return 2;
    }
    for (long d = 3; d * d <= n; d += 2) {
        if (n % d == 0) {
            return d;
        }
    }
    return n;
}

void quicksort(long lo, long hi) {
    if (lo >= hi) { return; }
    long p;
    long pivot_first = largest[(lo + hi) >> 1];
    long pivot_second = smallest[(lo + hi) >> 1];
    long i = lo - 1;
    long j = hi + 1;
    while (true) {
        do { i += 1; } while (
            largest[i] < pivot_first
            || (largest[i] == pivot_first && smallest[i] < pivot_second)
        );
        do { j -= 1; } while (
            largest[j] > pivot_first
            || (largest[j] == pivot_first && smallest[j] > pivot_second)
        );
        if (i >= j) {
            p = j;
            break;
        }
        std::swap(largest[i], largest[j]);
        std::swap(smallest[i], smallest[j]);
        std::swap(primes[i], primes[j]);
    }
    quicksort(lo, p);
    quicksort(p + 1, hi);
}

long search(long accumulator, long prime_bound, long start) {
    // Base case
    if (accumulator > n_sq) { return 0; }
    long total = num_multiples(n, accumulator * accumulator);
    for (long i = start; i < primes.size(); i += 1) {
        long small_prime = smallest[i];
        long large_prime = largest[i];
        // Early exit
        if (large_prime > prime_bound && accumulator * large_prime > n_sq) { break; }
        // Calculate LCM
        long next_accumulator = accumulator;
        if (large_prime == small_prime) {
            if (accumulator % large_prime != 0) { next_accumulator *= large_prime; }
            next_accumulator *= large_prime;
        } else {
            if (small_prime > 1 && accumulator % small_prime != 0) { next_accumulator *= small_prime; }
            if (accumulator % large_prime != 0) { next_accumulator *= large_prime; }
        }
        // Update prime bound
        long next_prime_bound = large_prime > prime_bound ? large_prime : prime_bound;
        // Subtract new terms
        total -= search(next_accumulator, next_prime_bound, i + 1);
    }
    return total;
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
    const long l = num_multiples(n_sq, 1);
    bool* slots = new bool[l];
    slots[0] = false;
    for (long k = 1; k < l; k += 1) { slots[k] = true; }
    for (long k = 0; k < l; k += 1) {
        if (slots[k]) {
            long m = 4 * k + 1;
            // Save the prime
            primes.push_back(m);
            long smpf = smallest_prime_factor(m);
            if (smpf == m) {
                smallest.push_back(1);
                largest.push_back(m);
            } else {
                smallest.push_back(smpf);
                largest.push_back(m / smpf);
            }
            // Finished saving the prime
            for (long g = k + m; g < l; g += m) {
                slots[g] = false;
            }
        }
    }
    delete[] slots;

    quicksort(0, largest.size() - 1);

    result = search(1, 1, 0);

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
