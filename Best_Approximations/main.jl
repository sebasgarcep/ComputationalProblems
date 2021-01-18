using Printf

function simplify(a, b)
    g = gcd(a, b)
    a = div(a, g)
    b = div(b, g)
    return a, b
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    l = BigInt(10^5)
    bound = BigInt(10^12)

    # Algorithm parameters
    base = 1
    base_2 = base * base

    # Solution
    for n in 1:l
        if n == base_2
            base += 1
            base_2 = base * base
            continue
        end
        s, t = 0, 1
        closest_d = nothing
        sqrt_n = sqrt(n)
        a, b = BigInt(base - 1), BigInt(1)
        c, d = BigInt(base), BigInt(1)
        while true
            e, f = simplify(a + c, b + d)
            if a * a <= n * b * b && n * f * f <= e * e
                c, d = e, f
            else
                a, b = e, f
            end
            if f > bound
                break
            end
            new_d = abs(sqrt_n - e/f)
            if closest_d == nothing || new_d < closest_d
                s, t = e, f
                closest_d = new_d
            end
        end
        result += t
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
