using Printf

struct FieldExtensionMod
    a::Int64
    b::Int64
    m::Int64

    FieldExtensionMod(a::Int64, b::Int64, m::Int64) = new(mod(a, m), mod(b, m), m)

    function Base.:+(f1::FieldExtensionMod, f2::FieldExtensionMod)
        return new(
            mod(f1.a + f2.a, f1.m),
            mod(f1.b + f2.b, f1.m),
            f1.m,
        )
    end

    function Base.:*(f1::FieldExtensionMod, f2::FieldExtensionMod)
        return new(
            mod(mod(f1.a * f2.a, f1.m) + 5 * mod(f1.b * f2.b, f1.m), f1.m),
            mod(mod(f1.b * f2.a, f1.m) + mod(f1.a * f2.b, f1.m), f1.m),
            f1.m,
        )
    end

    function Base.:*(s::Int64, f::FieldExtensionMod)
        return new(mod(s * f.a, f.m), mod(s * f.b, f.m), f.m)
    end

    function Base.:*(f::FieldExtensionMod, s::Int64)
        return s * f
    end

    function Base.:^(f::FieldExtensionMod, e::Int64)
        s = FieldExtensionMod(1, 0, f.m)
        a = f
        while e > 0
            if e & 1 == 1
                s = s * a
            end
            a = a * a
            e = e >> 1
        end
        return s
    end
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 10^18
    mod_size = 10^9 + 9

    # Algorithm parameters

    # Solution
    numerator = 64 * mod(
        mod(
            powermod(4, n, mod_size) *
            (
                FieldExtensionMod(5, 3, mod_size) * FieldExtensionMod(1, 1, mod_size)^(n - 3)
                + FieldExtensionMod(5, -3, mod_size) * FieldExtensionMod(1, -1, mod_size)^(n - 3)
            ).a,
            mod_size,
        )
        + mod(
            powermod(-4, n - 3, mod_size) * 80,
            mod_size
        ),
        mod_size,
    )

    numerator = mod(numerator, mod_size)

    denominator = 80 * mod(
        powermod(4, 2 * n, mod_size)
        - mod(
            powermod(4, n, mod_size) * (
                FieldExtensionMod(1, 1, mod_size)^n + FieldExtensionMod(1, -1, mod_size)^n
            ).a,
            mod_size,
        )
        + powermod(-4, n, mod_size),
        mod_size,
    )

    denominator = mod(denominator, mod_size)

    result = mod(numerator * invmod(denominator, mod_size), mod_size)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
