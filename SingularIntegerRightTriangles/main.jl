#=
Approach:
Let m, n be arbitrary integers with m > n > 0. Let a = m^2 - n^2, b = 2 * m * n,
c = m^2 + n^2. Then:

a^2 + b^2 = m^4 - 2 * m^2 * n^2 + n^4 + 4 * m^2 * n^2
          = m^4 + 2 * m^2 * n^2 + n^4
          = (m^2 + n^2)^2
          = c^2

Therefore (a, b, c) is a pythagorean triple. Notice that:

a + b + c = m^2 - n^2 + 2 * m * n + m^2 + n^2
          = 2 * m^2 + 2 * m * n
          = 2 * m * (m + n)

Because the previous expression takes its lowest value when n = 1, then:

2 * m * (m + 1) <= 1'500'000.

Therefore, solving for m, we get m <= 865.

(https://en.wikipedia.org/wiki/Pythagorean_triple)

Notice that if (a, b, c) is a pythagorean triple, then (k * a, k * b, k * c) is
also one. Now lets prove that all primitive triples arise from some combination
of coprime n and m. Let a, b, c be coprime and satisfy a^2 + b^2 = c^2. Then a, b,
c are pairwise coprime. Then at least one of a and b must be odd. Without loss of
generality, let it be a. Then, if c is even, c^2 = 0 mod 4. Because odd squares
are 1 mod 4, then a^2 and b^2 need to be even squares for a^2 + b^2 = 0 mod 4.
Therefore a and b are even, which is a contradiction. Therefore c is odd, and b
must be even (as b^2 = c^2 - a^2 is the difference of two odds and therefore is
even). Now notice that b^2 = c^2 - a^2 = (c - a) * (c + a), and therefore:

(c + a)/b = b/(c - a)

Let (c + a)/b = m/n, where m and n are coprime integers. Thus (c - a)/b = n/m. Then,
solving for c/b and a/b we get:

c/b = 1/2 * (m/n + n/m) = (m^2 + n^2) / (2 * n * m)
a/b = 1/2 * (m/n - n/m) = (m^2 - n^2) / (2 * n * m)

Assume both m and n are odd. Then m^2 = 1 mod 4, n^2 = 1 mod 4, and therefore
m^2 - n^2 = 0 mod 4. Therefore m^2 - n^2 is a multiple of 4 and 2 * m * n is not.
Therefore a/b has at least an extra factor of 2 in the numerator, i.e. a is even,
which is a contradiction. Therefore one of m and n is odd and the other is even
(both cannot be even, or they wouldn't be coprime). Therefore both m^2 + n^2 and
m^2 - n^2 are odd, and the fractions are fully reduced, as no number can divide
both m and n, and no factor of 2 exists in the numerator of both fractions. By
equation numerators and denominators we obtain the desired result.

Because all pythagorean triples are either primitive or a multiple of a primitive
triple, then we only need to find primitive pythagorean triples and their multiples.
=#

using Printf

start = time()
result = 0

l = 1500000
count = zeros(l)

for m in 2:865
    for n in 1:(m - 1)
        global count
        if gcd(m, n) != 1
            continue
        end
        a = m^2 - n^2
        b = 2 * m * n
        c = m^2 + n^2
        if gcd(a, gcd(b, c)) != 1
            continue
        end
        v = a + b + c
        k = 1
        while k * v <= l
            count[k * v] += 1
            k += 1
        end
    end
end

for i in 1:l
    global result
    if count[i] == 1
        result += 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
