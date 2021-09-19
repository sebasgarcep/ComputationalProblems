using Printf
using SparseArrays
using LinearAlgebra

function iroot(a, b)
    if b == 1
        return a
    end

    if b == 2
        return isqrt(a)
    end

    test_value = Int64(floor(Float64(a)^(1.0 / b)))
    if (test_value + 1)^b <= a
        return test_value + 1
    end
    
    return test_value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    n = 1000

    # Algorithm parameters

    # Solution
    a = [
        (2.0 / 3.0) (-1.0 / 2.0) 0.0;
        0.0 (1.0 / 4.0) (-1.0 / 5.0);
        4.0 (4.0 * (n - 2)) (n - 2)^2
    ]

    b = [
        (1.0 / 2.0) (-1.0 / 3.0) 0.0;
        0.0 (1.0 / 6.0) (-1.0 / 8.0);
        4.0 (4.0 * (n - 2)) (n - 2)^2
    ]

    c = [0.0; 0.0; 1.0]

    v_one = a \ c
    v_two = b \ c

    for k in 1:n
        pos = k^2
        j = mod(pos, n)
        if j == 0
            j = n
        end
        i = fld(pos - j, n) + 1
        if (i == 1 || i == n) && (j == 1 || j == n)
            result += v_one[1]
            result += v_two[1]
        elseif (i == 1 || i == n) || (j == 1 || j == n)
            result += v_one[2]
            result += v_two[2]
        else
            result += v_one[3]
            result += v_two[3]
        end
    end

    result /= 2.0

    # Show result
    @printf("%.12f\n", result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
