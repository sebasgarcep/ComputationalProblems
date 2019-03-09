#=
Approach:
- The Power Tree method as described in The Art of Computer Programming Volume 2
Section 4.6.3 finds minimal solutions for all n <= 200 when n != 77 and n != 154.
The (k + 1)-st level of this tree is defined as follows, assuming that the first
k levels have been constructed: Take each node n of the kth level, from left to
right in turn, and attach below it the nodes:

n + 1, n + a1, n + a2, ... n + ak-1 = 2n

(in this order), where 1, a1, a2, ... , ak-1 is the path from the root of the tree
to n; but discard any node that duplicates a number that has already appeared in
the tree.

- We can bound the possible values of l(n) using the binary method. That is:
l(n) <= floor(log_2(n)) + v(n) - 1
where v(n) is the number of 1's in the binary representation of a number.

- Theorem C in Section 4.6.3 gives us that l(2^A + 2^B + 2^C + 2^D) >= floor(log_2(n)) + 3
except when l(2^A + 2^B + 2^C + 2^D) = A + 2.

- Therefore the case n = 77 ==> 8 <= l(n) <= 9. Because minimal Brauer chains
are minimal addition chains for n < 12509, the minimal chain of l(77) must be Brauer.
Therefore to determine whether l(77) = 8 or l(154) = 9 we need to search for a Brauer
chain of size 8 that ends in 77.

- Therefore the case n = 154 ==> 9 <= l(n) <= 10. Notice that 154 = 77 + 77,
therefore if l(77) = 8 then l(154) = 9, otherwise we need to search for the
lower bound using Brauer chains.
=#

using Printf

function build_power_tree(m)
    k = 1
    tree = [[(1, 1)]]
    placed = true
    while placed
        level = []
        placed = false
        for (pos, tuple) in enumerate(tree[k])
            result = []
            idx = pos
            n = tuple[2]
            for r in k:-1:1
                p = tree[r][idx][2]
                v = (pos, n + p)
                if v[2] <= 200 && m[v[2]] == 0
                    placed = true
                    m[v[2]] = k
                    push!(result, v)
                end
                idx = tree[r][idx][1]
            end
            result = sort(result, by = x -> x[2])
            level = vcat(level, result)
        end
        push!(tree, level)
        k = k + 1
    end
end

function search_brauer_chain(n, u, k, prev, found)
    if k >= u
        return prev == n
    end
    obtained = copy(found)
    push!(obtained, prev)
    for value in obtained
        next = prev + value
        if search_brauer_chain(n, u, k + 1, next, obtained)
            return true
        end
    end
    return false
end

function get_brauer_chain(n, u)
    return search_brauer_chain(n, u - 1, 0, 1, BitSet([1])) ? u - 1 : u
end

start = time()
m = [0 for _ in 1:200]

build_power_tree(m)

m[77] = get_brauer_chain(77, 9)
if m[77] == 8
    m[154] = 9
else
    m[154] = get_brauer_chain(154, 10)
end

result = sum(m)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
