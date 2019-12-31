#=
Approach:
Fast forward to the first Fibonacci number with leading 1-9 pandigital digits. Cast that number as a floating
point number. Then for each following Fibonacci number calculate the Fibonacci numbers mod 10^9 and the leading
digits using the formula Fn / Fn-1 ~ phi = (1 + sqrt(5)) / 2. If both the leading digits and the trailing digits
are 1-9 pandigital, then we are done. To prevent the leading digits from overflowing, every certain number of steps
we divide by 10. This uses the fact that floating point numbers are stored in the form n * 10^e.
=#

using Printf

function pandigital(b)
    d = 0
    for i in 1:9
        r = mod(b, 10)
        if r == 0 || (d & (1 << (r - 1))) != 0
            return false
        end
        d |= 1 << (r - 1)
        b = fld(b, 10)
    end
    return true
end

function main()
    start = time()
    result = 0

    m = 10^9
    p = (1.0 + sqrt(5.0)) / 2.0

    n = 2
    b, a = BigInt(1), BigInt(1)
    while n < 2749
        n += 1
        b, a = b + a, b
    end

    r = convert(Float64, fld(b, BigInt(10)^300))
    r /= 10.0 ^ (floor(log10(r)) - 8)
    b, a = convert(Int64, mod(b, m)), convert(Int64, mod(a, m))
    while true
        if pandigital(b)
            if pandigital(floor(Int64, r))
                result = n
                break
            end
        end
        n += 1
        b, a = mod(b + a, m), b
        r *= p
        if r >= m
            r /= 10
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
