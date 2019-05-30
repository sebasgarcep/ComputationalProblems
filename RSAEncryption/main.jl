#=
Approach:
Notice that phi(n) = (p - 1) * (q - 1) = phi, and |Zn^x| = phi(n). Notice also that:

m^e = m (mod n)
m * (m^(e - 1) - 1) = 0 (mod n)
m = 0 or m^(e - 1) = 1 (mod n)

which implies several things. First, because e > 1, m^(e - 1) = m * m^(e - 2) = 1 (mod n)
implies m is invertible and thus gcd(m, n) = 1. Second, m generates a subgroup of
the multiplicative group Zn^x. Therefore if k is the order of m, then k | e - 1
and k | phi(n).

For this specific case notice that phi(n) = 2^5 * 3^3 * 7 * 607. Therefore if we
can find elements with orders 2, 3, 7, and 607 we can conclude that if e - 1 is
coprime to these prime numbers, then it attains the minimum number of unconcealed
messages.

It's easy to show that 11^611856 = 1 (mod n), and 611856 = 2^4 * 3^2 * 7 * 607.
Therefore:

- 11^(2^3 * 3^2 * 7 * 607) = 11^305928 has order 2
- 11^(2^4 * 3 * 7 * 607) = 11^203952 has order 3
- 11^(2^4 * 3^2 * 607) = 11^87408 has order 7
- 11^(2^4 * 3^2 * 7) = 11^1008 has order 607

Unfortunately, calculations show that there are no values of e for which e - 1 is
coprime to 2, 3, 7, and 607. Notice that if r^k | e - 1, with r prime, then r^(k - 1) | e - 1,
and therefore e - 1 leaves unconcealed all numbers of order r^k, r^(k - 1), r^(k - 2), ...
therefore, we want k to be as low as possible, in our case k = 1. Also, if r1, r2
are prime and r1 * r2 | e - 1, then e - 1 leaves unconcealed all numbers of order
r1 * r2, r1, and r2. Therefore it is desirable to have the least amount of prime
factors. In our case we can also have only one.

Therefore the value of e - 1 with the minimal amount of unconcealed numbers are ones
that are exclusively divisible by a 2, 3, 7, or 607, whichever of these generate
the smallest number unconcealed messages.

Also, we must exclude the values of e - 1 that are divisible by a power of the
prime we select, which can be checked by seeing if e - 1 is divisible by that
prime to the second power.

=#

using Printf

start = time()
result = 0

p = 1009
q = 3643
n = p * q
phi = (p - 1) * (q - 1)

#= Show that there no possible e values with e - 1 coprime to 2, 3, 7, and 607.
for e in 2:(phi - 1)
    global result
    if gcd(e, phi) == 1 &&
        (e - 1) % 2 != 0 &&
        (e - 1) % 3 != 0 &&
        (e - 1) % 7 != 0 &&
        (e - 1) % 607 != 0
        result += e
    end
end
=#

#= Find the number of unconcealed values it generates
e = 2 # 2, 3, 7, 607
for m in 0:(n - 1)
    global result
    if powermod(m, e, n) == 1
        result += 1
    end
end
=#

for e in 2:(phi - 1)
    global result
    if gcd(e, phi) == 1 &&
        (e - 1) % 2 == 0 &&
        (e - 1) % 4 != 0 &&
        (e - 1) % 3 != 0 &&
        (e - 1) % 7 != 0 &&
        (e - 1) % 607 != 0
        result += e
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
