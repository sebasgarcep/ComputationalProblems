using Printf

function get_primes(n)
    slots = [true for _ in 1:n]
    slots[1] = false
    primes = []
    for p in 2:n
        if slots[p]
            for k in (p^2):p:n
                slots[k] = false
            end

            push!(primes, p)
        end
    end
    return primes
end

function segmented_sieve(n, segment_size)
    value = 0
    primes = get_primes(n)
    for segment in 1:cld(n, segment_size)
        segment_min = (segment - 1) * segment_size + 1
        segment_max = min(n, segment * segment_size)
        factors = [[] for _ in segment_min:segment_max]
        for p in primes
            offset = mod(segment_min, p)
            if offset != 0
                offset = p - offset
            end
            index_max = fld(segment_max, p) - fld(segment_min + offset, p) + 1
            exponents = [0 for _ in 1:index_max]
            e = 1
            while p^e <= segment_max
                offset_e = mod(segment_min, p^e)
                if offset_e != 0
                    offset_e = p^e - offset_e
                end
                index_min = fld(segment_min + offset_e, p) - fld(segment_min + offset, p) + 1
                for i in index_min:(p^(e-1)):index_max
                    exponents[i] += 1
                end
                e += 1
            end
            for i in 1:index_max
                push!(factors[1 + offset + p * (i - 1)], (p, exponents[i]))
            end
        end
        value += get_result(n, segment_min, segment_max, factors)
    end
    return value
end

function get_result(n, segment_min, segment_max, factors)
    value = 0
    for i in segment_min:segment_max
        curr_factors = factors[i - segment_min + 1]
        value += (-1)^i * get_internal_sum(n, i, curr_factors)
    end
    return value
end

function get_internal_sum(n, i, curr_factors)
    pos = 1
    acc = 1
    tot_num = 1
    tot_den = 1
    return get_internal_sum_aux(n, i, curr_factors, pos, acc, tot_num, tot_den)
end

function get_internal_sum_aux(n, i, curr_factors, pos, acc, tot_num, tot_den)
    if pos > length(curr_factors)
        return (fld(n, acc) - fld(i - 1, acc)) * fld(acc, tot_den) * tot_num
    end
    value = 0
    (p, r) = curr_factors[pos]
    next_pos = pos + 1
    next_acc = acc
    next_tot_num = tot_num
    next_tot_den = tot_den
    for e in 0:(2 * r)
        value += get_internal_sum_aux(n, i, curr_factors, next_pos, next_acc, next_tot_num, next_tot_den)
        next_acc *= p
        if e == 0
            next_tot_num *= p - 1
            next_tot_den *= p
        end
    end 
    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 12345678

    # Algorithm parameters
    segment_size = 10^6

    # Solution
    result = segmented_sieve(n, segment_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
