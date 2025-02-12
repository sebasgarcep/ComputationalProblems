module TwoSidedCache

export Cache, get, set

struct Cache
    bound::Int64
    limit::Int64
    lo::Vector{Union{Nothing, Int64}}
    hi::Vector{Union{Nothing, Int64}}

    function Cache(bound, limit)
        cache_lo = [nothing for _ in 1:limit]
        cache_hi = [nothing for _ in 1:limit]
        return new(
            bound,
            limit,
            cache_lo,
            cache_hi
        )
    end
end

function get(this::Cache, x::Int64)::Union{Nothing, Int64}
    if x <= 0 || this.bound < x
        return nothing
    elseif x <= this.limit
        return this.lo[x]
    else # limit < x <= bound
        # Estimate k
        k = fld(this.bound, x)
        # is cacheable if [N/k] = x
        is_cacheable = fld(this.bound, k) == x
        if is_cacheable
            return this.hi[k]
        end
        return nothing
    end
end

function set(this::Cache, x::Int64, v::Int64)
    if x <= 0 || this.bound < x
        return
    elseif x <= this.limit
        this.lo[x] = v
    else # limit < x <= bound
        # Estimate k
        k = fld(this.bound, x)
        # is cacheable if [N/k] = x
        is_cacheable = fld(this.bound, k) == x
        if is_cacheable
            this.hi[k] = v
        end
    end
end

end