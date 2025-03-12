include("../includes.jl")

using Printf

using .Common: factorial_mod

function main()
    # Problem parameters
    n = 500
    beds_file = "beds.txt"
    desks_file = "desks.txt"
    m = 999_999_937

    # Algorithm parameters

    # Solution
    adjacency_matrix = zeros(Int64, n, n)

    open(beds_file, "r") do f
        while !eof(f)
            s = readline(f)
            if !isempty(s)
                x, y = parse.(Int64, split(s, ","))
                adjacency_matrix[x, y] = 1
                adjacency_matrix[y, x] = 1
            end
         end
    end

    open(desks_file, "r") do f
        while !eof(f)
            s = readline(f)
            if !isempty(s)
                x, y = parse.(Int64, split(s, ","))
                adjacency_matrix[x, y] = -1
                adjacency_matrix[y, x] = -1
            end
         end
    end

    odd_chains = zeros(Int64, n)
    positive_even_chains = zeros(Int64, n)
    negative_even_chains = zeros(Int64, n)
    cycles = zeros(Int64, n)
    
    visited = [false for _ in 1:n]
    # Detect chain
    for i in 1:n
        if visited[i]
            continue
        end

        degree = sum(abs.(adjacency_matrix[:, i]))
        if degree >= 2
            continue
        end

        j = i
        chain_finished = false
        chain_size = 0
        first_edge = 0
        while !chain_finished
            visited[j] = true
            chain_finished = true
            chain_size += 1

            for k in 1:n
                if adjacency_matrix[j, k] != 0 && !visited[k]
                    if first_edge == 0
                        first_edge = adjacency_matrix[j, k]
                    end
                    j = k
                    chain_finished = false
                    break
                end
            end
        end

        if chain_size & 1 == 1
            odd_chains[chain_size] += 1
        elseif first_edge == 1
            positive_even_chains[chain_size] += 1
        else
            negative_even_chains[chain_size] += 1
        end
    end
    # Detect cycles (all remaining elements are part of a cycle)
    for i in 1:n
        if visited[i]
            continue
        end

        j = i
        chain_finished = false
        chain_size = 0
        while !chain_finished
            visited[j] = true
            chain_finished = true
            chain_size += 1

            for k in 1:n
                if adjacency_matrix[j, k] != 0 && !visited[k]
                    j = k
                    chain_finished = false
                    break
                end
            end
        end

        cycles[chain_size] += 1
    end

    result = 1
    # Compute odd chain permutations
    for i in 1:n
        if odd_chains[i] == 0
            continue
        end
        result *= factorial_mod(odd_chains[i], m)
        result = mod(result, m)
    end
    # Compute positive even chain permutations
    for i in 1:n
        if positive_even_chains[i] == 0
            continue
        end
        result *= factorial_mod(positive_even_chains[i], m)
        result = mod(result, m)
        result *= powermod(2, positive_even_chains[i], m)
        result = mod(result, m)
    end
    # Compute negative even chain permutations
    for i in 1:n
        if negative_even_chains[i] == 0
            continue
        end
        result *= factorial_mod(negative_even_chains[i], m)
        result = mod(result, m)
        result *= powermod(2, negative_even_chains[i], m)
        result = mod(result, m)
    end
    # Compute cycle permutations
    for i in 2:2:n
        if cycles[i] == 0
            continue
        end
        result *= factorial_mod(cycles[i], m)
        result = mod(result, m)
        result *= powermod(i, cycles[i], m)
        result = mod(result, m)
    end

    return result
end

@time println(main())
