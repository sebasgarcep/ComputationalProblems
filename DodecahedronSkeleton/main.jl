include("../includes.jl")

using Combinatorics
using Printf

function is_even_permutation(p)
    cnt = 0
    for i in 1:(length(p) - 1)
        for j in (i + 1):length(p)
            if p[i] > p[j]
                cnt += 1
            end
        end
    end
    return (cnt & 1) == 0
end

function tetrahedron()
    num_vertex = 4
    edges = [
        (1, 2),
        (2, 3),
        (3, 4),
        (1, 3),
        (1, 4),
        (2, 4),
    ]
    rot_sym = [p for p in collect(permutations(1:4)) if is_even_permutation(p)]
    return num_vertex, edges, rot_sym
end

function compose_permutations(num_vertex, p1, p2)
    return [p2[p1[i]] for i in 1:num_vertex]
end

function dodecahedron()
    num_vertex = 20
    """
    Got from Sage:
    G = graphs.DodecahedralGraph()
    R = G.automorphism_group().commutator()   # the 60 rotations
    gs = R.gens_small()                       # a small generating set (here 2)

    n = G.order()
    print("rotations:", R.order(), " generators:", len(gs))
    print("edges =", [(u + 1, v + 1) for u, v in G.edges(labels=False)])
    for i, g in enumerate(gs, 1):
        print(f"g{i} =", [g(v) + 1 for v in range(n)])
    """
    edges = [
        (1, 2),
        (1, 20),
        (1, 11),
        (2, 3),
        (2, 9),
        (3, 4),
        (3, 7),
        (4, 20),
        (4, 5),
        (5, 18),
        (5, 6),
        (6, 7),
        (6, 16),
        (7, 8),
        (8, 9),
        (8, 15),
        (9, 10),
        (10, 11),
        (10, 14),
        (11, 12),
        (12, 19),
        (12, 13),
        (13, 17),
        (13, 14),
        (14, 15),
        (15, 16),
        (16, 17),
        (17, 18),
        (18, 19),
        (19, 20)
    ]
    g1 = [10, 11, 12, 13, 17, 18, 19, 20, 1, 2, 9, 8, 7, 3, 4, 5, 6, 16, 15, 14]
    g2 = [1, 20, 19, 12, 13, 17, 18, 5, 4, 3, 2, 9, 8, 7, 6, 16, 15, 14, 10, 11]
    expected_size = 60
    rot_sym_set = Set()
    push!(rot_sym_set, collect(1:num_vertex))
    while length(rot_sym_set) < expected_size
        for x in collect(rot_sym_set)
            new_x_1 = compose_permutations(num_vertex, x, g1)
            push!(rot_sym_set, new_x_1)
            new_x_2 = compose_permutations(num_vertex, x, g2)
            push!(rot_sym_set, new_x_2)
        end
    end
    rot_sym = collect(rot_sym_set)
    return num_vertex, edges, rot_sym
end

# X = all sets that have at least the first edge in the list
function explore_skeletons(
    num_vertex,
    edges,
    edge_map,
    rot_sym,
    explored;
    current_vertex = 0,
    current_edges = 0
)
    push!(explored, current_edges)
    result = 0

    if current_edges == 0
        # Initialize with every edge
        for k in 1:length(edges)
            (i, j) = edges[k]
            next_vertex = (1 << (i - 1)) | (1 << (j - 1))
            next_edges = 1 << (k - 1)
            result += explore_skeletons(
                num_vertex,
                edges,
                edge_map,
                rot_sym,
                explored;
                current_vertex=next_vertex,
                current_edges=next_edges
            )
        end
        return result
    end

    # Calculate Burnside's Lemma
    result += 1

    # Build further elements of X
    for k in 1:length(edges)
        # Already picked this edge
        if current_edges & (1 << (k - 1)) != 0
            continue
        end
        next_edges = current_edges | (1 << (k - 1))
        # Already picked this subset of edges
        if next_edges in explored
            continue
        end
        (i, j) = edges[k]
        # Connects to the graph on side i
        if current_vertex & (1 << (i - 1)) != 0
            next_vertex = current_vertex | (1 << (j - 1))
            result += explore_skeletons(
                num_vertex,
                edges,
                edge_map,
                rot_sym,
                explored;
                current_vertex=next_vertex,
                current_edges=next_edges
            )
        end
        # Already picked this subset of edges
        if next_edges in explored
            continue
        end
        # Connects to the graph on side j
        if current_vertex & (1 << (j - 1)) != 0
            next_vertex = current_vertex | (1 << (i - 1))
            result += explore_skeletons(
                num_vertex,
                edges,
                edge_map,
                rot_sym,
                explored;
                current_vertex=next_vertex,
                current_edges=next_edges
            )
        end
    end

    return result
