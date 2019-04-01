#=
Approach:
=#

using Printf

function weight(v)
    r = 1
    u = length(v)
    for k in 1:u
        p = v[k]
        r *= binomial(10, p)
    end
    return r
end

function numcolors(v)
    r = 0
    u = length(v)
    for k in 1:u
        if v[k] > 0
            r += 1
        end
    end
    return r
end

s = 0
t = 0

function search(v)
    global s, t
    if length(v) >= 7
        m = weight(v)
        n = numcolors(v)
        s += m * n
        t += m
        return
    end
    if length(v) == 6
        p = 20 - sum(v)
        if p <= 10 && p >= 0
            next_v = copy(v)
            push!(next_v, p)
            search(next_v)
        end
        return
    end
    upper = min(10, length(v) == 0 ? 20 : 20 - sum(v))
    for n in 0:upper
        next_v = copy(v)
        push!(next_v, n)
        search(next_v)
    end
end

start = time()

search([])

result = s / t
@printf("%.9f\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
