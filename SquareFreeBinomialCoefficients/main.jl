#=
Approach:
Traverse the left side of Pascal's triangle as it is symmetric. Find the largest
value in the first 51 lines, then use its square root to sieve the primes. Finally,
for each element in Pascal's triangle test whether one of the squares of the primes
divides it.
=#

using Printf

start = time()
result = 0

lines = 51 - 1
result_set = Set()
bound_sq = binomial(lines, fld(lines, 2))
bound = isqrt(bound_sq)

primes_sq = []
slots = [true for _ in 1:bound]
for n in 2:bound
    if slots[n]
        push!(primes_sq, n^2)
        for k in (2 * n):n:bound
            slots[k] = false
        end
    end
end

for n = 0:lines
    for k in 0:fld(n, 2)
        v = binomial(n, k)
        square_free = true
        for elem in primes_sq
            if elem > v
                break
            end
            if v % elem == 0
                square_free = false
                break
            end
        end
        if square_free
            push!(result_set, v)
        end
    end
end

result = sum(result_set)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
