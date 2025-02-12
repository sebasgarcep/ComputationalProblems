module PrimeSieve

struct Calculator
    limit::Int64
    is_prime::Vector{Bool}
    primes::Vector{Int64}

    function Calculator(limit::Int64)
        is_prime = [true for _ in 1:limit]
        primes = []
        is_prime[1] = false
        for p in 1:limit
            if is_prime[p]
                push!(primes, p)
                for k in (p^2):p:limit
                    is_prime[k] = false
                end
            end
        end
        return new(limit, is_prime, primes)
    end
end

end