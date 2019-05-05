#=
Approach: (Using the results of HollowSquareLaminae)
Rephrasing: We need to find, for a number of square tiles t, how many of them
can be configured in 1-10 different ways. Because t <= 1'000'000, if n is the
side length of the squares, then n <= (1'000'000 + 4) / 4. Then for each possible
configuration add 1 to the counter that tracks the number of different configurations
of for each value of t <= 1'000'000. At the end of this procedura calculate how
many values of t have their counter between 1 and 10.
=#

using Printf

start = time()
result = 0

bound = 10^6
limit = fld(bound + 4, 4)
t = [0 for _ in 1:bound]

for n in 3:limit
    global t
    for k in 2:2:(n - 1)
        tiles = n^2 - (n - k)^2
        if tiles > bound
            break
        end
        t[tiles] += 1
    end
end

for val in t
    global result
    if val >= 1 && val <= 10
        result += 1
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
