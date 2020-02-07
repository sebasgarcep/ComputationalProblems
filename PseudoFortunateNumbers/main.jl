using Printf

function search(admissible, primes, n, k, i)
    if i > length(primes)
        return
    end
    p = primes[i]
    admissible[k] = true
    next_k = k
    while true
        next_k *= p
        if next_k > n
            break
        end
        search(admissible, primes, n, next_k, i + 1)
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^9 - 1

    # Algorithm parameters
    l = n + 100

    # Solution
    coll = Set()

    multiple = 1
    primes = []
    slots = [p & 1 == 1 for p in 1:l]
    slots[1] = false
    if l >= 2
        if multiple <= n
            push!(primes, 2)
            multiple *= 2
        end
        slots[2] = true
    end
    for p in 3:2:l
        if slots[p]
            if multiple <= n
                push!(primes, p)
                multiple *= p
            end
            for t in (2 * p):p:l
                slots[t] = false
            end
        end
    end

    pseudo_fortunate = [0 for _ in 1:n]
    m = 0
    for i in (l - 2):-1:1
        if m > 0
            m += 1
        end
        if slots[i + 2]
            m = 2
        end
        if i <= n
            pseudo_fortunate[i] = m
        end
    end

    admissible = [false for _ in 1:n]
    search(admissible, primes, n, 1, 1)
    admissible[1] = false

    for k in 1:n
        if admissible[k]
            if pseudo_fortunate[k] == 0
                println("Missing Pseudo Fortunate Number for k = ", k)
                return
            end
            push!(coll, pseudo_fortunate[k])
        end
    end

    result = sum(coll)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