end

function is_skeleton(num_vertex, edges)
    found = 0
    target = 0
    for (i, j) in edges
        if found == 0
            found = 2^(i - 1)
        end
        target = target | 2^(i - 1)
        target = target | 2^(j - 1)
    end
    if target == 0
        return false
    end
    while true
        start = found
        for i in 1:num_vertex
            if (found & 2^(i - 1)) == 0
                continue
            end
            for (i_e, j_e) in edges
                if i == i_e
                    found = found | 2^(j_e - 1)
                end
                if i == j_e
                    found = found | 2^(i_e - 1)
                end
            end
        end
        if start == found
            return false
        end
        if found == target
            return true
        end
    end
end

function find_cycles(edges, edge_map, p)
    # Find cycles
    cycles = []
    target = (1 << length(edges)) - 1
    found = 0
    while found != target
        # Search for edges that are not in any existing cycle
        for k in 1:length(edges)
            # If not in any found cycle yet
            if found & (1 << (k - 1)) == 0
                # Find the whole cycle it belongs to
                start = k
                current = k
                current_cycle = 0
                while true
                    # Mark as found
                    current_cycle = current_cycle | (1 << (current - 1))
                    found = found | current_cycle
                    # Project cycle forward
                    (i_c, j_c) = edges[current]
                    current = edge_map[p[i_c], p[j_c]]
                    # Break if back to the start
                    if start == current
                        push!(cycles, current_cycle)
                        break
                    end
                end
            end
        end
    end
    return cycles
end

function build_candidate(edges, edge_flags, candidate)
    empty!(candidate)
    for k in 1:length(edges)
        if (edge_flags & 2^(k - 1)) == 0
            continue
        end
        push!(candidate, edges[k])
    end
end

function main()
    # Problem parameters
    # num_vertex, edges, rot_sym = tetrahedron()
    num_vertex, edges, rot_sym = dodecahedron()

    # Algorithm parameters

    # Solution
    result = 0

    candidate = Tuple{Int64, Int64}[]
    sizehint!(candidate, length(edges))

    explored = BitSet()
    sizehint!(explored, 1 << length(edges))

    edge_map = zeros(Int64, length(edges), length(edges))
    for (k, (i, j)) in enumerate(edges)
        edge_map[i, j] = k
        edge_map[j, i] = k
    end

    result = 0
    for p in rot_sym
        # Skip the identity
        if p == collect(1:num_vertex)
            result += explore_skeletons(num_vertex, edges, edge_map, rot_sym, explored)
            continue
        end
        cycles = find_cycles(edges, edge_map, p)
        # For each non-empty subset of cycles
        for cycle_flags in 1:(2^length(cycles) - 1) # Exclude the empty subset
            # Build the selected edges if we pick the whole cycle
            edge_flags = 0
            for k in 1:length(cycles)
                if cycle_flags & (1 << (k - 1)) != 0
                    edge_flags = edge_flags | cycles[k]
                end
            end
            # Build the list of edges for the subset
            build_candidate(edges, edge_flags, candidate)
            # Check if its connected
            if is_skeleton(num_vertex, candidate)
                result += 1
            end
        end
    end
    
    println(result)
    println(length(rot_sym))
    result = fld(result, length(rot_sym))
    return result
end

@time println(main())
