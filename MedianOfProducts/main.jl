using Printf

function f(s_list, n, m)
    value = 0
    for j in 2:n
        if s_list[j - 1] * s_list[j] < m
            value += j - 1
            continue
        end
        if m < s_list[1] * s_list[j]
            break
        end
        lower = 1
        upper = j - 1
        while upper - lower > 1
            midpoint = (lower + upper) >> 1
            if s_list[midpoint] * s_list[j] == m
                lower = midpoint
                upper = midpoint
            elseif s_list[midpoint] * s_list[j] < m
                lower = midpoint
            else
                upper = midpoint
            end
        end
        if s_list[upper] * s_list[j] <= m
            value += upper
        else
            value += lower
        end
    end
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1000003

    # Algorithm parameters

    # Solution
    s = 290797
    s_list = []
    push!(s_list, s)
    for i in 1:(n - 1)
        s = mod(s^2, 50515093)
        push!(s_list, s)
    end
    s_list = sort(s_list)

    midpoint = ((n * (n - 1)) >> 2) + 1

    lower = 1
    lower_f = f(s_list, n, lower)
    upper = s_list[(n >> 1)] * s_list[(n >> 1) + 2]
    upper_f = f(s_list, n, upper)
    count = 2

    while upper - lower > 1
        test = (lower + upper) >> 1
        test_f = f(s_list, n, test)
        count += 1
        if test_f >= midpoint
            upper = test
            upper_f = test_f
        else
            lower = test
            lower_f = test_f
        end
    end
    result = upper

    println(count)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
