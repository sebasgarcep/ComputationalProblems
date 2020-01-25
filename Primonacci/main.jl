#=
Approach:
Suppose we have the numbers 10^14 + 1, ... , 10^14 + 10^7. By the approximation to the prime counting
function there should be at least 10^5 primes in this range. Therefore we would like to efficiently
find the first 10^5 primes in this range. We can use the property that p is prime if no prime below
sqrt(p) divides it. Therefore we can find the primes up to sqrt(10^14 + 10^7), and sieve the numbers
in the range [10^14 + 1, 10^14^14 + 10^7] (we must be careful because, for each prime, the sieve will
not start in 10^14 + 1, but in the first number which is divisible by said prime).

Finally after we have each prime we have to calculate the fibonacci number at that position. Thanfully,
using the matrix form of the Fibonacci recursion it is trivial to find an O(logn) algorithm to compute
the nth fibonacci number, using binary multiplication.
=#

using Printf

function fast_fibonacci(n, m)
    if n <= 2
        return 1
    end
    s = Int128(n - 2)
    f = Int128(1)
    i, j, k, l = Int128(1), Int128(0), Int128(0), Int128(1)
    a, b, c, d = Int128(1), Int128(1), Int128(1), Int128(0)
    while f <= s
        if s & f != 0
            next_i = mod(mod(i * a, m) + mod(j * c, m), m)
            next_j = mod(mod(i * b, m) + mod(j * d, m), m)
            next_k = mod(mod(k * a, m) + mod(l * c, m), m)
            next_l = mod(mod(k * b, m) + mod(l * d, m), m)
            i, j, k, l = next_i, next_j, next_k, next_l
        end
        f = f << 1
        next_a = mod(powermod(a, 2, m) + mod(b * c, m), m)
        next_b = mod(mod(a * b, m) + mod(b * d, m), m)
        next_c = mod(mod(a * c, m) + mod(c * d, m), m)
        next_d = mod(mod(b * c, m) + powermod(d, 2, m), m)
        a, b, c, d = next_a, next_b, next_c, next_d
    end
    return convert(Int64, mod(i + j, m))
end

function main()
    start = time()
    result = 0

    # Problem parameters
    l = 10^14
    n = 10^5
    m = 1234567891011

    # Algorithm parameters
    s = 10^7

    # Solution
    # Find primes up to the square root using a prime sieve
    k = isqrt(l + s)
    next_slots = [p & 1 == 1 for p in 1:s]
    slots = [p & 1 == 1 for p in 1:k]
    slots[1] = false
    slots[2] = true
    for p in 3:2:k
        if slots[p]
            for t in p^2:p:k
                slots[t] = false
            end
            # Sieve the search range
            r = mod(l, p)
            for w in (p - r):p:s
                next_slots[w] = false
            end
        end
    end

    # Calculate the fibonacci number at that position
    total = 0
    for k in 1:s
        if next_slots[k]
            total += 1
            result = mod(result + fast_fibonacci(l + k, m), m)
            if total >= n
                break
            end
        end
    end

    if total < n
        println("Couldn't find enough primes.")
        return
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
