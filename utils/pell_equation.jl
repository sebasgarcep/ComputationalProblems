module PellEquation

mutable struct SquareRootConvergents
    const n::BigInt
    const a_0::BigInt
    m::BigInt
    d::BigInt
    a::BigInt
    p_curr::BigInt
    q_curr::BigInt
    p_prev::BigInt
    q_prev::BigInt

    function SquareRootConvergents(n::T) where T<:Integer
        return new(
            BigInt(n),
            BigInt(isqrt(n)), # a_0
            BigInt(0), # m
            BigInt(1), # d
            BigInt(isqrt(n)), # a
            BigInt(isqrt(n)), # p_curr
            BigInt(1), # q_curr
            BigInt(1), # p_prev
            BigInt(0), # q_prev
        )
    end
end

"""
Computes the convergents pk/qk for the square root of D.

m0 = 0
d0 = 1
a0 = isqrt(D)
p0 = isqrt(D)
q0 = 1
p-1 = 1
q-1 = 0
mk = dk-1 * ak-1 - mk-1
dk = (D - mk^2) / dk-1
ak = floor((a0 + mk) / dk)
pk = ak * pk-1 + pk-2
qk = ak * qk-1 + qk-2
"""
function next_convergent(this::SquareRootConvergents)::Tuple{BigInt, BigInt}
    m_prev = this.m
    d_prev = this.d
    a_prev = this.a
    p_prev = this.p_curr
    q_prev = this.q_curr
    p_olds = this.p_prev
    q_olds = this.q_prev
    this.m = d_prev * a_prev - m_prev
    this.d = fld(this.n - this.m^2, d_prev)
    this.a = fld(this.a_0 + this.m, this.d)
    this.p_curr = this.a * p_prev + p_olds
    this.q_curr = this.a * q_prev + q_olds
    this.p_prev = p_prev
    this.q_prev = q_prev
    return (this.p_prev, this.q_prev)
end

end