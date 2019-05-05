#=
Approach:
If the outer square has side length n and the inner one side length n - k, then
n^2 - (n - k)^2 = 4 * n - 4 <= 10^6 and therefore n <= floor((10^6 + 4) / 4).
Then for each possible value of n we need to find which values of k produce less
than or equal to 10^6 tiles. Clearly, k >= 2, otherwise the outer square wouldn't
have one its two sides. And because the smallest the inner square can be is a
square of 1x1, then k <= n - 1. Notice that to make the inner square smaller we
have to remove both of its sides, therefore k increments in multiples of 2. Finally,
we need to stop whenever we already have more than 10^6 tiles.
=#

using Printf

start = time()
result = 0

bound = 10^6
limit = fld(bound + 4, 4)

for n in 3:limit
    global result
    for k in 2:2:(n - 1)
        tiles = n^2 - (n - k)^2
        if tiles > bound
            break
        end
        result += 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
