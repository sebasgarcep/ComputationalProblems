#=
Approach:
Assume all elements are ordered from largest to smallest. We build an array to
denote what happens with each element. If the position in the array corresponding
to a given element takes the value of 1, then that element is in set B. If it takes
the value of -1 it is in the C set. If it takes the value of 0, then it wasn't picked.
Also, notice that for any array we can build a new one by swapping the values of
all elements in that array. Because both picks are essentially equivalent, we choose
only the one in which the first picked element belongs to the B set. Notice also that
because the second rule is already satisfied, then we don't have to consider picks in
which the cardinalities of both picks are different. Also, when both sets have
cardinality 1 then both sets have different sums because all elements are different.
Finally we need to test from the remaining cases, in how many of them, for every
element from set C, there is a larger element of set B that "cancels it out".
=#

using Printf

function test_recursive(n, result, cases)
    num_pos = sum([e == 1 ? 1 : 0 for e in cases])
    num_neg = sum([e == -1 ? 1 : 0 for e in cases])
    if length(cases) >= n
        if num_pos == 0 ||
            num_neg == 0 ||
            num_pos != num_neg ||
            num_pos == 1 # due to the previous condition this also implies that num_neg == 1
            return result
        end
        available = 0
        for pos in 1:n
            if cases[pos] == 1
                available += 1
            elseif cases[pos] == -1
                if available == 0
                    available = -1
                    break
                else
                    available -= 1
                end
            end
        end
        if available >= 0
            return result
        end
        result += 1
        return result
    end

    if num_pos > 0
        negative_cases = copy(cases)
        push!(negative_cases, -1)
        result = test_recursive(n, result, negative_cases)
    end

    neutral_cases = copy(cases)
    push!(neutral_cases, 0)
    result = test_recursive(n, result, neutral_cases)

    positive_cases = copy(cases)
    push!(positive_cases, 1)
    result = test_recursive(n, result, positive_cases)

    return result
end

start = time()
result = 0

n = 12
result = test_recursive(n, result, [])

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
