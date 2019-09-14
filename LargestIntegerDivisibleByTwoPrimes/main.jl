#=
Approach:
Use the sieve to find the prime factors of a number. If the third prime prime
factor is found mark that number to be excluded. Use a dictionary to keep track
of the solution for a given (p, q) tuple.
=#

using Printf

start = time()
result = 0

n = 10^7

m = Dict()
p1 = [0 for _ in 1:n]
p2 = [0 for _ in 1:n]
ex = [false for _ in 1:n]

slots = [true for _ in 1:n]
for k in 2:n
    global m
    global p1
    global p2
    global ex
    global slots
    if slots[k]
        p1[k] = k
        for t in (2 * k):k:n
            slots[t] = false
            if p1[t] == 0
                p1[t] = k
            elseif p2[t] == 0
                p2[t] = k
            else
                ex[t] = true
            end
        end
    end
    if !ex[k] && p1[k] !== 0 && p2[k] !== 0
        tk = (p1[k], p2[k])
        if haskey(m, tk)
            m[tk] = max(m[tk], k)
        else
            m[tk] = k
        end
    end
end

result = sum(values(m))

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
