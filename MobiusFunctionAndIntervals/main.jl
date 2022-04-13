using Printf


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

function insert!(tree::Tree, value::Int64, split::Int64)
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
end

function search(tree::Tree, split::Int64)::Int64
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
            node = node.left
        else
            result += node.left.value
            node = node.right
        end
    end
    result += node.value
    return result
end

function normalize_for_tree(n::Int64, value::Int64)::Int64
    return value + 100 * n
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 20 * 10^6

    # Algorithm parameters

    # Solution

    # Calculate mu
    slots = [true for _ in 1:n]
    slots[1] = false
    mu_memo = [1 for _ in 1:n]
    for p in 2:n
        if slots[p]
            for k in (p^2):p:n
                slots[k] = false
            end

            for k in p:p:n
                mu_memo[k] *= -1
            end

            for k in (p^2):(p^2):n
                mu_memo[k] = 0
            end
        end
    end

    # Calculate N(x), P(x)
    n_memo = [0 for _ in 1:(n + 1)]
    p_memo = [0 for _ in 1:(n + 1)]
    for k in 1:n
        n_memo[k + 1] = n_memo[k] + (mu_memo[k] == -1 ? 1 : 0)
        p_memo[k + 1] = p_memo[k] + (mu_memo[k] ==  1 ? 1 : 0)
    end

    # Naive 2
    tree1 = Tree(200 * n)
    tree2 = Tree(200 * n)
    for b in 1:n
        result += b
        insert!(tree1, 1, normalize_for_tree(n, 99 * n_memo[b] - 100 * p_memo[b]))
        insert!(tree2, 1, normalize_for_tree(n, 99 * p_memo[b] - 100 * n_memo[b]))
        result -= search(tree1, normalize_for_tree(n, 99 * n_memo[b + 1] - 100 * p_memo[b + 1] - 1))
        result -= search(tree2, normalize_for_tree(n, 99 * p_memo[b + 1] - 100 * n_memo[b + 1] - 1))
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
