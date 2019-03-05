"""
Approach:
Any computation is going to have one of either of the following forms:

1. ((a . b) . c) . d
2. (a . b) . (c . d)

where . is the operation. We just need to search over the space of all possibilities
to find the correct answer.
"""

using Combinatorics
using Printf

start = time()
result = nothing

function do_op(op, v1, v2)
    if op == 1
        return v1 + v2
    elseif op == 2
        return v1 - v2
    elseif op == 3
        return v1 * v2
    elseif v2 > 0
        return v1 / v2
    else
        return nothing
    end
end

function genvalues(found, perm)
    for op1 in 1:4
        item1 = do_op(op1, perm[1], perm[2])
        if item1 == nothing
            continue
        end
        for op2 in 1:4
            item2 = do_op(op2, item1, perm[3])
            if item2 == nothing
                continue
            end
            for op3 in 1:4
                item3 = do_op(op3, item2, perm[4])
                if item3 == nothing
                    continue
                end
                push!(found, item3)
            end
        end
    end

    for op1 in 1:4
        item1 = do_op(op1, perm[1], perm[2])
        if item1 == nothing
            continue
        end
        for op2 in 1:4
            item2 = do_op(op2, perm[3], perm[4])
            if item2 == nothing
                continue
            end
            for op3 in 1:4
                item3 = do_op(op3, item1, item2)
                if item3 == nothing
                    continue
                end
                push!(found, item3)
            end
        end
    end
end

for a in 0:6
    for b in (a + 1):7
        for c in (b + 1):8
            for d in (c + 1):9
                found = Set()
                for perm in permutations([BigFloat(a), BigFloat(b), BigFloat(c), BigFloat(d)])
                    genvalues(found, perm)
                end
                n = 0
                while (n + 1) in found
                    n = n + 1
                end
                global result
                if result == nothing || n > result[2]
                    result = (1000 * a + 100 * b + 10 * c + d, n)
                end
            end
        end
    end
end

@printf("abcd = %d, n = %d\n", result[1], result[2])

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
