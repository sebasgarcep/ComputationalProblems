"""
Approach:
Use the Sieve of Eratosthenes to find the radicals of each number. Sort the
numbers using a value function to assign a value such that if rad(a) == rad(b)
then v(a) < v(b) when a < b.
"""

using Printf

start = time()

val(t) = t[2] + (1 - 0.5 / t[1])

limit = 100000
radical = [[i, 1] for i in 1:limit]
for n in 2:limit
    if radical[n][2] == 1
        for k in n:n:limit
            radical[k][2] = radical[k][2] * n
        end
    end
end
sort!(radical, by=val)

@printf("%d\n", radical[10000][1])

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

