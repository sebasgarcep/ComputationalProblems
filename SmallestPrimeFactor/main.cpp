/*
Approach:

Notice that:

S(n) = sum(i = 2, n) smpf(i)
     = sum(pt <= n, pt prime) pt * |Apt|

where Apt is the set of all numbers divisible by the prime pt, but not by any of the t - 1 primes smaller
than pt. Thus:

|A2| = floor(n / 2)
|A3| = floor(n / 3) - floor(n / 6)
|A5| = floor(n / 5) - floor(n / 10) - floor(n / 15) + floor(n / 30)

For |Apt| set x = n / pt. Then |Apt| = floor(x) - sum(i < t) floor(x / pi) + sum(i < j < t) floor(x / (pi * pj)) - ...,
This is equivalent to the amount of numbers less than or equal to x that are not divisible by any of
the first t - 1 primes. Thus |Apt| = phi(x, t - 1) = phi(n / pt, t - 1), where phi is as defined in
the proof of the Meissel-Lehmer algorithm.

Notice that if smpf(i) > sqrt(n), then i is prime (otherwise sqrt(i) >= smpf(i) > sqrt(n) and thus
i > n, a contradiction). Therefore if p > sqrt(n), then |Apt| = 1. Therefore:

sum(sqrt(n) < p <= n, p prime) p * |Apt| = sum(sqrt(n) < p <= n, p prime) p
                                         = sum(p <= n, p prime) p - sum(p <= sqrt(n), p prime) p
                                         = sp(n) - sp(sqrt(n))

where sp is the sum of primes function.

General sum over primes
-----------------------

As per Lehmer's paper, the Meissel-Lehmer algorithm calculates sum(pt <= x, pt prime) 1. In the final
section he outlines a method to extend the algorithm to general functions f(pt). We will now calculate
the formulas for f(pt) = pt.

Define:

Q(x, k) = sum(n * k <= x) f(n * k)
phi(x, a) = sum(n <= x, gcd(n, ma) = 1) f(n), where ma = p1 * p2 * ... * pa
P0(x, a) = f(1)
Pk(x, a) = sum(q <= x) f(q), q is the product of k primes, each greater than pa

Clearly, when f(q) = 1, these definitions are consistent with the classical formulation for the
Meissel-Lehmer algorithm. Notice that:

sum(d | ma) mu(d) * Q(x, d) = sum(d | ma) mu(d) * sum(n * d <= x) f(n * d)
                            = sum(m <= x) f(m) * sum(d | ma, n * d = m) u(d)
                            = sum(m <= x) f(m) * sum(d | ma, d | m) u(d)
                            = sum(m <= x) f(m) * sum(d | gcd(ma, m)) u(d)

where mu is the Mobius function. It is well known that:

sum(d | n) mu(d) = if n = 1 then 1 else 0 end

To see this notice that the case for n = 1 is a result of mu(1) = 1. Now if n = 2 it is clear that
the sum equals 0. Notice also that if n = p1^k1 * p2^k2 * ... * pm^km, then the sum over n is equal
to the sum over n * pi, i = 1, 2, ... , m, as the new divisors in the sum will have a square factor
of said pi, and therefore their values of mu will be 0. Therefore assume we wish to find the value
of the sum for n * pi+1. Then:

sum(d | n * pi+1) u(d) = sum(d | n) u(d) + u(d * pi+1) = sum(d | n) u(d) - u(d) = 0

Therefore the terms in the sum of sum(d | ma) mu(d) * Q(x, d) vanish except when ma and m are coprime,
in which case the coefficient for f(m) is 1. Therefore:

sum(d | ma) mu(d) * Q(x, d) = sum(m <= x, gcd(m, ma) = 1) f(m) = phi(x, a)

Also, suppose n <= x and gcd(n, ma) = 1. Then pi does not divide n, for i = 1, 2, ... , a. Therefore,
any prime that divides n must be greater than pa. Finally, n must be the product of a finite number of
primes. Therefore:

phi(x, a) = sum(n <= x, gcd(n, ma) = 1) f(n)
          = sum(k = 0, infty) sum(n <= x, gcd(n, ma) = 1, n is the product of k primes) f(n)
          = sum(k = 0, infty) sum(n <= x, n is the product of k primes, each greater than pa) f(n)
          = sum(k = 0, infty) Pk(x, a)

Combining both results we get:

phi(x, a) = sum(d | ma) mu(d) * Q(x, d) = sum(k = 0, infty) Pk(x, a)

Notice that P1(x, a) = sum(pa < p <= x, p prime) f(p). Therefore:

phi(x, a) = P0(x, a) + P1(x, a) + sum(k = 2, infty) Pk(x, a)
          = f(1) + sum(pa < p <= x, p prime) f(p) + sum(k = 2, infty) Pk(x, a)

sum(pa < p <= x, p prime) f(p) = phi(x, a) - f(1) - sum(k = 2, infty) Pk(x, a)
sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - f(1) - sum(k = 2, infty) Pk(x, a)

If f preserves multiplication, that is, f(m) * f(n) = f(m * n), then:

phi(x, a - 1) - phi(x, a) = sum(n <= x, gcd(n, ma-1) = 1) f(n) - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                            + sum(n <= x, gcd(n, ma-1) = 1, pa does not divide n) f(n)
                            - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                            + sum(n <= x, gcd(n, ma) = 1) f(n)
                            - sum(n <= x, gcd(n, ma) = 1) f(n)
                          = sum(n <= x, gcd(n, ma-1) = 1, pa divides n) f(n)
                          = sum(n * pa <= x, gcd(n * pa, ma-1) = 1) f(n * pa)
                          = sum(n <= x / pa, gcd(n, ma-1) = 1) f(n * pa)
                          = sum(n <= x / pa, gcd(n, ma-1) = 1) f(n) * f(pa)
                          = f(pa) * sum(n <= x / pa, gcd(n, ma-1) = 1) f(n)
                          = f(pa) * phi(x / pa, a - 1)

Or reorganizing:

phi(x, a) = phi(x, a - 1) - f(pa) * phi(x / pa, a - 1)

Expanding the leftmost term until we reach level r, we get:

phi(x, a) = phi(x, r) - sum(k = r, a - 1) f(pk+1) * phi(x / pk+1, k)

which we can use as a recursive step to simplify the calculation of phi.

Application of General Case
---------------------------

If we set f(p) = p then this function clearly preserves multiplication. Set r = 2, and use the fact
that the only numbers coprime to 6 are of the form 6 * q + 1 and 6 * q + 5. Then:

q(x, 0) = x * (x + 1) / 2
q(x, 1) = ceiling(x / 2) ^ 2
q(x, 2) = 6 * q ^ 2 + s, where
    q = fld(x, 6),
    s = if x mod 6 == 0 then 0 else if x mod 6 == 5 then 6 else 1 end
q(x, 3) = ... (use recursion)

Now set a = pr(n^(1/4)), b = pr(n^(1/2)), c = pr(n^(1/3)). Notice that in this case Pk(x, a) = 0,
for k >= 4. To see this let q = p1 * p2 * ... * pk, with p1 <= p2 <= ... <= pk. But p1 > pa, thus
p1 > n^(1/4) >= n^(1/k). Thus, in general, pi > n^(1/k), and therefore multiplying over i = 1, 2, ... k,
we get q > n. Therefore the sums for Pk(x, a), for k >= 4 are empty. Therefore:

sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - f(1) - P2(x, a) - P3(x, a)
sum(p <= x, p prime) f(p) = sum(p <= pa, p prime) f(p) + phi(x, a) - 1 - P2(x, a) - P3(x, a)

Now let's solve for P2(x, a) and P3(x, a):

bi = pr(x / pi)
P2(x, a) = sum(q = pi * pj <= x, pa < pi < pj) f(q)
         = sum(i = a + 1, b) sum(j = i, bi) f(pi * pj)
         = sum(i = a + 1, b) sum(j = i, bi) pi * pj
         = sum(i = a + 1, b) pi * sum(j = i, bi) pj
         = sum(i = a + 1, b) pi * (sp(p(bi)) - sp(pi-1))
         = sum(i = a + 1, b) pi * (sp(x / pi) - sp(pi-1))

ci = pr((x / pi)^(1/2))
cij = pr(x / (pi * pj))
P3(x, a) = sum(q = pi * pj * pk <= x, pa < pi < pj < pk) f(q)
         = sum(i = a + 1, c) sum(j = i, ci) sum(k = j, cij) f(pi * pj * pk)
         = sum(i = a + 1, c) sum(j = i, ci) sum(k = j, cij) pi * pj * pk
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * sum(k = j, cij) pk
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * (sp(p(cij)) - sp(pj-1))
         = sum(i = a + 1, c) sum(j = i, ci) pi * pj * (sp(x / (pi * pj)) - sp(pj-1))

Source:

https://projecteuclid.org/download/pdf_1/euclid.ijm/1255455259

---------------------------------------------------------------------------------------------------

For some reason the Julia implementation was too slow. I believe it has something to do
with memory management and the weird way Julia optimizes code that is not straightforward.
Without caching this runs in 2 mins. It can be optimized further.

*/

