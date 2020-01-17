#=
Approach:

Suppose a(n, k) is how many subsets of only the first n elements are equal to k (mod 250). Then:

a(n, k) = a(n - 1, k) + a(n - 1, l)

where v = n^n (mod 250) and l = k - v (mod 250). The proof is simple: if we take all subsets up to
the (n-1)-th element, and add the n-th element, then the sum of all those sets will be the previous
sum plus v. Therefore on the n-th iteration, the sets that will have sum equal to k (mod 250) after
adding the n-th element are the ones that on the (n-1)-th iteration had sum equal to k - v (mod 250).
The first term just adds the subsets of the (n-1)-th iteration.

Notice that the problem asks for the non-empty subsets, therefore the solution to the problem is
a(250250, 0) - 1.

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    n = 250250
    m = 250
    r = 10^16

    tally = [0 for _ in 0:(m - 1)]
    tally[0 + 1] = 1
    for i in 1:n
        v = powermod(i, i, m)
        next_tally = copy(tally)
        for j in 0:(m - 1)
            l = mod(j - v, m)
            next_tally[j + 1] = mod(tally[j + 1] + tally[l + 1], r)
        end
        tally = next_tally
    end

    result = tally[0 + 1] - 1

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
