#=
Approach:
Notice that 13082761331670030 = 2 * 3 * 7 * ... * 43 is the product of the first
14 primes. Therefore we only need to solve the equation for each prime and then
use the chinese remainder theorem to stitch up all solutions. Notice also that:

x^3 - 1 = 0 (mod p)
(x - 1) * (x^2 + x + 1) = 0 (mod p)

The trivial solution is x = 1. Therefore we now only need to find solutions to
x^2 + x + 1 = 0 (mod p), which can be easily found using brute force.
=#

using Printf

function search(result, primes, soln, idx, path)
    if idx > length(primes)
        y = prod(primes)
        s = 0
        for i in 1:length(primes)
            ni = primes[i]
            yi = fld(y, ni)
            zi = invmod(yi, ni)
            ai = path[i]
            s += ai * yi * zi
        end
        result += mod(s, y)
        return result
    end
    for item in soln[idx]
        next_path = copy(path)
        push!(next_path, item)
        result = search(result, primes, soln, idx + 1, next_path)
    end
    return result
end

function main()
    start = time()

    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]
    # primes = [7, 13]

    soln = []
    for p in primes
        data = [x for x in 1:(p-1) if x == 1 || mod(x^2 + x + 1, p) == 0]
        push!(soln, data)
    end

    result = search(0, primes, soln, 1, []) - 1

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
