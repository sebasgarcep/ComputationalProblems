using Printf

mutable struct Node
    value::Int64
    split::Union{Nothing, Int64}
    left::Union{Nothing, Node}
    right::Union{Nothing, Node}
end

function Tree()::Node
    return Node(0, nothing, nothing, nothing)
end

function insert!(tree::Node, value::Int64, split::Int64, mod_size::Int64)
    node = tree
    while node.split != nothing
        node.value += value
        node.value = mod(node.value, mod_size)
        if split < node.split
            node = node.left
        else
            node = node.right
        end
    end
    node.split = split
    node.left = Node(node.value, nothing, nothing, nothing)
    node.right = Node(value, nothing, nothing, nothing)
    node.value += value
    node.value = mod(node.value, mod_size)
end

function search(tree::Node, split::Int64, mod_size::Int64)::Int64
    result = 0
    node = tree
    while node.split != nothing
        if split < node.split
            node = node.left
        else
            result += node.left.value
            result = mod(result, mod_size)
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
    n = 10^6
    mod_size = 10^9 + 7

    # Algorithm parameters

    # Solution
    a_i = 1
    sequence = []
    for _ in 1:n
        a_i = mod(a_i * 153, 10000019)
        push!(sequence, a_i)
    end

    c_memo = [1 for _ in 1:n]
    s_memo = [mod(a_i, mod_size) for a_i in sequence]
    for k in 2:4
        c_tree = Tree()
        s_tree = Tree()
        c_memo_next = [0 for _ in 1:n]
        s_memo_next = [0 for _ in 1:n]
        for j in 1:n
            c_memo_next[j] = search(c_tree, sequence[j], mod_size)
            insert!(c_tree, c_memo[j], sequence[j], mod_size)
            s_memo_next[j] = search(s_tree, sequence[j], mod_size)
            insert!(s_tree, s_memo[j], sequence[j], mod_size)
        end
        c_memo = c_memo_next
        s_memo = mod.(mod.(sequence .* c_memo_next, mod_size) + s_memo_next, mod_size)
    end

    for s_i in s_memo
        result += s_i
        result = mod(result, mod_size)
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
