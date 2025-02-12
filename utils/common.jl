module Common

export iroot

"""
Computes the b-th root of a
"""
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

"""
Computes sum(n=1, x) n
"""
function summation_formula(modulo::Int64, x::Int64)::Int64
    value = 1
    if x & 1 == 0
        value = mod(x >> 1, modulo);
        value *= mod(x + 1, modulo)
    else
        value = mod(x, modulo);
        value *= mod((x + 1) >> 1, modulo)
    end
    value = mod(value, modulo)
    return value
end

end