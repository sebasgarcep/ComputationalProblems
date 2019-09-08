#=
Approach:

Let n be fixed. Then we this problem is equivalent to the following:

14^(n - 1) <= x < 14^n
x^2 = x (mod 14^n)

Thus:

x * (x - 1) = 0 (mod 14^n)

The trivial cases are x = 0 (which is not allowed) and x = 1. Now to the
non-trivial cases:

We have that 14^n | x * (x - 1). Because of both of the rightmost factors only
one can be even then 2^n | x or 2^n | (x - 1). Similarly, only one of
x or (x - 1) can be a multiple of 7. Thus 7^n | x or 7^n | (x - 1). Finally,
both 2^n and 7^n cannot fall on the same factor, otherwise we would have
14^n | (x - 1) or 14^n | x and thus either x >= 14^n + 1 or x >= 14^n, a
contradiction. So there are two cases:

Case 1: x = s * 2^n, x - 1 = t * 7^n
------------------------------------

This implies s * 2^n = 1 + t * 7^n, or equivalently:

1 = s * 2^n - t * 7^n

Which can be solved using the Euclidean Algorithm. Given a solution
we must find a value for k such that:

14^(n - 1) <= x = s * 2^n + k * 14^n < 14^n

Case 2: x = s * 7^n, x - 1 = t * 2^n
------------------------------------

Analogous to case 1.

=#

using Printf

function extended_euclidean(a, b)
    (curr_s, prev_s) = (0, 1)
    (curr_t, prev_t) = (1, 0)
    (curr_r, prev_r) = (b, a)
    while curr_r != 0
        quotient = fld(prev_r, curr_r)
        (prev_r, curr_r) = (curr_r, prev_r - quotient * curr_r)
        (prev_s, curr_s) = (curr_s, prev_s - quotient * curr_s)
        (prev_t, curr_t) = (curr_t, prev_t - quotient * curr_t)
    end
    return prev_s, prev_t # Bezout Coefficients
    # return prev_r # Greeatest Common Divisor
    # return curr_t, curr_s # Quotients by the GCD
end

function digit_sum(n, base)
    s = 0
    while n > 0
        s += mod(n, base)
        n = div(n, base)
    end
    return s
end

start = time()
result = 0

# Trivial case
result += 1

# Avoid repeats
found = Set()

for n = 1:10000
    b2 = BigInt(2)^n
    b7 = BigInt(7)^n
    b14l = BigInt(14)^(n - 1)
    b14u = BigInt(14)^n
    # Case 1
    (s, t) = extended_euclidean(b2, b7)
    t = -t
    x = mod(s * b2, b14u)
    if x >= b14l
        global result
        if !(x in found)
            push!(found, x)
            result += digit_sum(x, 14)
        end
    end
    # Case 2
    (s, t) = extended_euclidean(b7, b2)
    t = -t
    x = mod(s * b7, b14u)
    if x >= b14l
        global result
        if !(x in found)
            push!(found, x)
            result += digit_sum(x, 14)
        end
    end
end

println(result)
println(string(result, base=14))

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
