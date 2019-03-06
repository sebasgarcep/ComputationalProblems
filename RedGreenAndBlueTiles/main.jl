#=
Approach:
Suppose we have n tiles that need to be covered by k1 tiles of length s1, k2 tiles
of length s2 and k3 tiles of length s3. Therefore there are n - sum(i = 1, 3) ki * si
single tiles that can be freely placed in between the larger tiles, and on the ends.
This is equivalent to finding the number of solutions to:

x_1 + x_2 + ... + x_k1+k2+k3+1 = n - sum(i = 1, 3) ki * si

which is a well-known problem with solution:

((n - sum(i = 1, 3) ki * si) + (k1 + k2 + k3 + 1) - 1) choose (n - sum(i = 1, 3) ki * si)

We also have to multiply the result by the number of ways these tiles can be
permuted. This is calculated with the multinomial coefficient:

(k1 + k2 + k3)! / (k1! * k2! * k3!)
=#

using Printf

function multinomial(k1, k2, k3)
    return binomial(Int64(k1 + k2 + k3), Int64(k1)) * binomial(Int64(k2 + k3), Int64(k2))
end

start = time()
result = 0

n = 50
s1 = 2
s2 = 3
s3 = 4
for k1 in 0:(n // s1)
    for k2 in 0:((n - k1) // s2)
        for k3 in 0:((n - k1 - k2) // s3)
            global n
            global result
            num_blacks = n - k1 * s1 - k2 * s2 - k3 * s3
            free_arrangements = binomial(Int64(num_blacks + k1 + k2 + k3), Int64(num_blacks))
            tile_arrangements = multinomial(k1, k2, k3)
            result = result + free_arrangements * tile_arrangements
        end
    end
end

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
