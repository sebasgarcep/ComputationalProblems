#include <chrono>
#include <math.h>
#include <stdio.h>
#include <vector>
#include <map>

// Problem parameters
const long n = 5e15;

// Algorithm parameters
const long bound = 1e8;

// Static variables
std::vector<long> s_memo = {};
std::map<long, long> s_cache;
std::vector<long> special_primes = {};
std::vector<long> mu_memo = {};
std::vector<long> totient_memo = {};
std::vector<std::vector<long>> divisors_memo = {};

std::vector<long> divisors(long x) {
    return divisors_memo[x - 1];
}

long mu(long x) {
    return mu_memo[x - 1];
}

long totient(long x) {
    return totient_memo[x - 1];
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

    totient_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        totient_memo[x - 1] = 1;
    }

    divisors_memo.reserve(bound);
    for (long x = 1; x <= bound; x += 1) {
        divisors_memo[x - 1] = { 1 };
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

            if (gamma_p != 0) {
                special_primes.push_back(p);
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
                // Calculate values of totient
                totient_memo[k - 1] *= p - 1;
                // Calculate divisors
                long max_u = divisors_memo[k - 1].size();
                for (long u = 1; u <= max_u; u += 1) {
                    divisors_memo[k - 1].push_back(p * divisors_memo[k - 1][u - 1]);
                }
            }

            for (long k = p * p; k <= bound; k += p * p) {
                // Calculate values of mu
                mu_memo[k - 1] = 0;
                // Ignore totient of squarefull numbers
                totient_memo[k - 1] = 0;
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
long s_d_edge(long d, long x);
long s_d_2_edge(long d, long x);
long s_d_2_special(long special, long d, long x);

long s(long x) {
    if (x <= 0) { return 0; }
    if (x <= bound) { return s_memo[x - 1]; }
    if (s_cache.count(x)) { return s_cache[x]; }
    long result = 0;
    result += q(x);
    long max_d = (long) sqrt(x);
    for (long d = 2; d <= max_d; d += 1) {
        long mu_d = mu(d);
        if (mu_d == 0) { continue; }
        long special = 1;
        long d_rem = d;
        long max_pos = special_primes.size();
        for (long pos = 0; pos < max_pos; pos += 1) {
            long divisor = special_primes[pos];
            if (d_rem % divisor == 0) {
                special *= divisor * divisor;
                d_rem /= divisor;
            }
        }
        result -= mu(d) * s_d_2_special(special, d_rem, x);
    }
    s_cache[x] = result;
    return result;
}

long s_d_edge(long d, long x) {
    if (x <= 0 || d > x) { return 0; }
    if (d == 1) { return s(x); }
    long result = 0;
    long argument = x / d;
    std::vector<long> divisor_list = divisors(d);
    long max_idx = divisor_list.size();
    for (long idx = 0; idx < max_idx; idx += 1) {
        long u = divisor_list[idx];
        result += totient(u) * s_d_edge(u, argument);
    }
    return result;
}

long s_d_2_edge(long d, long x) {
    if (x <= 0 || d > x) { return 0; }
    if (d == 1) { return s(x); }
    return d * s_d_edge(d, x / d);
}

long s_d_2_special(long special, long d, long x) {
    if (x < special * d * d) { return 0; }
    if (special == 1) { return s_d_2_edge(d, x); }
    if (special % 4 == 0) { return 4 * s_d_2_special(special / 4, d, x / 4); }
    
    long p = 0;
    long max_pos = special_primes.size();
    for (long pos = 0; pos < max_pos; pos += 1) {
        long divisor = special_primes[pos];
        if (special % divisor == 0) {
            p = divisor;
            break;
        }
    }

    long p_2 = p * p;
    long p_2_mod = special % p_2;
    long power = p_2_mod == 0 ? 2 : 1;
    long acc_mult = p_2_mod == 0 ? p : 1;
    long acc_divi = p_2_mod == 0 ? p_2 : p;
    long next_special = special / acc_divi;

    long result = 0;

    for (long a = power; a <= p - 1; a += 1) {
        if (acc_divi > x) { break; }
        long term = s_d_2_special(next_special, d, x / acc_divi) - s_d_2_special(p * next_special, d, x / acc_divi);
        result += acc_mult * term;
        acc_mult *= p;
        acc_divi *= p;
    }

    if (acc_divi <= x) {
        result += acc_divi * s_d_2_special(next_special, d, x / acc_divi);
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
    init();
    result = s(n) - 1;

    // Show result
    printf("%ld\n", result);

    // End time measurement
    stop = std::chrono::high_resolution_clock::now();
    elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(stop - start).count() / 1000.0;
    printf("Took: %lf\n", elapsed);
}
