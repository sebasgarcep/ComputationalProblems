#=
Approach:
Suppose we have n tiles that need to be covered by k tiles of length s. Therefore
there are n - k * s single tiles that can be freely placed in between the larger
tiles, and on the ends. This is equivalent to finding the number of solutions to:

x_1 + x_2 + ... + x_k+1 = n - k * s

which is a well-known problem with solution:

((n - k * s) + (k + 1) - 1) choose (n - k * s)
=#

using Printf

start = time()
result = 0

n = 50
for s in 2:4
    for k in 1:(n // s)
        global n
        global result
        result = result + binomial(Int64(n - k * s + k), Int64(n - k * s))
    end
end

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
