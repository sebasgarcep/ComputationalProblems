using Printf
import Base.pop!, Base.length

# Define IndexedMaxHeap
mutable struct IndexedMaxHeap
    data::Array{Int64}
    length::Int64
    index::Dict{Int64, Array{Int64}}
end

# Helper functions
function get_capacity(size::Int64)::Int64
    capacity = 1
    while size > 0
        size = size >> 1
        capacity = capacity << 1
    end
    capacity -= 1
    return capacity
end

function get_parent(position::Int64)::Int64
    return (position - 1) >> 1
end

function get_children(position::Int64)::Tuple{Int64, Int64}
    return (2 * position + 1, 2 * position + 2)
end

function index_insert!(heap::IndexedMaxHeap, value::Int64, position::Int64)
    if !haskey(heap.index, value)
        heap.index[value] = []
    end
    push!(heap.index[value], position)
end

function index_swap!(heap::IndexedMaxHeap, value::Int64, prev::Int64, next::Int64)
    value_index = heap.index[value]
    for k in 1:length(value_index)
        if value_index[k] == prev
            value_index[k] = next
            return
        end
    end
end

function index_delete!(heap::IndexedMaxHeap, value::Int64, position::Int64)
    value_index = heap.index[value]
    for k in 1:length(value_index)
        if value_index[k] == position
            value_index[k] = last(value_index)
            break
        end
    end
    pop!(value_index)
end

# Constructor
function IndexedMaxHeap(size::Int64, data::Union{Nothing, Array{Int64}} = nothing)::IndexedMaxHeap
    capacity = get_capacity(size)
    heap_data = zeros(Int64, capacity)
    if data == nothing
        heap_length = 0
        heap_index = Dict()
    else
        heap_length = length(data)
        heap_data[1:heap_length] = sort(data, rev = true)
        heap_index = Dict()
        for position in 0:(heap_length - 1)
            value = heap_data[position + 1]
            if !haskey(heap_index, value)
                heap_index[value] = []
            end
            push!(heap_index[value], position)
        end
    end
    return IndexedMaxHeap(heap_data, heap_length, heap_index)
end

# Data structure methods
function length(heap::IndexedMaxHeap)::Int64
    return heap.length
end

function peek(heap::IndexedMaxHeap)::Int64
    return heap.data[1]
end

function insert!(heap::IndexedMaxHeap, value::Int64)
    # Add value to end of the array
    heap.length += 1
    position = heap.length - 1
    parent_position = get_parent(position)
    heap.data[position + 1] = value
    # Update index
    index_insert!(heap, value, position)
    # Bubble up new value to restore heap property
    while position != 0 && heap.data[parent_position + 1] < heap.data[position + 1]
        # Update index
        index_swap!(heap, heap.data[position + 1], position, parent_position)
        index_swap!(heap, heap.data[parent_position + 1], parent_position, position)
        # Update heap
        temp = heap.data[parent_position + 1]
        heap.data[parent_position + 1] = heap.data[position + 1]
        heap.data[position + 1] = temp
        position = parent_position
        parent_position = get_parent(position)
    end
end

function pop!(heap::IndexedMaxHeap)::Int64
    # Put root in dead space
    result = heap.data[1]
    heap.data[1] = heap.data[heap.length]
    heap.length -= 1
    # Update index
    index_delete!(heap, result, 0)
    index_swap!(heap, heap.data[1], heap.length, 0)
    # Bubble down new root to restore heap property
    position = 0
    (left, right) = get_children(position)
    while (left < heap.length && heap.data[position + 1] < heap.data[left + 1]) ||
        (right < heap.length && heap.data[position + 1] < heap.data[right + 1])
        if right >= heap.length || heap.data[left + 1] >= heap.data[right + 1]
            swap_position = left
        else
            swap_position = right
        end
        # Update index
        index_swap!(heap, heap.data[position + 1], position, swap_position)
        index_swap!(heap, heap.data[swap_position + 1], swap_position, position)
        # Update heap
        temp = heap.data[swap_position + 1]
        heap.data[swap_position + 1] = heap.data[position + 1]
        heap.data[position + 1] = temp
        position = swap_position
        (left, right) = get_children(position)
    end
    return result
