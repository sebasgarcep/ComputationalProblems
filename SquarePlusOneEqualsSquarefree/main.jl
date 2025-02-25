include("../includes.jl")

using Printf
using Primes

using .PrimeSieve
using .QuadraticResidue: tonelli_shanks, hensel_lifting
using .PellEquation
using .ChineseRemainderTheorem

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 123567101113

    # Algorithm parameters
    limit = 10^8 # 10^8
    if limit < isqrt(n)
        throw(error("Limit should not be smaller than sqrt(n)."))
    end

    # Solution
    sieve = PrimeSieve.Calculator(limit)
    n = Int128(n)
    limit = Int128(limit)

    # Initialize sign first
    sign_memo = Int128[1 for _ in 1:limit]
    for p in sieve.primes
        if mod(p, 4) != 1
            for k in p:p:limit
                sign_memo[k] = 0
            end
        end

        for k in p^2:p^2:limit
            sign_memo[k] = 0
        end

        for k in p:p:limit
            sign_memo[k] *= -1
        end
    end

    # Now initialize data
    data = []
    sizehint!(data, limit)
    for k in 1:limit
        push!(
            data,
            sign_memo[k] == 0
                ? nothing
                : InclusionExclusionData(sign_memo[k]),
        )
    end

    # Put primes into structure that will reduce work
    primes = reverse([Int128(p) for p in sieve.primes if mod(p, 4) == 1])

    # Compute inclusion-exclusion data for each term
    for p in primes
        a, b = solve_quad(p)
        for k in p:p:limit
            item = data[k]
            if item === nothing
                continue
            end
            item.solutions = filter(
                x -> x <= n,
                vcat(
                    ChineseRemainderTheorem.solve.(item.solutions, item.value^2, a, p^2),
                    ChineseRemainderTheorem.solve.(item.solutions, item.value^2, b, p^2),
                )
            )
            item.value *= p
        end
    end

    # Compute inclusion-exclusion
    result += n
    for k in 2:limit
        item = data[k]
        if item === nothing
            continue
        end
        for x in item.solutions
            result += item.sign * (1 + fld(n - x, item.value^2))
        end
    end

    # Use Pell equations to solve for large values of y
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
    start = time()
    
    # Put primes into a more usable structure for factoring
    primes = reverse(primes)

    found = Set()
    for k in 1:fld(n^2 + 1, limit^2)
        if k == isqrt(k)^2
            continue
        end
        convergents = PellEquation.SquareRootConvergents(k)
        while true
            x, y = PellEquation.next_convergent(convergents)
            if x > n
                break
            end
            if y > limit && !(x in found) && x^2 - k * y^2 == -1
                push!(found, x)
                # Factor x^2 + 1 = k * y^2
                factors_k = factorize(primes, Int128(k))
                factors_y = factorize(primes, Int128(y))
                factors = Dict()
                for (p, e) in factors_k
                    factors[p] = get(factors, p, 0) + e
                end
                for (p, e) in factors_y
                    factors[p] = get(factors, p, 0) + 2 * e
                end
                prime_factors = []
                for (p, e) in pairs(factors)
                    if p <= limit && e >= 2
                        push!(prime_factors, p)
                    end
                end
                # Has not been sieved out by smaller primes
                if isempty(prime_factors)
                    result -= 1
                else # Has been sieved out, but the sieve might be incomplete
                    for f in 0:(2^length(prime_factors) - 1)
                        v = Int128(1)
                        s = Int128(1)
                        for i in eachindex(prime_factors)
                            if f & (1 << (i - 1)) != 0
                                v *= prime_factors[i]
                                s *= -1
                            end
                        end
                        if v > limit
                            result += s
                        end
                    end
                end
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

mutable struct InclusionExclusionData
    sign::Int128
    value::Int128
    solutions::Vector{Int128}

    function InclusionExclusionData(sign::Int128)
        return new(sign, Int128(1), Int128[0])
    end
end

function f_quad(x)
    return x^2 + 1
end

function f_quad_prime(x)
    return 2 * x
end

"""
Solves x^2 + 1 = 0 (mod p^2)
"""
function solve_quad(p)
    a, b = tonelli_shanks(-1, p)
    a_2 = hensel_lifting(f_quad, f_quad_prime, p, 1, a)
    b_2 = hensel_lifting(f_quad, f_quad_prime, p, 1, b)
    return Int128(a_2), Int128(b_2)
end

"""
Factorize factors of x^2+1. Is only divisible by 2 (not 4, 8, ...) and powers of
primes of the form 4k+1.
"""
function factorize(primes::Vector{Int128}, n::Int128)::Vector{Tuple{Int128, Int128}}
    factors = []
    v = n
    if v & 1 == 0
        v = v >> 1
        push!(factors, (2, 1))
    end
    for p in primes
        if p^2 > v
            break
        end
        e = 0
        while mod(v, p) == 0
            e += 1
            v = fld(v, p)
        end
        if e > 0
            push!(factors, (p, e))
        end
        if v <= 1
            break
        end
    end
    if v > 1
        push!(factors, (v, 1))
    end
    return factors
end

main()
