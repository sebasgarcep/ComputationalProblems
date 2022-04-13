using Printf
using DataStructures

# Binary indexed tree implementation
# Assuming maximum size to enable simplistic balanced trees
mutable struct Node
    value::Int64
    split::Union{Nothing, Int64}
    left::Union{Nothing, Node}
    right::Union{Nothing, Node}
end

mutable struct Tree
    bits::Int64
    head::Node
end

function get_num_bits(size::Int64)::Int64
    num_bits = 0
    while size > 0
        num_bits += 1
        size = size >> 1
    end
    return num_bits
end

function Tree(size::Int64)::Tree
    return Tree(
        get_num_bits(size),
        Node(0, nothing, nothing, nothing),
    )
end

function reverse_bits(num::Int64, size::Int64)::Int64
    result = 0
    for _ in 1:size
        result = result << 1
        result = result | (num & 1)
        num = num >> 1
    end
    return result
end

function insert!(tree::Tree, value::Int64, split::Int64, mod_size::Int64)
    if value == 0
        return
    end
    bits = reverse_bits(split, tree.bits)
    node = tree.head
    size = tree.bits
    acc = 0
    for _ in 1:tree.bits
        flag = bits & 1
        bits = bits >> 1
        node.value += value
        node.value = mod(node.value, mod_size)
        if node.split == nothing
            node.split = acc + (1 << (size - 1))
            node.left = Node(0, nothing, nothing, nothing)
            node.right = Node(0, nothing, nothing, nothing)
        end
        if flag == 0
            node = node.left
        else
            acc += 1 << (size - 1)
            node = node.right
        end
        size -= 1
    end
    node.value += value
    node.value = mod(node.value, mod_size)
end

function search(tree::Tree, split::Int64, mod_size::Int64)::Int64
    result = 0
    bits = reverse_bits(split, tree.bits)
    node = tree.head
    for _ in 1:tree.bits
        if node.split == nothing
            break
        end
        flag = bits & 1
        bits = bits >> 1
        if flag == 0
            result += node.right.value
            result = mod(result, mod_size)
            node = node.left
        else
            node = node.right
        end
    end
    result += node.value
    result = mod(result, mod_size)
    return result
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 60 * 10^6
    mod_size = 10^18

    # Algorithm parameters
    bound = n + 1

    # Solution

    # Calculate sigma_0
    num_divisors = [k == 1 ? 1 : 2 for k in 1:bound]
    for d in 2:isqrt(bound)
        for k in d:d:bound
            if d^2 > k
                continue
            elseif d^2 == k
                num_divisors[k] += 1
            else
                num_divisors[k] += 2
            end
        end
    end

    # Calculate dT
    dt_memo = [0 for _ in 1:n]
    for k in 1:n
        if k & 1 == 0
            dt_memo[k] = num_divisors[k >> 1] * num_divisors[k + 1] 
        else
            dt_memo[k] = num_divisors[k] * num_divisors[(k + 1) >> 1]
        end
    end

    tr_memo = [1 for _ in 1:n]
    for k in 2:3
        tr_tree = Tree(maximum(dt_memo))
        tr_memo_next = [0 for _ in 1:n]
        for j in 1:n
            tr_memo_next[j] = search(tr_tree, dt_memo[j] + 1, mod_size)
            insert!(tr_tree, tr_memo[j], dt_memo[j], mod_size)
        end
        tr_memo = tr_memo_next
    end

    for tr_i in tr_memo
        result += tr_i
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
