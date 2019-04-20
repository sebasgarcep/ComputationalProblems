#=
Approach:
Let N = p1^k1 * p2^k2 * ... * p^m^km. Then the number of divisors (d) of N is:
(k1 + 1) * (k2 + 1) * ... * (km + 1). Let p1 < p2 < ... < pm. Because d = 2^500500,
ki = 2^s - 1, i = 1, 2, ..., m, and for some integer s. Notice that
2^s - 1 = 1 + 2 + 2^2 + 2^3 + ... + 2^(s - 1). Therefore:
pi^ki = p^1 * p^2 * p^4 * p^8 * p^(2^(s - 1)). We then solve the problem with a greedy
approach: Start with a list of the first 500500 primes. Pick the smallest one,
multiply it with the accumulator. Then square it and perform a sorted insert of the
new element to the list. Finish after 500500 rounds. Notice that when the list is
in sorted order, picking the smallest unpicked elements is equivalent to picking
the first few indexes of the list.
=#

using Printf

function modpow(x, n, m)
    mask = reverse(string(n, base = 2))
    p = BigInt(1)
    s = x
    for k in 1:length(mask)
        if mask[k] == '1'
            p = mod(p * s, m)
        end
        s = mod(s * s, m)
    end
    return p
end

function sorted_insert(a, e)
    lower = 1
    upper = length(a)
    while upper - lower > 1
        test = fld(lower + upper, 2)
        if a[test] == e
            lower = test
            upper = test
        elseif a[test] < e
            lower = test
        else
            upper = test
        end
    end
    insert!(a, upper, e)
end

start = time()
result = BigInt(1)

d = 500500
m = 500500507

limit = 83 * 10^5
slots = [true for _ in 1:limit]
slots[1] = false
primes = []
for n in 2:limit
    global primes, slots
    if !slots[n]
        continue
    end
    push!(primes, BigInt(n))
    for k in (2 * n):n:limit
        slots[k] = false
    end
end

values = primes[1:d]

for pos in 1:d
    global values
    global result
    result = mod(result * values[pos], m)
    sorted_insert(values, values[pos]^2)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
