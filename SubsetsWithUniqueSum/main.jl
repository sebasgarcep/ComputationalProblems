#=
Approach:
Take all subsets that only use the first n-1 elements and add the n-th element. Then the sum of these
new subsets will be the previous sums plus the value of the n-th element. Therefore, we can keep an
array that tracks for each possible sum and each possible number of elements, the number of sets with
those conditions. Then we iterate over the elements of A. On each element we update the array by taking
all values from one level (where each level indicates the number of elements on the array), adding the
value of the element we are iterating over, and adding the result to the next level; but shifting the
array by the value of the iteration element, so that we are adding these values not to the same set sums
on the next level, but to the set sums plus the value of the element we are iterating over.

After iterating over all elements of set A, the result is the sum of all set sums for which the last
level has a value of 1.
=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    k = 50
    s = [i^2 for i in 1:100]

    # Solution
    l = sum(s)
    u = zeros(Int64, k, l)
    for i in s
        for j in k:-1:1
            if j == 1
                u[j, i] = 1
            else
                for v in 1:l
                    if u[j - 1, v] > 0
                        r = v + i
                        u[j, r] += u[j - 1, v]
                    end
                end
            end
        end
    end

    for v in 1:l
        if u[k, v] == 1
            result += v
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
