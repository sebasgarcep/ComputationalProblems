using Printf

function build_partitions_aux(n)
    if n == 0
        return Dict()
    elseif n == 1
        return Dict("1" => [1])
    end
    prev_partitions = build_partitions_aux(n - 1)
    next_partitions = Dict()
    for (hash, partition) in prev_partitions
        # Create a longer partition by adding 1 to the end
        item = copy(partition)
        push!(item, 1)
        hash = join(item, ",")
        next_partitions[hash] = item
        # Add 1 to each the existing groups
        for position = 1:length(partition)
            item = copy(partition)
            item[position] += 1
            sort!(item, rev = true)
            hash = join(item, ",")
            next_partitions[hash] = item
        end
    end
    return next_partitions
end

function build_partitions(n)
    partitions_dict = build_partitions_aux(n)
    return values(partitions_dict)
end

function partition_count(n, partition)
    result = factorial(BigInt(n))
    cnt = zeros(Int64, n)
    for item in partition
        cnt[item] += 1
    end
    for i = 1:n
        if cnt[i] != 0
            result /= BigInt(i)^cnt[i] * factorial(BigInt(cnt[i])) 
        end
    end
    return result
end

function count_swap_cycles(alpha, beta)
    acc = 0
    for i = 1:length(alpha)
        a_i = alpha[i]
        for j = 1:length(beta)
            b_j = beta[j]
            g = gcd(a_i, b_j)
            acc += g
        end
    end
    return acc
end

function count_valid_flips(n, alpha, beta)
    dependent_alpha = BitSet()
    dependent_beta = BitSet()
    for i = 1:length(alpha)
        a_i = alpha[i]
        for j = 1:length(beta)
            b_j = beta[j]
            g = gcd(a_i, b_j)
            parity_a = (a_i / g) % 2
            parity_b = (b_j / g) % 2
            if parity_a == 1
                push!(dependent_beta, j)
            end
            if parity_b == 1
                push!(dependent_alpha, i)
            end
        end
    end

    valid_alpha = copy(dependent_alpha)
    valid_beta = copy(dependent_beta)
    for i = 1:length(alpha)
        a_i = alpha[i]
        for j = 1:length(beta)
            b_j = beta[j]
            g = gcd(a_i, b_j)
            parity_a = (a_i / g) % 2
            parity_b = (b_j / g) % 2
            if parity_a == 1 && parity_b == 0
                delete!(valid_beta, j)
            end
            if parity_b == 1 && parity_a == 0
                delete!(valid_alpha, i)
            end
        end
    end

    if length(valid_alpha) > 0 && length(valid_beta) > 0
        flag = 1
    else
        flag = 0
    end

    return 2 * n - length(dependent_alpha) - length(dependent_beta) + flag
end

function main()
    # Begin time measurement
    start = time()
    result = BigInt(0)

    # Problem parameters
    n = 20

    # Algorithm parameters

    # Solution
    partitions = build_partitions(n)

    for alpha in partitions
        x = partition_count(n, alpha)
        for beta in partitions
            y = partition_count(n, beta)
            # Begin iteration
            swap_cycles = count_swap_cycles(alpha, beta)
            valid_flips = count_valid_flips(n, alpha, beta)
            term = BigInt(x * y) * BigInt(2)^(swap_cycles + valid_flips)
            # End iteration
            result += term
        end
    end

    denominator = factorial(BigInt(n))^2 * BigInt(2)^(2 * n)
    result /= denominator

    # Show result
    println(BigInt(mod(result, 1001001011)))

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
