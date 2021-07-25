using Printf
using Combinatorics
using SparseArrays

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    h = 32
    v = 10

    # Algorithm parameters

    # Solution
    cracks = []
    for s in 0:fld(h, 2)
        t = fld(h - 2 * s, 3)
        if 2 * s + 3 * t != h
            continue
        end
        for item in combinations(1:(s + t), s)
            acc = 0
            value = BitSet()
            for idx in 1:(s + t - 1)
                if idx in item
                    acc += 2
                else
                    acc += 3
                end
                push!(value, acc)
            end
            push!(cracks, value)
        end
    end

    adjacency = spzeros(length(cracks), length(cracks))
    for i in 1:length(cracks)
        value = []
        for j in 1:length(cracks)
            if i == j
                continue
            end
            if length(intersect(cracks[i], cracks[j])) == 0
                adjacency[i, j] = 1
            end
        end
    end

    paths = ones(length(cracks))

    for _ in 1:(v - 1)
        paths = adjacency * paths
    end

    result = Int64(sum(paths))

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
