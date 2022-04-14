using Printf
using Base.Iterators

mutable struct LaggedFibonacciGenerator
    values::Array{Int64, 1}
    k::Int64
end

function LaggedFibonacciGenerator()
    return LaggedFibonacciGenerator([0 for _ in 1:55], 0)
end

function next(generator::LaggedFibonacciGenerator)::Int64
    generator.k += 1
    if generator.k <= 55
        s_k = mod(100003 - 200003 * generator.k + 300007 * generator.k^3, 10^6)
        s_k = s_k == 0 ? 10^6 : s_k
        generator.values[generator.k] = s_k
        return s_k
    else
        s_k = mod(generator.values[56-24] + generator.values[56-55], 10^6)
        s_k = s_k == 0 ? 10^6 : s_k
        for k in 1:54
            generator.values[k] = generator.values[k + 1]
        end
        generator.values[55] = s_k
        return s_k
    end
end

mutable struct DisjointSet
    parents::Array{Int64, 1}
    sizes::Array{Int64, 1}
end

function DisjointSet(size::Int64)::DisjointSet
    return DisjointSet([k for k in 1:size], [1 for _ in 1:size])
end

function get_representative(disjoint_set::DisjointSet, elem::Int64)::Int64
    representative = elem
    while disjoint_set.parents[representative] != representative
        representative = disjoint_set.parents[representative]
    end 
    return representative
end

function size(disjoint_set::DisjointSet, elem::Int64)::Int64
    representative = get_representative(disjoint_set, elem)
    return disjoint_set.sizes[representative]
end

function add(disjoint_set::DisjointSet, left::Int64, right::Int64)
    left_representative = get_representative(disjoint_set, left)
    right_representative = get_representative(disjoint_set, right)
    if left_representative == right_representative
        return
    end
    # ADD CASE HERE TO PRIORITIZE PM
    if right_representative == 524287 || disjoint_set.sizes[left_representative] < disjoint_set.sizes[right_representative]
        disjoint_set.parents[left_representative] = right_representative
        disjoint_set.sizes[right_representative] += disjoint_set.sizes[left_representative]
        disjoint_set.sizes[left_representative] = 0
    else
        disjoint_set.parents[right_representative] = left_representative
        disjoint_set.sizes[left_representative] += disjoint_set.sizes[right_representative]
        disjoint_set.sizes[right_representative] = 0 
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    generator = LaggedFibonacciGenerator()
    disjoint_set = DisjointSet(10^6)

    while size(disjoint_set, 524287) < 990000 # 99% of 10^6
        caller, called = next(generator), next(generator)
        if caller == called
            continue
        end
        result += 1
        add(disjoint_set, caller, called)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
