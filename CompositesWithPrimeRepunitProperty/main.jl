#=
Approach:
Use the A function of RepunitDivisibility and test for primality.
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

function is_prime(n)
    if n == 1
        return false
    end
    if n == 2
        return true
    end
    if mod(n, 2) == 0
        return false
    end
    for k in 3:2:isqrt(n)
        if n % k == 0
            return false
        end
    end
    return true
end

start = time()
result = 0
count = 0

n = 91

while count < 25
    global n
    global result
    global count
    if mod(n - 1, a(n)) == 0 && !is_prime(n)
        result += n
        count += 1
    end
    n = n + 2
    if n % 5 == 0
        n = n + 2
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

