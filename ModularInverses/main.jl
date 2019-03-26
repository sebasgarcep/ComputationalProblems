#=
Approach:
Let N = p1^k1 * p2^k2 * ... * pm^km, and pi != 2. Then:
x^2 = 1 (mod N) <-> (x - 1) * (x + 1) = 0 (mod N)
                <-> N | (x - 1) * (x + 1)
                <-> pi^ki | (x - 1) * (x + 1), i = 1, 2, ... , m
                <-> pi^ki | x - 1 or pi^ki | x + 1, i = 1, 2, ... , m
                <-> x = 1 (mod pi^ki) or x = -1 (mod pi^ki), i = 1, 2, ... , m

Now let N = 2^k. If k = 1 then x = 1. If k = 2 then x = 1 or x = 3. If k = 3, then
x = 1 or x = 3 or x = 5 or x = 7. Let k >= 3. We will now prove that x = +-1 or
x = +-(1 + 2^k-1) (mod N). Clearly the statement is true for k = 3. Assume the
statement is true for k and assume x is a solution to the equation. Then
2^k+1 | x^2 - 1 -> 2^k | x^2 - 1, i.e. x is a solution to the problem for N = 2^k.
Therefore x is either of:

1. +- 1 (mod 2^k+1)
2. +- (1 + 2^k) (mod 2^k+1)
3. +- (1 + 2^k-1) (mod 2^k+1)
4. +- (1 + 2^k-1 + 2^k) (mod 2^k+1)

Clearly 1 and 2 are solutions. For 3:
(+- (1 + 2^k-1))^2 = (1 + 2^k-1)^2
                   = 1 + 2^k + 2^2k-2
                   = 1 + 2^k
                   != 1 (mod 2^k+1)

Therefore 3 is not a solution. For 4:
(+- (1 + 2^k-1 + 2^k))^2 = (1 + 2^k-1 + 2^k)^2
                         = 1 + 2^2k-2 + 2^2k + 2^k + 2^2k + 2^k+1
                         = 1 + 2^k

Therefore 4 is not a solution.

Our approach takes the largest prime factor. If that factor is 2^k, then we test
for the previous 4 solutions every 2^k numbers. Otherwise, if that factor is p^k
then we test for p^k | x - 1 or p^k | x + 1, every p^k numbers.
=#

using Printf
import Distributed

function ilog2(n)
    k = 0
    v = n
    while v > 1
        k = k + 1
        v = v >> 1
    end
    return k
end

function search(n, largest)
    upper = n - largest
    step = -largest
    # If largest = 4, then n = 4 and search = 1 or n = 12 and search = 7.
    if n == 4
        return 1
    elseif n == 12
        return 7
    elseif mod(largest, 2) == 0
        surrogate = fld(largest, 2)
        for a in upper:step:0
            x = a + surrogate + 1
            if mod(x^2 - 1, n) == 0
                return x
            end
            x = a + largest - surrogate - 1
            if mod(x^2 - 1, n) == 0
                return x
            end
            x = a + 1
            if mod(x^2 - 1, n) == 0
                return x
            end
            x = a - 1
            if mod(x^2 - 1, n) == 0
                return x
            end
        end
    else
        for a in upper:step:0
            x = a + 1
            if mod(x^2 - 1, n) == 0
                return x
            end
            x = a - 1
            if mod(x^2 - 1, n) == 0
                return x
            end
        end
    end
end

start = time()

result = 0

bound = 2 * 10^7
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

for n in 3:bound
    global result
    result += search(n, largest[n])
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
