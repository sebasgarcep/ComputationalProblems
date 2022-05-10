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

function segmented_sieve(n, mod_size, segment_size, cyclotomic_memo, p_memo)
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
        get_result(n, mod_size, cyclotomic_memo, p_memo, segment_min, segment_max, factors)
    end
end

function get_result(n, mod_size, cyclotomic_memo, p_memo, segment_min, segment_max, factors)
    for i in segment_min:segment_max
        curr_factors = factors[i - segment_min + 1]
        calculate_memo(n, mod_size, cyclotomic_memo, p_memo, i, curr_factors)
    end
end

function calculate_memo(n, mod_size, cyclotomic_memo, p_memo, i, curr_factors)
    if i == 1
        cyclotomic_memo[i] = 1
        p_memo[i] = 2
        return
    end
    pos = 1
    acc = 1
    total_den, total_prod, total_sum = calculate_memo_aux(n, mod_size, cyclotomic_memo, p_memo, i, curr_factors, pos, acc)
    cyclotomic_memo[i] = mod((powermod(2, i, mod_size) - 1) * invmod(total_den, mod_size), mod_size)
    p_memo[i] = mod(mod(total_prod * (1 + cyclotomic_memo[i]), mod_size) - total_sum, mod_size)
end

function calculate_memo_aux(n, mod_size, cyclotomic_memo, p_memo, i, curr_factors, pos, acc)
    if pos > length(curr_factors)
        if i != acc
            return cyclotomic_memo[acc], 1 + cyclotomic_memo[acc], p_memo[acc]
        else
            return 1, 1, 0
        end
    end
    total_den, total_prod, total_sum = 1, 1, 0
    (p, r) = curr_factors[pos]
    next_pos = pos + 1
    next_acc = acc
    for e in 0:r
        iter_den, iter_prod, iter_sum = calculate_memo_aux(n, mod_size, cyclotomic_memo, p_memo, i, curr_factors, next_pos, next_acc)
        total_den = mod(total_den * iter_den, mod_size)
        total_prod = mod(total_prod * iter_prod, mod_size)
        total_sum = mod(total_sum + iter_sum, mod_size)
        next_acc *= p
    end 
    return total_den, total_prod, total_sum
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7
    mod_size = 10^9 + 7

    # Algorithm parameters
    segment_size = 10^6

    # Solution
    cyclotomic_memo = [0 for _ in 1:n]
    p_memo = [0 for _ in 1:n]

    segmented_sieve(n, mod_size, segment_size, cyclotomic_memo, p_memo)
    
    for i in 1:n
        result = mod(result + p_memo[i], mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