#include <chrono>
#include <math.h>
#include <stdio.h>
#include <thread>
#include <vector>

// Problem parameters
const long l = 1e11; // 1e12;
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

// if b | a, then (a/b) mod m = (a mod (m * b)) / b
long sieve_sum(long x, long k) {
    long quotient = x / k;
    long product = mod(quotient * (quotient + 1), 2 * ms);
    long numerator = mod(k * product, 2 * ms);
    return numerator >> 1;
}

long phi_prime_summation(long x, long a) {
    // Base cases
    if (a == 0) {
        return sieve_sum(x, 1);
    } else if (x <= primes[a - 1]) {
        return 1;
    } else if (a == 1) {
        return sieve_sum(x, 1) - sieve_sum(x, 2);
    } else if (a == 2) {
        return sieve_sum(x, 1) - sieve_sum(x, 2) - sieve_sum(x, 3) + sieve_sum(x, 6);
    }
    // Calculate for a = 3
    long res = sieve_sum(x, 1) - sieve_sum(x, 2) - sieve_sum(x, 3) - sieve_sum(x, 5)
        + sieve_sum(x, 6) + sieve_sum(x, 10) + sieve_sum(x, 15) - sieve_sum(x, 30);
    // Use recursion
    for (long i = 3; i <= a - 1; i += 1) {
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

    // Calculate P2(x, a)
    for (long i = a + 1; i <= b; i += 1) {
        long pi = primes[i - 1];
        long x_div_pi = x / pi;
        long diff_i = mod(meissel_lehmer_prime_summation(x_div_pi) - safe_prime_sums(i - 1), ms);
        res = mod(res - pi * diff_i, ms);
        // Calculate P3(x, a)
        if (i <= c) {
            long ci = meissel_lehmer_prime_counting(isqrt(x_div_pi));
            for (long j = i; j <= ci; j += 1) {
                long pj = primes[j - 1];
                long x_div_pi_pj = x_div_pi / pj;
                long diff_ij = mod(meissel_lehmer_prime_summation(x_div_pi_pj) - safe_prime_sums(j - 1), ms);
                long coeff_ij = mod(pi * pj, ms);
                res = mod(res - coeff_ij * diff_ij, ms);
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
