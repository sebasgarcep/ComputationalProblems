#=
Approach:
I noticed that Case 1 solutions and Case 2 solutions for n also work for n-1 when
the leading digit is truncated. So we only need to find a solution for n = 10000
and work backwards from it. To prove this notice that x is a solution to:

14^(n - 1) <= x < 14^n
x^2 = x (mod 14^n)

Thus 14^n | (x^2 - x) therefore 14^(n - 1) | (x^2 - x) and thus x^2 = x (mod 14^(n-1)).
The first condition's upper limit is satisfied by taking x mod 14^(n - 1). The lower
limit has to be tested for though.

Because for each non-trivial case and every n there is only one solution, then this
method allows us to find the correct solution very rapidly.
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

function digit_value(d)
    if d == '0'
        return 0
    elseif d == '1'
        return 1
    elseif d == '2'
        return 2
    elseif d == '3'
        return 3
    elseif d == '4'
        return 4
    elseif d == '5'
        return 5
    elseif d == '6'
        return 6
    elseif d == '7'
        return 7
    elseif d == '8'
        return 8
    elseif d == '9'
        return 9
    elseif d == 'a'
        return 10
    elseif d == 'b'
        return 11
    elseif d == 'c'
        return 12
    elseif d == 'd'
        return 13
    end
end

#=
    Each digit appears in the sum once for every leading digit plus itself,
    minus the number of times a leading digit is a zero.
=#
function result_count(sx, n)
    tot = 0
    mult = collect(1:n)
    numz = 0
    for i in 1:n
        dig = digit_value(sx[i])
        if dig == 0
            numz += 1
        end
        tot += dig * (mult[i] - numz)
    end
    return tot
end

start = time()
result = 0

result += 1

n = 10000

b2 = BigInt(2)^n
b7 = BigInt(7)^n
b14 = BigInt(14)^n

# Case 1
(s, t) = extended_euclidean(b2, b7)
t = -t
x = mod(s * b2, b14)
sx = string(x, base=14)
result += result_count(sx, n)

# Case 2
(s, t) = extended_euclidean(b7, b2)
t = -t
x = mod(s * b7, b14)
sx = string(x, base=14)
result += result_count(sx, n)

println(result)
println(string(result, base=14))

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
