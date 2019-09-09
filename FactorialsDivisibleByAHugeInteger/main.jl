#=
Approach:
Suppone we know N(i). Then N(i+1) >= N(i), because i!^1234567890 | (i+1)!^1234567890 | N(i+1)!,
and by definition N(i) is the smallest number such that i!^1234567890 divides it. Suppose we know
N(i) and i+1 = q1^k1 * q2^k2 * ... * qr^kr. Therefore for each qj we only need to find the smallest
value of N(i+1) such that N(i+1)! has a multiplicity of qj of at least (kj+sj)*1234567890, where sj
is the multiplicity of qj in N(i). The final value for N(i+1) is the largest we found over all the
factors.

The minimal multiplicity of any prime factor on a factorial is found using binary search.
=#

using Printf

function factor_multiplicity(n, k)
    r = 0
    nr = n
    while mod(nr, k) == 0
        r += 1
        nr = fld(nr, k)
    end
    return r
end

function prime_multiplicity_factorial(n, p)
    s = 0
    i = 0
    pu = Int128(p)
    pi = Int128(1)
    while true
        i += 1
        pi *= pu
        v = fld(n, pi)
        if v == 0
            break
        end
        s += v
    end
    return s
end

function min_factorial_multiplicity(p, r)
    # The least number is clearly 0
    # The largest number is p * r as by that point
    # we would have at least r multiples of p
    ub = p * r
    lb = 0
    while abs(ub - lb) > 1
        t = fld(ub + lb, 2)
        v = prime_multiplicity_factorial(t, p)
        if v == r
            ub = t
            lb = t
        elseif v > r
            ub = t
        else # v < r
            lb = t
        end
    end
    # The smallest number for which the multiplicity of p
    # in its factorial is r must be a multiple of p. Thus
    # if we get any other value we must adjust by subtracting
    # the excess from the obtained value.
    return ub - mod(ub, p)
end

start = time()
result = 0

u = 1000000
m = 10^18

slots = [true for _ in 1:u]
slots[1] = false
data = []
for _ in 1:u
    push!(data, [])
end
for i in 2:u
    if slots[i]
        for t in (2*i):i:u
            slots[t] = false
            push!(data[t], (i, factor_multiplicity(t, i)))
        end
    end
end

factors = Dict()
acc = 1
for i in 2:u
    global factors
    global acc
    global result
    if slots[i]
        factors[i] = 1
        acc = max(acc, min_factorial_multiplicity(i, 1234567890))
    else
        for (p, k) in data[i]
            factors[p] += k
            acc = max(acc, min_factorial_multiplicity(p, factors[p] * 1234567890))
        end
    end
    if i >= 10
        result += acc
        result = mod(result, m)
    end
end

println(result)
elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
