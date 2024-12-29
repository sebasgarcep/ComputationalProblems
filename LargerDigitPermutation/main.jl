using Printf

function search(k::Int64, d::Int64, y_0::Int64, y::Vector{Int64}, i::Int64)::Int64
    if i == d - 1
        y[i] = k - y_0 - sum(y[1:(i - 1)])
        if y[i] > y[i - 1]
            return 0
        end
        return solve(k, d, y_0, y)
    end
    if i == 1
        limit = k - y_0
    else
        limit = min(y[i - 1], k - y_0 - sum(y[1:(i - 1)]))
    end
    result = 0
    for y_i in 0:limit
        y[i] = y_i
        result += search(k, d, y_0, y, i + 1)
    end
    return result
end

function solve(k::Int64, d::Int64, y_0::Int64, y::Vector{Int64})::Int64
    set_size = multinomial(y) * multinomial([k - y_0 - 1, y_0])
    first_term = (set_size * (set_size - 1)) >> 1
    z = zeros(Int64, k + 1)
    for i in 1:(d - 1)
        z[y[i] + 1] += 1
    end
    second_term = multinomial(z)
    return first_term * second_term
end

function multinomial(v::Vector{Int64})::Int64
    total = 0
    denom = 1
    for i in 1:length(v)
        total += v[i]
        denom *= factorial(v[i])
    end
    numer = factorial(total)
    return fld(numer, denom)
end

function factorial(n::Int64)::Int64
    result = 1
    for i in 2:n
        result *= i
    end
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k = 12
    d = 10

    # Algorithm parameters

    # Solution
    for y_0 in 0:(k - 1)
        y = zeros(Int64, d - 1)
        result += search(k, d, y_0, y, 1)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
