using Printf

function get_points(n::Int64)
    s = 290797
    l = 50515093

    points = []
    for _ in 1:n
        x = s
        s = mod(s * s, l)
        y = s
        s = mod(s * s, l)
        push!(points, (x, y))
    end

    return points
end

function x_coordinate(p)
    (x, y) = p
    return x
end

function calc_distance(xs, ys, xt, yt)
    return sqrt((xs - xt)^2 + (ys - yt)^2)
end

mutable struct Context
    points
    result
end

function min_distance(context, i, j)
    if j - i <= 200
        result = Inf
        for s in i:(j - 1)
            (xs, ys) = context.points[s]
            for t in (s + 1):j
                (xt, yt) = context.points[t]
                result = min(result, calc_distance(xs, ys, xt, yt))
            end
        end
        context.result = min(context.result, result)
        return result
    end

    k = (i + j) >> 1
    dl = min_distance(context, i, k)
    dr = min_distance(context, k + 1, j)
    t = min(context.result, dl, dr)

    (xk, yk) = context.points[k]
    (xr, yr) = context.points[k + 1]
    x = (xk + xr) / 2.0

    xu = Int64(floor(x - t / 2.0))
    su = i
    tu = j
    u = 0
    while true
        u = (su + tu) >> 1
        if su == u # tu - su <= 1
            if context.points[u][1] < xu
                u = u + 1
            end
            break
        elseif xu > context.points[u + 1][1]
            su = u
        elseif context.points[u][1] >= xu
            tu = u
        else # context.points[u][1] < xu && xu <= context.points[u + 1][1]
            u = u + 1
            break
        end
    end

    xv = Int64(ceil(x + t / 2.0))
    sv = i
    tv = j
    v = 0
    while true
        v = (sv + tv) >> 1
        if sv == v # tv - sv <= 1
            if xv >= context.points[v + 1][1]
                v = v + 1
            end
            break
        elseif context.points[v][1] > xv
            tv = v
        elseif xv >= context.points[v + 1][1]
            sv = v
        else # context.points[v][1] <= xv && xv < context.points[v + 1][1]
            break
        end
    end

    result = min(t, min_distance(context, u, v))
    context.result = min(context.result, result)
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 2000000

    # Algorithm parameters

    # Solution
    points = collect(Set(get_points(n)))
    sort!(points, by=x_coordinate)

    context = Context(points, Inf)
    result = min_distance(context, 1, length(points))

    # Show result
    @printf("Took: %.9f secs\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
