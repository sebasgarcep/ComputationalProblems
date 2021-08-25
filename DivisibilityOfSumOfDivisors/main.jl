using Printf

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    return Int64(floor(Float64(a)^(1.0 / b)))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^11
    d = 2017

    # Algorithm parameters
    bound = isqrt(n)

    # Solution
    primes = []
    valid_powers = Dict()

    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            push!(primes, p)

            # Get valid prime powers
            v = p
            acc = 1
            while v <= n
                acc = mod(acc + v, d)
                if acc == 0
                    if !haskey(valid_powers, p)
                        valid_powers[p] = []
                    end
                    push!(valid_powers[p], v)
                end
                v *= p
            end

            for k in p^2:p:bound
                slots[k] = false
            end
        end
    end

    large_slots = [k * d - 1 > bound for k in 1:fld(n + 1, d)]
    for p in primes
        if p == d
            continue
        end
        min_k = invmod(d, p)
        for k in min_k:p:length(large_slots)
            large_slots[k] = false
        end
    end

    for k in 1:length(large_slots)
        if large_slots[k]
            q = k * d - 1
            valid_powers[q] = [q]
        end
    end

    """
    # Naive approach
    result_set = Set()
    for (p, p_pow_list) in valid_powers
        for p_pow in p_pow_list
            mod_acc = 1
            for k in p_pow:p_pow:n
                if mod_acc == p
                    mod_acc = 1
                    continue
                end
                push!(result_set, k)
                mod_acc += 1
            end
        end
    end

    result = sum(result_set)
    """

    # Inclusion-Exclusion approach
    function triangular(x)
        t1 = x
        if t1 & 1 == 0
            t1 = t1 >> 1
        end
        t2 = x + 1
        if t2 & 1 == 0
            t2 = t2 >> 1
        end
        return t1 * t2
    end

    function coprime_sum(x, selected)
        value = 0
        for t in 0:(2^length(selected) - 1)
            sign = 1
            divisor = 1
            k = 1
            t_acc = t
            while t_acc > 0
                if t_acc & 1 == 1
                    sign *= -1
                    divisor *= selected[k]
                end
                k += 1
                t_acc = t_acc >> 1
            end
            value += sign * divisor * triangular(fld(x, divisor))
        end
        return value
    end

    prime_list = sort([p for p in keys(valid_powers)])
    function explore(start, accumulator, selected_primes)
        limit = fld(n, accumulator)

        if accumulator > 1
            sign = (-1)^(length(selected_primes) - 1)
            result += sign * accumulator * coprime_sum(limit, selected_primes)
        end

        for pos in start:length(prime_list)
            p = prime_list[pos]
            if p > limit
                break
            end
            next_selected_primes = copy(selected_primes)
            push!(next_selected_primes, p)
            for p_pow in valid_powers[p]
                next_start = pos + 1
                if p_pow > limit
                    break
                end
                next_accumulator = accumulator * p_pow
                explore(next_start, next_accumulator, next_selected_primes)
            end
        end
    end

    explore(1, 1, [])

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
