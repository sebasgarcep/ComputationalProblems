using Printf
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

    # Algorithm parameters

    # Solution
    a = [
        # System Equations
        # 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1;
        1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0;
        0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0;
        0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0;
        0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1;
        1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
        0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0;
        # Free variables
        1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0;
    ]

    a_inv = inv(a)

    for x1 in 0:9
        for x2 in 0:9
            for x3 in 0:9
                for x5 in 0:9
                    for x6 in 0:9
                        for x7 in 0:9
                            for x9 in 0:9
                                for s in max(x1 + x2 + x3, x5 + x6 + x7, x1 + x5 + x9):40
                                    b = [
                                        s;
                                        s;
                                        s;
                                        s;
                                        s;
                                        s;
                                        s;
                                        s;
                                        s;
                                        x1;
                                        x2;
                                        x3;
                                        x5;
                                        x6;
                                        x7;
                                        x9;
                                    ]
                                    x = a_inv * b
                                    valid = true
                                    for i in 1:16
                                        if x[i] < 0.0 || x[i] > 9.0
                                            valid = false
                                            break
                                        end
                                        if !isinteger(x[i])
                                            valid = false
                                            break
                                        end
                                    end
                                    if valid
                                        result += 1
                                    end
                                end
                            end
                        end
                    end
                end
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
