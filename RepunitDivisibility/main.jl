#=
Approach:
Notice that R(k) = 10 * R(k-1) + 1, therefore we can calculate the modulus iteratively.
Finally, using the pigeonhole principle we can deduce that A(n) <= n, therefore we
only need to search for values of n equal to or larger than 10^6.
=#

using Printf

function a(n)
    k = 1
    r = mod(1, n)
    while r != 0
        r = mod(10 * r + 1, n)
        k = k + 1
    end
    return k
end

start = time()

n = 10^6 + 1

while a(n) <= 10^6
    global n
    n = n + 2
    if n % 5 == 0
        n = n + 2
    end
end

result = n
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

