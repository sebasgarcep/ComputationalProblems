using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    k = 999966663333

    # Algorithm parameters
    m = 10^7

    # Solution
    primes = []
    slots = [true for _ in 1:m]
    if m >= 2
        push!(primes, 2)
        for t in 4:2:m
            slots[t] = false
        end
    end
    for p in 3:2:m
        if slots[p]
            push!(primes, p)
            for t in p^2:p:m
                slots[t] = false
            end
        end
    end

    semidivisble = Set()
    for n in 1:length(primes)
        p_curr = primes[n]
        p_next = primes[n + 1]
        if n > 1
            p_prev = primes[n - 1]
            if k <= p_prev^2
                break
            end
            max_j = fld(p_curr^2 - p_prev^2 - 1, p_curr)
            for j in 0:max_j
                v = p_curr^2 - j * p_curr
                if v > k
                    continue
                end
                if in(v, semidivisble)
                    delete!(semidivisble, v)
                else
                    push!(semidivisble, v)
                end
            end
        end
        max_j = fld(p_next^2 - p_curr^2 - 1, p_curr)
        for j in 0:max_j
            v = p_curr^2 + j * p_curr
            if v > k
                continue
            end
            if in(v, semidivisble)
                delete!(semidivisble, v)
            else
                push!(semidivisble, v)
            end
        end
    end
    delete!(semidivisble, 4)

    result = sum(semidivisble)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
