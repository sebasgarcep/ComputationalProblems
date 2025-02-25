module ChineseRemainderTheorem

"""
Suppose n_i and n_j are coprime. Then this function
returns the value a modulo n_i * n_j such that:

a = a_i (mod n_i)
a = a_j (mod n_j)
"""
function solve(a_i::T, n_i::T, a_j::T, n_j::T)::T where T<:Integer
    n = n_i * n_j
    a_l = mod(mod(a_i * n_j, n) * invmod(n_j, n_i), n)
    a_r = mod(mod(a_j * n_i, n) * invmod(n_i, n_j), n)
    return mod(a_l + a_r, n)
end

end
