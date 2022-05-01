using Printf
using AbstractAlgebra
using PolynomialRoots

function sequence_range(x, p)
    x_min = x
    x_max = x
    println(x)
    for _ in 1:p
        x -= 1.0 / x
        println(x)
        x_min = min(x_min, x)
        x_max = max(x_max, x)
    end
    return x_max - x_min
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution=
    _, x = PolynomialRing(ZZ, "x")

    g = x^1
    h = x^0
    for p in 1:5
        println(p)
        g, h = g^2 - h^2, g * h
        r = x * h - g
        println((p, r))
        if p > 1
            coeffs_r = [c for c in coefficients(r)]
            roots_r = sort([real(x) for x in PolynomialRoots.roots(coeffs_r)])
            println(first(roots_r))
            println(last(roots_r))
        end
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
