include("../includes.jl")

using Printf

using .PrimeSieve
using .ChineseRemainderTheorem

function main()
    # Problem parameters
    n = 10^17

    # Algorithm parameters

    # Solution
    sieve = PrimeSieve.Calculator(10^3)
    primes = [BigInt(p) for p in sieve.primes]
    result = BigInt(2) * BigInt(n)

    solutions = [BigInt(0)]
    acc = BigInt(1)
    for i in eachindex(primes)
        p_curr = primes[i]

        # Calculate next solutions
        new_solutions = BigInt[]
        for u::BigInt in 0:7:(p_curr - 1)
            for x in solutions
                new_x = ChineseRemainderTheorem.solve(x, acc, u, p_curr)
                if (
                    (new_x == BigInt(0) && acc * p_curr <= BigInt(n)) ||
                    (new_x != BigInt(0) && new_x <= BigInt(n))
                )
                    push!(new_solutions, new_x)
                end
            end
        end

        # Update solutions and accumulator
        solutions = new_solutions
        acc *= p_curr

        # Early exit
        if isempty(solutions)
            break
        end

        # Calculate sum
        p_next = primes[i + 1]
        p_diff = p_next - p_curr
        summation = BigInt(0)
        for x in solutions
            summation += (
                (x != BigInt(0) ? BigInt(1) : BigInt(0)) +
                fld(BigInt(n) - x, acc)
            )
        end
        result += p_diff * summation
    end

    return result
end

@time println(main())
