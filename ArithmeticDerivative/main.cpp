#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>
#include <map>

// Problem parameters
const long n = 5e15;

// Algorithm parameters
const long bound = 1e8; // (long) sqrt(n);

// Static variables
std::vector<long> s_memo = {};
std::map<long, long> s_cache;
std::vector<long> mu_memo = {};
std::vector<long> gamma_memo = {};
std::vector<std::vector<long>> primes_memo = {};
std::vector<std::vector<long>> divisors_memo = {};

std::vector<long> primes(long x) {
    return primes_memo[x - 1];
}

std::vector<long> divisors(long x) {
    return divisors_memo[x - 1];
}

long mu(long x) {
    return mu_memo[x - 1];
}

long gamma(long x) {
    return gamma_memo[x - 1];
}

void init() {
    // Init
    std::vector<long> s_partial_memo = {};
    s_partial_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        s_partial_memo[x - 1] = x;
    }

    mu_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        mu_memo[x - 1] = 1;
    }

    gamma_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        gamma_memo[x - 1] = 1;
    }

    divisors_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        divisors_memo[x - 1] = { 1 };
    }

    primes_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        primes_memo[x - 1] = {};
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
                // Calculate values of mu
                mu_memo[k - 1] *= -1;
                // Calculate values of gamma
                gamma_memo[k - 1] *= gamma_p;
                // Calculate primes
                primes_memo[k - 1].push_back(p);
                // Calculate divisors
                long max_u = divisors_memo[k - 1].size();
                for (long u = 1; u <= max_u; u += 1) {
                    divisors_memo[k - 1].push_back(p * divisors_memo[k - 1][u - 1]);
                }
            }

            for (long k = p * p; k <= bound; k += p * p) {
                // Calculate values of mu
                mu_memo[k - 1] = 0;
                // Ignore divisors of squarefull numbers
                divisors_memo[k - 1] = {};
            }
        }
    }

    // Summation
    s_memo.reserve(bound);
    s_memo[0] = s_partial_memo[0];
    for (long k = 2; k <= bound; k += 1) {
        s_memo[k - 1] = s_memo[k - 2] + s_partial_memo[k - 1];
    }
}

long q(long x) {
    long result = 0;

    long max_k = (long) sqrt(x);
    for (long k = 1; k <= max_k; k += 1) {
        result += mu(k) * (x / (k * k));
    }

    return result;
}

// Declarations
long s(long x);
long s_d(long min_a, long d, long x);

// FIXME: Memoize small values of this function with a vector
// larger values use a map
long s(long x) {
    if (x <= 0) { return 0; }
    if (x <= bound) { return s_memo[x - 1]; }
    if (s_cache.count(x)) { return s_cache[x]; }
    long result = 0;
    result += q(x);
    long max_d = (long) sqrt(x);
    for (long d = 2; d <= max_d; d += 1) {
        long mu_d = mu(d);
        if (mu_d != 0) { result -= mu(d) * s_d(2, d, x);}
    }
    s_cache[x] = result;
    return result;
}

long s_d_term_1_aux(
    std::vector<long> prime_list,
    long min_a,
    long d,
    long x,
    long pos,
    long acc_reduced,
    long acc_total
) {
    long result = 0;

    if (pos >= prime_list.size()) {
        long argument = x / acc_total;
        std::vector<long> divisor_list = divisors(d);
        long max_idx = divisor_list.size();
        for (long idx = 0; idx < max_idx; idx += 1) {
            long u = divisor_list[idx];
            result += mu(u) * s_d(1, u, argument);
        }

        result *= acc_reduced;
        return result;
    }

    long p = prime_list[pos];

    long next_pos = pos + 1;
    long next_acc_reduced = acc_reduced;
    for (long i = 1; i <= min_a - 1; i += 1) { next_acc_reduced *= p; }
    long next_acc_total = acc_total;
    for (long i = 1; i <= min_a; i += 1) { next_acc_total *= p; }

    for (long a = min_a; a <= p - 1; a += 1) {
        if (next_acc_total > x) { break; }
        result += s_d_term_1_aux(prime_list, min_a, d, x, next_pos, next_acc_reduced, next_acc_total);
        next_acc_reduced *= p;
        next_acc_total *= p;
    }

    return result;
}

long s_d_term_1(long min_a, long d, long x) {
    std::vector<long> prime_list = primes(d);
    return s_d_term_1_aux(prime_list, min_a, d, x, 0, 1, 1);
}

long s_d_term_2(long min_a, long d, long x) {
    long result = 0;
    std::vector<long> divisor_list = divisors(d);
    long max_pos = divisor_list.size();
    for (long pos = 2; pos <= max_pos; pos += 1) {
        long u = divisor_list[pos - 1];
        long gamma_u = gamma(u);
        if (gamma_u == 0) { continue; }
        result += mu(u) * gamma_u * s_d(min_a, d / u, x / gamma_u);
    }
    return result;
}

long s_d(long min_a, long d, long x) {
    if (x <= 0 || d > x) { return 0; }
    if (d == 1) { return s(x); }
    if (min_a == 2 && d % 2 == 0) { return 4 * s_d(min_a, d / 2, x / 4); }
    long result = 0;
    result += s_d_term_1(min_a, d, x);
    result -= s_d_term_2(min_a, d, x);
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
    init();
    result = s(n);

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
