/**
 * FIXME: verify solution for l = 10^12
 * For some reason the Julia implementation was too slow. I believe it has something to do
 * with memory management and the weird way Julia optimizes code that is not straightforward.
 * Without caching this runs in 2 mins. It can be optimized further.
 */

#include <chrono>
#include <math.h>
#include <stdio.h>
#include <thread>
#include <vector>

// Problem parameters
const long l = 1e12;
const long ms = 1e9;

// Algorithm parameters
const long sieve_bound = 1e6;

// Static variables
std::vector<long> primes;
std::vector<long> prime_sums;

long mod(long a, long b) {
    long r = a % b;
    return r >= 0 ? r : r + std::abs(b);
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

long binary_prime_counting(long x) {
        if (x < 2) {
            return 0;
        }
        long lower = 0;
        long upper = primes.size() - 1;
        while (upper - lower > 1) {
            long middle = (lower + upper) >> 1;
            if (primes[middle] == x) {
                lower = middle;
                upper = middle;
            } else if (primes[middle] < x) {
                lower = middle;
            } else {
                upper = middle;
            }
        }
        if (primes[upper] <= x) {
            return upper + 1;
        } else {
            return lower + 1;
        }

}

long phi_prime_counting(long x, long a) {
    if (a == 0) {
        return x;
    } else if (x <= primes[a - 1]) {
        return 1;
    } else if (a == 1) {
        return x - (x >> 1);
    } else if (a == 2) {
        return x - (x >> 1) - x / 3 + x / 6;
    }
    long res = x - (x >> 1) - x / 3 - x / 5 + x / 6 + x / 10 + x / 15 - x / 30;
    for (long i = 3; i <= (a - 1); i += 1) {
        res -= phi_prime_counting(x / primes[i], i);
    }
    return res;
}

long meissel_lehmer_prime_counting(long x) {
    // Binary search
    if (x <= sieve_bound) {
        return binary_prime_counting(x);
    }

    // Enumeration constants
    long a = meissel_lehmer_prime_counting(iroot(x, 4));
    long b = meissel_lehmer_prime_counting(iroot(x, 2));
    long c = meissel_lehmer_prime_counting(iroot(x, 3));

    // Base answer
    long res = a - 1 + phi_prime_counting(x, a);

    // Calculate P2(x, a)
    res -= ((a * (a - 1)) >> 1) - ((b * (b - 1)) >> 1);
    for (long i = a + 1; i <= b; i += 1) {
        long x_div_p = x / primes[i - 1];
        res -= meissel_lehmer_prime_counting(x_div_p);
        // Calculate P3(x, a)
        if (i <= c) {
            long bi = meissel_lehmer_prime_counting(isqrt(x_div_p));
            for (long j = i; j <= bi; j += 1) {
                res -= meissel_lehmer_prime_counting(x_div_p / primes[j - 1]) - (j - 1);
            }
        }
    }

    return res;
}

long phi_prime_summation(long x, long a) {
    // Base cases
    if (a == 0) {
        return (x * (x + 1)) >> 1;
    } else if (x <= primes[a - 1]) {
        return 1;
    } else if (a == 1) {
        long cld = x - (x >> 1);
        return cld * cld;
    }
    // Calculate for a = 2
    long q = x / 6;
    long s;
    if (x % 6 == 0) {
        s = 0;
    } else if (x % 6 == 5) {
        s = 12 * q + 6;
    } else {
        s = 6 * q + 1;
    }
    long res = mod(6 * q * q + s, ms);
    // Use recursion
    for (long i = 2; i <= a - 1; i += 1) {
        long p = primes[i];
        res = mod(res - p * phi_prime_summation(x / p, i), ms);
    }
    return res;
}

long safe_prime_sums(long a) {
    if (a < 1) { return 0; }
    return prime_sums[a - 1];
}

long meissel_lehmer_prime_summation(long x) {
    // Binary search
    if (x <= sieve_bound) {
        long pos = binary_prime_counting(x);
        return safe_prime_sums(pos);
    }

    // Enumeration constants
    long a = meissel_lehmer_prime_counting(iroot(x, 4));
    long b = meissel_lehmer_prime_counting(iroot(x, 2));
    long c = meissel_lehmer_prime_counting(iroot(x, 3));

    // Base answer
    long res = mod(safe_prime_sums(a) - 1 + phi_prime_summation(x, a), ms);
    // if (x == l) { printf("%ld\n", res); }

    // Calculate P2(x, a)
    for (long i = a + 1; i <= b; i += 1) {
        long pi = primes[i - 1];
        long x_div_pi = x / pi;
        long diff_i = mod(meissel_lehmer_prime_summation(x_div_pi) - safe_prime_sums(i - 1), ms);
        res = mod(res - pi * diff_i, ms);
        // if (x == l) { printf("%ld\n", res); }
        // Calculate P3(x, a)
        if (i <= c) {
            long ci = meissel_lehmer_prime_counting(isqrt(x_div_pi));
            for (long j = i; j <= ci; j += 1) {
                long pj = primes[j - 1];
                long x_div_pi_pj = x_div_pi / pj;
                long diff_ij = mod(meissel_lehmer_prime_summation(x_div_pi_pj) - safe_prime_sums(j - 1), ms);
                long coeff_ij = mod(pi * pj, ms);
                res = mod(res - coeff_ij * diff_ij, ms);
                // if (x == l) { printf("%ld\n", res); }
            }
        }
    }

    return res;
}

int main() {
    assert(sieve_bound >= isqrt(l) && "The sieve bound must be at least sqrt(l).");

    // Begin time measurement
    std::chrono::high_resolution_clock::time_point start;
    std::chrono::high_resolution_clock::time_point stop;
    double elapsed;
    start = std::chrono::high_resolution_clock::now();

    // Problem result
    long result = 0;

    // Prime sieve
    bool* slots = new bool[sieve_bound];

    long prime_capacity = 1.3 * sieve_bound / log(sieve_bound);
    primes.reserve(prime_capacity);

    for (long i = 1; i <= sieve_bound; i += 1) {
        slots[i - 1] = i % 2 == 1;
    }

    primes.push_back(2);
    for (long i = 3; i <= sieve_bound; i += 2) {
        if (slots[i - 1]) {
            primes.push_back(i);
            for (long j = 2 * i; j <= sieve_bound; j += i) {
                slots[j - 1] = false;
            }
        }
    }

    // Prime sum
    prime_sums.reserve(prime_capacity);
    prime_sums.push_back(primes[0]);
    for (long i = 1; i < primes.size(); i += 1) {
        prime_sums.push_back(mod(primes[i] + prime_sums[i - 1], ms));
    }

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
    start = std::chrono::high_resolution_clock::now();

    long lmt = binary_prime_counting(isqrt(l));
    for (long i = 0; i < lmt; i += 1) {
        long p = primes[i];
        result = mod(result + p * phi_prime_counting(l / p, i), ms);
    }

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);

    result = mod(result + meissel_lehmer_prime_summation(l) - meissel_lehmer_prime_summation(isqrt(l)), ms);

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
