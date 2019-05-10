#=
Approach:
Notice that:

nCk = nC(n - k)

and because in our case n - k < k then we need to do less work. Also notice that:

nCr = (n * (n - 1) * ... * (n - r + 1)) / (1 * 2 * ... * r)

Therefore we need to add the prime factorization of the numbers from n - r + 1 to n
and subtract that of the numbers from 2 to r (to cancel out the extra factors we
added in the previous step). Finally, we will use the Sieve of Eratosthenes to
factorize all the numbers rapidly.
=#

using Printf

start = time()
result = 0

n = 20000000
k = 15000000
r = n - k

slots = [true for n in 1:n]
for i in 2:n
    if slots[i]
        for k in i:i:n
            global result
            slots[k] = false
            if k >= n - r + 1
                v = k
                while mod(v, i) == 0
                    v = fld(v, i)
                    result += i
                end
            end
            if k <= r
                v = k
                while mod(v, i) == 0
                    v = fld(v, i)
                    result -= i
                end
            end
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
