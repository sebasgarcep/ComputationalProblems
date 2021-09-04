using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 3^37
    mod_size = 10^9

    # Algorithm parameters
    bound = 10^8

    # Solution
    f_memo = zeros(Int64, bound)

    for i in 1:bound
        if i == 1
            f_memo[i] = 1
        elseif i == 3
            f_memo[i] = 3
        elseif i & 1 == 0
            f_memo[i] = f_memo[i >> 1]
        elseif i & 3 == 1
            f_memo[i] = mod(2 * f_memo[2 * (i >> 2) + 1] - f_memo[i >> 2], mod_size)
        else
            f_memo[i] = mod(3 * f_memo[2 * (i >> 2) + 1] - 2 * f_memo[i >> 2], mod_size)
        end
    end

    function f(x)
        if x <= bound
            return f_memo[x]
        end
        if x == 1
            return 1
        elseif x == 3
            return 3
        end
        if x & 1 == 0
            return f(x >> 1)
        end
        q = x >> 2
        if x & 3 == 1
            return mod(2 * f(2 * q + 1) - f(q), mod_size)
        end
        return mod(3 * f(2 * q + 1) - 2 * f(q), mod_size)
    end

    x_vals = []
    current = n
    while current > 0
        push!(x_vals, current)
        current = current >> 1
    end

    s_memo = [0 for _ in 1:length(x_vals)]
    s_odd_memo = [0 for _ in 1:length(x_vals)]
    for (idx, current) in enumerate(reverse(x_vals))
        if current <= 4
            s_odd_memo[idx] = mod(sum([f_memo[i] for i in 1:current if i & 1 == 1]), mod_size)
            s_memo[idx] = mod(sum(f_memo[1:current]), mod_size)
        else
            q = current >> 2
            r = current & 3
            remainder = 0
            if r == 1 || r == 2
                remainder += f(4 * q + 1)
                remainder = mod(remainder, mod_size)
            elseif r == 3
                remainder += f(4 * q + 1) + f(4 * q + 3)
                remainder = mod(remainder, mod_size)
            end
            if r == 2 || r == 3
                remainder -= 5 * f(2 * q + 1)
                remainder = mod(remainder, mod_size)
            end
            remainder += 3 * f(q)
            remainder = mod(remainder, mod_size)
            s_odd_memo[idx] = 1 + 3 + 5 * (s_odd_memo[idx - 1] - 1) - 3 * s_memo[idx - 2] + remainder
            s_odd_memo[idx] = mod(s_odd_memo[idx], mod_size)
            s_memo[idx] = s_memo[idx - 1] + s_odd_memo[idx]
            s_memo[idx] = mod(s_memo[idx], mod_size)
        end
    end

    result = last(s_memo)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
