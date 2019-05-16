#=
Approach:
Notice that C(n, k), if n <= n - k, is:

n * (n - 1) * (n - 2) * ...
---------------------------
1 * 2       * 3       * ...

Therefore, we need to determine the number of times that p, q and r appear in
[10^18 - 10^9 + 1, 10^18] and the number of times they appear in the range [1, 10^9].
This way, whenever all three appear more in the numerator than in the denominator,
we can be sure that C(n, k) is a multiple of m.

(https://fishi.devtail.io/weblog/2015/06/25/computing-large-binomial-coefficients-modulo-prime-non-prime/)

Theorem (Lucas Theorem)
For nonnegative integers n and k, and prime p (n choose k) = prod(i = 0, r) (ni choose ki) (mod p)
where n = n0 + n1 * p + n2 * p^2 + ... + nr * p^r and k = k0 + k1 * p + k2 * p^2 + ... + kr * p^r.
Proof:

On one hand:
(1 + X)^n = sum(k = 0, n) (n choose k) * X^k

On the other hand:
(1 + X)^n = (1 + X)^(n0 + n1 * p + n2 * p^2 + ... + nr * p^r)
          = prod(i = 0, r) (1 + X)^(ni * p^i)
          = prod(i = 0, r) ( (1 + X)^(p^i) )^ni
          = prod(i = 0, r) ( 1 + X^(p^i) )^ni
          = prod(i = 0, r) ( sum(si = 0, ni) (ni choose si) X^(si * p^i) ) (mod p)

For each term of the product pick si such that ki = si. Notice that the exponent
of X after multiplying all these terms is k0 + k1 * p + k2 * p^2 + ... + kr * p^r = k.
Because the representation of k in base p is unique, then this is the only way we can
generate X^k, and its coefficient is therefore prod(i = 0, r) (ni choose ki). Note
that the coefficient of X^k in the previous equation is (n choose k). Therefore
(n choose k) = prod(i = 0, r) (ni choose ki) (mod p).

Theorem (Fermat's Little Theorem)
For every prime p and every integer a, with a != 0, a^(p-1) = 1 (mod p).
Proof:
Zp is a cyclic group with multiplicative group Zp^x = {1, 2, ... , p-1}, which has
p-1 elements. Notice that at least one of a, a^2, a^3, ..., a^(p-1) must be 1. Let
it be a^k. Because {a, a^2, ... , a^k} is a subgroup of Zp then, from Lagrange's
theorem, there is an integer h such that h * k = p - 1. And therefore:

a^(p-1) = a^(k * h) = (a^k)^h = 1^h = 1 (mod p)

Theorem (Chinese Remainder Theorem)
Let n1, n2, ... , nk > 1 be coprime integers. Let n = n1 * n2 * ... * nk. Let
a1, a2, ... , ak be integers such that 0 <= ai < ni, for i = 1, 2, ... , k. Then
there is an unique integer x modulo n such that x = ai (mod ni), for i = 1, 2, ... , k.
Proof:
Let Pi = n / ni, for i = 1, 2, ... , k. Let Ri be the modular inverse of Pi over
ni, which must exist as Pi is clearly coprime with ni.

Let x = sum(j = 1, k) aj * Pj * Rj

Then:

x = sum(j = 1, k) aj * Pj * Rj
  = ai * Pi * Ri
  = ai (mod ni)

Algorithm:
1. Calculate the (n choose k) (mod p), for each prime using Lucas' Theorem, which
splits the binomial into smaller ones.
2. Calculate the smaller ones using Fermat's little theorem.
3. Use the chinese remainder theorem to calculate (n choose k) (mod p1 * p2 * p3).
4. Add over the results.

=#

using Printf

# https://en.wikipedia.org/wiki/Fermat's_little_theorem
function fermat(n, k, p)
    if k > n - k
        return fermat(n, n - k, p)
    end
    num = 1
    for j in (n - k + 1):n
        num = (num * j) % p
    end
    fac = 1
    for j in 1:k
        fac = (fac * j) % p
    end
    den = 1
    for _ in 1:(p - 2)
        den = (den * fac) % p
    end
    return num * den
end

# https://en.wikipedia.org/wiki/Lucas%27s_theorem
function lucas(n, k, p)
    if k > n - k
        return lucas(n, n - k, p)
    end
    vn = n
    vk = k
    b = 1
    while vn > 0
        ni = vn % p
        ki = vk % p
        if ni < ki
            return 0
        end
        b = (b * fermat(ni, ki, p)) % p
        vn = fld(vn, p)
        vk = fld(vk, p)
    end
    return b
end

start = time()
result = 0

lower = 10^9
middle = 10^18 - 10^9 + 1
upper = 10^18
bound = 5000 - 1
n = 10^18
k = 10^9

primes = []
bin_res = []
slots = [true for _ in 1:bound]
slots[1] = false
for i in 2:bound
    global primes, slots, lower, middle, upper
    if slots[i]
        if i > 1000
            push!(primes, i)
            push!(bin_res, lucas(n, k, i))
        end
        for j in i:i:bound
            slots[j] = false
        end
    end
end

for p in 1:(length(primes) - 2)
    for q in (p + 1):(length(primes) - 1)
        for r in (q + 1):length(primes)
            global result
            m = primes[p] * primes[q] * primes[r]
            x = 0

            bin_p = bin_res[p]
            if bin_p != 0
                prod_p = primes[q] * primes[r]
                inv_p = invmod(prod_p, primes[p])
                x += bin_p * prod_p * inv_p
            end

            bin_q = bin_res[q]
            if bin_q != 0
                prod_q = primes[p] * primes[r]
                inv_q = invmod(prod_q, primes[q])
                x += bin_q * prod_q * inv_q
            end

            bin_r = bin_res[r]
            if bin_r != 0
                prod_r = primes[p] * primes[q]
                inv_r = invmod(prod_r, primes[r])
                x += bin_r * prod_r * inv_r
            end

            result += x % m
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