end

function delete!(heap::IndexedMaxHeap, value::Int64)
    # Find position for deletion
    position = -1
    if haskey(heap.index, value) && length(heap.index[value]) > 0
        position = last(heap.index[value])
    end
    if position == -1
        return
    end
    # Override this element
    heap.data[position + 1] = heap.data[heap.length]
    heap.length -= 1
    # Update index
    index_delete!(heap, value, position)
    index_swap!(heap, heap.data[position + 1], heap.length, position)
    # Bubble up/down the position to restore the heap property
    while true
        # Bubble up
        parent_position = get_parent(position)
        if position != 0 && heap.data[parent_position + 1] < heap.data[position + 1]
            # Update index
            index_swap!(heap, heap.data[position + 1], position, parent_position)
            index_swap!(heap, heap.data[parent_position + 1], parent_position, position)
            # Update heap
            temp = heap.data[parent_position + 1]
            heap.data[parent_position + 1] = heap.data[position + 1]
            heap.data[position + 1] = temp
            position = parent_position
            continue
        end
        # Bubble down
        (left, right) = get_children(position)
        if (left < heap.length && heap.data[position + 1] < heap.data[left + 1]) ||
            (right < heap.length && heap.data[position + 1] < heap.data[right + 1])
            if right >= heap.length || heap.data[left + 1] >= heap.data[right + 1]
                swap_position = left
            else
                swap_position = right
            end
            # Update index
            index_swap!(heap, heap.data[position + 1], position, swap_position)
            index_swap!(heap, heap.data[swap_position + 1], swap_position, position)
            # Update heap
            temp = heap.data[swap_position + 1]
            heap.data[swap_position + 1] = heap.data[position + 1]
            heap.data[position + 1] = temp
            position = swap_position
            continue
        end
        break
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n_prob = 10^7
    k_prob = 10^5

    # Algorithm parameters
    bound = 2 * Int64(ceil(n_prob * log(n_prob)))

    # Solution

    # Calculate S, S_2
    s_memo = [0 for _ in 1:n_prob]
    s2_memo = [0 for _ in 1:n_prob]

    slots = [true for _ in 1:bound]
    slots[1] = false
    nprimes = 0
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            if nprimes < n_prob
                nprimes += 1
                s_memo[nprimes] = powermod(p, nprimes, 10007)
            end
        end
    end

    for k in 1:n_prob
        s2_memo[k] = s_memo[k] + s_memo[fld(k, 10^4) + 1]
    end

    # Calculate F
    result_double = 0

    # Build heaps
    initial_list = sort(s2_memo[1:k_prob])
    left_list = reverse(initial_list[1:(k_prob >> 1)])
    right_list = -initial_list[((k_prob >> 1) + 1):k_prob]
    left_heap = IndexedMaxHeap(k_prob >> 1, left_list)
    right_heap = IndexedMaxHeap(k_prob >> 1, right_list)
    for i in 1:(n_prob - k_prob + 1)
        if i > 1
            # Update heaps
            delete_elem = s2_memo[i - 1]
            insert_elem = s2_memo[i + k_prob - 1]

            left_root = peek(left_heap)
            right_root = -peek(right_heap)

            if delete_elem <= left_root
                delete!(left_heap, delete_elem)
            else
                delete!(right_heap, -delete_elem)
            end

            if insert_elem <= left_root
                insert!(left_heap, insert_elem)
            else
                insert!(right_heap, -insert_elem)
            end

            if length(left_heap) > length(right_heap)
                root = pop!(left_heap)
                insert!(right_heap, -root)
            end

            if length(left_heap) < length(right_heap)
                root = -pop!(right_heap)
                insert!(left_heap, root)
            end
        end
        result_double += peek(left_heap) - peek(right_heap)
    end

    if result_double & 1 == 0
        result = string(result_double >> 1) * ".0"
    else
        result = string(result_double >> 1) * ".5"
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
