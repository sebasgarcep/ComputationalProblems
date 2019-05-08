#=
Approach:
Use the modpow function to iteratively calculate tetration.
=#

using Printf

function modpow(x, n, m)
    mask = reverse(string(n, base = 2))
    p = BigInt(1)
    s = x
    for k in 1:length(mask)
        if mask[k] == '1'
            p = mod(p * s, m)
        end
        s = mod(s * s, m)
    end
    return p
end

start = time()
result = 0

b = 1777
e = 1855
m = 10^8

result = b
for _ in 1:(e - 1)
    global result
    result = modpow(b, result, m)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
