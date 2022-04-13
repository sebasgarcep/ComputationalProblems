using Printf
using DataStructures

# Binary indexed tree implementation
# Assuming maximum size to enable simplistic balanced trees
mutable struct Node
    value::Int64
    bits::Int64
    split::Union{Nothing, Int64}
    left::Union{Nothing, Node}
    right::Union{Nothing, Node}
end

function get_num_bits(size::Int64)
    num_bits = 0
    while size > 0
        num_bits += 1
        size = size >> 1
    end
    return num_bits
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

function Tree(size::Int64)::Node
    return Node(0, get_num_bits(size), nothing, nothing, nothing)
end

function insert!(tree::Node, value::Int64, split::Int64, mod_size::Int64)
    if value == 0
        return
    end
    bits = reverse_bits(split, tree.bits)
    node = tree
    acc = 0
    for _ in 1:tree.bits
        flag = bits & 1
        bits = bits >> 1
        node.value += value
        node.value = mod(node.value, mod_size)
        if node.split == nothing
            node.split = acc + (1 << (node.bits - 1))
            node.left = Node(0, node.bits - 1, nothing, nothing, nothing)
            node.right = Node(0, node.bits - 1, nothing, nothing, nothing)
        end
        if flag == 0
            node = node.left
        else
            acc += 1 << (node.bits - 1)
            node = node.right
        end
    end
    node.value += value
    node.value = mod(node.value, mod_size)
end

function search(tree::Node, split::Int64, mod_size::Int64)::Int64
    result = 0
    bits = reverse_bits(split, tree.bits)
    node = tree
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
    n = 20 * 10^6
    mod_size = 10^8

    # Algorithm parameters
    bound = n

    # Solution
    totient_memo = [k for k in 1:n]
    slots = [true for _ in 1:n]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            for k in p:p:bound
                totient_memo[k] = fld(totient_memo[k], p) * (p - 1)
            end
        end
    end
    
    c_memo = [0 for _ in 1:n]
    c_memo[6] = 1
    
    # Initialize data structures
    c_running_total = [0 for _ in 1:n]
    c_running_total[6] = c_memo[6]
    c_tree = Tree(n)
    insert!(c_tree, c_memo[6], totient_memo[6], mod_size)

    for k in 7:n
        # Calculate C(k)
        c_memo[k] += c_running_total[k - 1]
        c_memo[k] = mod(c_memo[k], mod_size)
        c_memo[k] -= c_running_total[totient_memo[k]]
        c_memo[k] = mod(c_memo[k], mod_size)
        c_memo[k] -= search(c_tree, totient_memo[k], mod_size)
        c_memo[k] = mod(c_memo[k], mod_size)

        # Update data structures
        c_running_total[k] = c_running_total[k - 1] + c_memo[k]
        c_running_total[k] = mod(c_running_total[k], mod_size)
        insert!(c_tree, c_memo[k], totient_memo[k], mod_size)
    end

    for c_i in c_memo
        result += c_i
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
