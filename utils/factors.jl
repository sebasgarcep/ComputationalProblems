module Factors

mutable struct FactorizationContext{T<:Integer}
    remaining::T
    curr::T
end

function begin_factorization(value::T)::FactorizationContext{T} where {T<:Integer}
    return FactorizationContext(value, 2::T)
end

function get_next_factor(context::FactorizationContext{T})::Union{Tuple{T, T}, Nothing} where {T<:Integer}
    # Even case
    if context.curr == 2::T
        context.curr += 1::T  # Increment in any case
        expo = 0::T
        while context.remaining & 1::T == 0::T
            context.remaining >>= 1
            expo += 1::T
        end
        if expo > 0::T
            return (2::T, expo)
        end
    end
    # Odd case
    for divisor in context.curr:(2::T):isqrt(context.remaining)
        expo = 0::T
        while context.remaining % divisor == 0::T
            context.remaining = fld(context.remaining, divisor)
            expo += 1::T
        end
        if expo > 0::T
            context.curr = divisor + 2::T
            return (divisor, expo)
        end
    end
    # Prime remainder
    if context.remaining > 1::T
        remaining = context.remaining
        context.remaining = 1::T
        return (remaining, 1::T)
    end
    return nothing
end

function get_factors(value::T)::Vector{Tuple{T, T}} where {T<:Integer}
    factorization = begin_factorization(value)
    factors = []
    while true
        item = get_next_factor(factorization)
        if item == nothing
            break
        end
        divisor, expo = item
        push!(factors, (divisor, expo))
    end
    return factors
end

function get_divisors(value::T)::Vector{T} where {T<:Integer}
    factors = get_factors(value)
    divisors::Vector{T} = []
    get_divisors_recursive_internal(factors, divisors, 1::T, 1::T)
    return sort(divisors)
end

function get_divisors_recursive_internal(
    factors::Vector{Tuple{T, T}},
    divisors::Vector{T},
    k::T,
    a::T
) where {T<:Integer}
    if k > length(factors)
        push!(divisors, a)
        return
    end
    (p, e) = factors[k]
    factor = 1::T
    for _ in (0::T):e
        get_divisors_recursive_internal(factors, divisors, k + 1, a * factor)
        factor *= p
    end
end

end
