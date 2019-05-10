#=
Approach:
Pythagorean triples can be generated using the following equations:

a = m^2 - n^2
b = 2 * m * n
c = m^2 + n^2

where m > n > 0, m and n are coprime and m + n is odd. Notice that:

a + b + c <= 100'000'000
m^2 - n^2 + 2 * m * n + m^2 + n^2 <= 100'000'000
m^2 + 2 * m * n + m^2 <= 100'000'000
m^2 + m * n <= 50'000'000
m * (m + n) <= 50'000'000

Therefore m takes its highest value when n = 1. Therefore:

m * (m + 1) <= 50'000'000

Therefore m <= 7070.57, after solving the inequality.

Notice also that whenever (a, b, c) is a pythagorean triple, then for any integer
k, (k * a, k * b, k * c) is a pythagorean triple too.

=#

using Printf

start = time()
result = 0

limit = 10^8

for m in 2:7070
    for n in (m - 1):-1:1
        if gcd(m, n) != 1
            continue
        end

        a = m^2 - n^2
        b = 2 * m * n
        c = m^2 + n^2

        if gcd(a, b) != 1
            continue
        end

        k = 1
        s = abs(b - a)
        if mod(c, s) == 0
            while k * (a + b + c) <= limit
                global result
                result += 1
                k += 1
            end
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
