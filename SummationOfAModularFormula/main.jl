using Printf

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^7

    # Algorithm parameters
    bound = n - 1

    # Solution
    slots = [true for _ in 1:bound]
    slots[1] = false
    for p in 2:bound
        if slots[p]
            for k in (p^2):p:bound
                slots[k] = false
            end

            if p > 2
                # Calculate m
                m_expo = powermod(2, p, p - 1)
                m = powermod(2, m_expo, p)

                # Calculate k_f
                k_f = cld(m, 2)

                # Calculate x mod p
                xp = mod(1 + mod(Int128(p - 1) * powermod(2, p - 1, p^2), p^2), p^2)
                x = Int64(fld(xp, p))

                # Calculate f(p) mod p
                result += mod(mod(2 * mod(k_f, p), p) - mod(m * x, p), p)
            end
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
