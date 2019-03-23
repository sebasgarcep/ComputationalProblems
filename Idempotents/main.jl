#=
Approach:
Let N = p1^k1 * p2^k2 * ... * pm^km. Then:
x^2 = x (mod N) <-> x * (x - 1) = 0 (mod N)
                <-> N | x * (x - 1)
                <-> pi^ki | x * (x - 1), i = 1, 2, ... , m
                <-> pi^ki | x or pi^ki | x - 1, i = 1, 2, ... , m
                <-> x = 0 (mod pi^ki) or x = 1 (mod pi^ki), i = 1, 2, ... , m

Applying the chinese remainder theorem we get that there are only 2^m solutions to
this problem.

Clearly M(1) = 0 and M(p^k) = 1. Because the value for M(n) is a multiple or 1
more than the largest prime power of n, we can test all multiple of this prime
power to find the value for M(n).
=#

using Printf

function search(largest, n)
    if n == 1
        return 0
    end
    if n == largest[n]
        return 1
    end
    upper = n - largest[n]
    step = -largest[n]
    for a in upper:step:1
        x = a + 1
        if (x^2 - x) % n == 0
            return x
        end
        x = a
        if (x^2 - x) % n == 0
            return x
        end
    end
end

start = time()

result = 0

bound = 10^7
largest = [1 for _ in 1:bound]
for p in 2:bound
    global largest
    if largest[p] > 1
        continue
    end
    r = p
    while r <= bound
        for k in r:r:bound
            if r > largest[k]
                largest[k] = r
            end
        end
        r *= p
    end
end

for n in 1:bound
    global largest
    global result
    result += search(largest, n)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

