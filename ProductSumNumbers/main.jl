#=
Approach:

Notice that for a given k, 2 * k = 2 * k * 1^(k - 2) = 2 + k + 1 * (k - 2). Therefore
we only need to search up to 24000. For each number we need to find each of its
possible factorizations and test the value of k that factorization produces. In
other words, if m = p1 * p2 * ... * ps, then:

p1 * p2 * ... * ps = p1 + p2 + ... + ps + 1 * (p1 * p2 * ... * ps - p1 - p2 - ... - ps)

and therefore k = s + p1 * p2 * ... * ps - p1 - p2 - ... - ps. Finally to obtain
all possible factorizations of a number m, notice that at least one of the pi's
must be smaller than sqrt(m) (otherwise we are just left with a single factor).
Therefore we can recursively factorize m by setting:

m = pi * (m / pi)

and factorizing m / pi until we find all the desired factors.
=#

using Printf

bound = 12000

function factorize(result_set, found, m, factors)
    if length(factors) >= 1
        if m == 1
            num_factors = length(factors)
            prod_factors = prod(factors)
            sum_factors = sum(factors)
        else
            num_factors = length(factors) + 1
            prod_factors = prod(factors) * m
            sum_factors = sum(factors) + m
        end
        k = num_factors + prod_factors - sum_factors

        if k >= 1 && k <= bound && !found[k]
            found[k] = true
            push!(result_set, prod_factors)
        end
    end

    for p in 2:isqrt(m)
        if m % p != 0
            continue
        end
        next_m = fld(m, p)
        next_factors = copy(factors)
        push!(next_factors, p)
        factorize(result_set, found, next_m, next_factors)
    end

    return result
end

start = time()
result = 0

result_set = Set()
found = [false for _ in 1:bound]

for m in 2:(2 * bound)
    global result_set
    factorize(result_set, found, m, [])
end

result = sum(result_set)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
