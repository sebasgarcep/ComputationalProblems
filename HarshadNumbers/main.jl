#=
Approach:
All 1-digit numbers are Harshad Numbers.
=#

using Printf

function is_prime(n)
    if n <= 1
        return false
    end
    if n % 2 == 0
        return n == 2
    else
        for k in 3:2:isqrt(n)
            if n % k == 0
                return false
            end
        end
        return true
    end
end

start = time()
result = 0

max_digits = 14

function search(k, n, s)
    for d in 0:9
        next_n = n * 10 + d
        next_s = s + d
        if is_prime(next_n) && s != 0 && is_prime(fld(n, s))
            global result
            result += next_n
        end
        if next_s == 0 || next_n % next_s != 0
            continue
        end
        if k < max_digits
            search(k + 1, next_n, next_s)
        end
    end
end

search(1, 0, 0)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
