#=
Approach:
Note that fn+1 = fn + fn-1 allows us to define a recurrence on Fn too. Notice that
Fn + x * Fn simplifies, after matching indices in the summations and using this
formula, to Fn / x + fn * x^n+1 + fn+1 * x^n - 1. Solving for Fn leaves us with:

Fn = (fn * x^n+2 + fn+1 * x^n+1 - x) / (x^2 + x - 1)

We can calculate the nth fibonacci number very fast using the identity:

f2k = fk * (2 * fk+1 - fk)
f2k+1 = fk+1^2 + fk^2

This identity can be proven the following way:

If k = 0 then f2k = 0 and f2k+1 = 1 and fk+1^2 + fk^2 = 1. Now, assume the equation
is true for 1, 2, ..., k-1, k. Then:

f2(k+1) = f2k+2
        = f2k+1 + f2k
        = fk+1^2 + fk^2 + fk * (2 * fk+1 - fk)
        = fk+1^2 + fk^2 + 2 * fk * fk+1 - fk^2
        = fk+1^2 + 2 * fk * fk+1
        = fk+1 * (fk+1 + 2 * fk)
        = fk+1 * (fk+2 + fk)
        = fk+1 * (fk+2 + fk+1 + fk - fk+1)
        = fk+1 * (2 * fk+2 - fk+1)

f2(k+1)+1 = f2k+3
          = f2k+2 + f2k+1
          = fk+1 * (2 * fk+2 - fk+1) + fk+1^2 + fk^2
          = 2 * fk+1 * fk+2 - fk+1^2 + fk+1^2 + fk^2
          = 2 * fk+1 * fk+2 + fk^2
          = 2 * fk+1 * fk+2 + (fk+2 - fk+1)^2
          = 2 * fk+1 * fk+2 + fk+2^2 - 2 * fk+2 * fk+1 + fk+1^2
          = fk+2^2 + fk+1^2

Solving Fn * (x^2 + x - 1) = (fn * x^n+2 + fn+1 * x^n+1 - x) mod 15! can be done
the following way:

Let z = Fn(x), a = x^2 + x - 1, m = 15!. Then the problem reduces to solving:

z = (fn * x^n+2 + fn+1 * x^n+1 - x) / a (mod m)

Now let dk = x^(2^k) div a, and rk = x^(2^k) mod a. Then x^(2^k) = dk * a + rk.
Notice that any power of x can be decomposed into a product of binary powers.
Suppose that x^n = x^(2^k0) * x^(2^k1) * ... * x^(2^km). Then:

x^n / a = dk0 * x^(2^k1) * ... * x^(2^km)
    + rk0 * dk1 * x^(2^k2) * ... * x^(2^km)
    + rk0 * rk1 * ... * rkm-1 * dkm
    + rk0 * rk1 * ... * rkm / a

dk and rk can be calculated iteratively. To see this notice that:

x^(2^(k+1)) = (x^(2^k))^2
            = (dk * a + rk)^2
            = dk^2 * a^2 + 2 * dk * rk + rk^2
            = dk+1 * a + rk+1

Therefore:

dk+1 = dk * a + 2 * dk * rk + (rk^2 div a)
rk+1 = rk^2 mod a

Similarly, if fk = dk * a + rk:

f2k = fk * (2 * fk+1 - fk)
    = (dk * a + rk) * (2 * (dk+1 * a + rk+1) - (dk * a + rk))
    = a * dk * (2 * (dk+1 * a + rk+1) - (dk * a + rk))
        + a * rk * (2 * dk+1 - dk)
        + rk * (2 * rk+1 - rk)

f2k+1 = fk+1^2 + fk^2
      = (dk+1 * a + rk+1)^2 + (dk * a + rk)^2
      = dk+1^2 * a^2 + 2 * dk+1 * rk+1 * a + rk+1^2 + dk^2 * a^2 + 2 * dk * rk * a + rk^2

Therefore:

d2k = a * dk * (2 * (dk+1 * a + rk+1) - (dk * a + rk))
        + a * rk * (2 * dk+1 - dk)
        + (rk * (2 * rk+1 - rk) div a)
r2k = rk * (2 * rk+1 - rk) mod a

d2k+1 = dk+1^2 * a + 2 * dk+1 * rk+1 + dk^2 * a + 2 * dk * rk + (rk^2 + rk+1^2 div a)
r2k+1 = rk+1^2 + rk^2 mod a

Notice that the previous allows us to compute x^n / a (mod m) rather easily. Now
notice that:

z = (x^(n+1) * (fn * x + fn+1) - x) / a

This problem can therefore be solved computationally using the previous results. Let:

x^(n+1) / a = dp + rp / a
fn / a = dc + rc / a
fn+1 / a = dn + rn / a

Therefore:

z = (dp + rp / a) * (fn * x + fn+1) - x / a
z = dp * (fn * x + fn+1) + rp * ((dc + rc / a) * x + (dn + rn / a)) - x / a
z = dp * (fn * x + fn+1) + rp * (dc * x + dn) + rp * (rc * x + rn) / a - x / a

And finally:

d = dp * (fn * x + fn+1) + rp * (dc * x + dn) + (rp * (rc * x + rn) - x div a)
r = rp * (rc * x + rn) - x mod a
=#

using Printf

function moddivpow(x, n, a, m)
    mask = reverse(string(n, base = 2))
    p = [k - 1 for k in 1:length(mask) if mask[k] == '1']
    upper = p[length(p)]
    df = [BigInt(1) for _ in p]
    rf = (BigInt(0), BigInt(1))
    di = mod(div(x, a), m)
    ri = mod(x, a)
    i = 1
    for k in 0:upper
        if p[i] == k
            xi = di * a + ri
            for j in 1:length(p)
                if j < i
                    term = xi
                elseif j == i
                    term = di
                else
                    term = ri
                end
                df[j] = mod(df[j] * term, m)
            end
            rfnum = mod(rf[1] * ri + div(rf[2] * ri, a), m)
            rfdiv = mod(rf[2] * ri, a)
            rf = (rfnum, rfdiv)
            i = i + 1
        end
        di = mod(di^2 * a + 2 * di * ri + div(ri^2, a), m)
        ri = mod(ri^2, a)
    end
    df = mod(sum(df) + rf[1], m)
    return (df, rf[2])
end

function modfib(n, m)
    if n == 0
        return (BigInt(0), mod(BigInt(1), m))
    end
    (a, b) = modfib(div(n, 2), m)
    c = a * mod(2 * b - a, m)
    c = mod(c, m)
    d = mod(a^2, m) + mod(b^2, m)
    d = mod(d, m)
    return n % 2 == 0 ? (c, d) : (d, (c + d) % m)
end

function moddivfib(n, a, m)
    if n == 0
        fc = (BigInt(0), BigInt(0))
        fn = (BigInt(0), mod(BigInt(1), m))
        return (fc, fn)
    end
    ((dc, rc), (dn, rn)) = moddivfib(div(n, 2), a, m)
    ds = dc * (2 * (dn * a + rn) - (dc * a + rc)) + rc * (2 * dn - dc)
    fr = rc * (2 * rn - rc)
    # Deal with negative values for fr
    ds = ds + BigInt(floor(fr / a))
    ds = mod(ds, m)
    rs = mod(fr, a)
    dt = dn^2 * a + 2 * dn * rn + dc^2 * a + 2 * dc * rc + div(rc^2 + rn^2, a)
    dt = mod(dt, m)
    rt = mod(rc^2 + rn^2, a)
    if n % 2 == 0
        return ((ds, rs), (dt, rt))
    else
        dq = ds + dt + div(rs + rt, a)
        dq = mod(dq, m)
        rq = mod(rs + rt, a)
        return ((dt, rt), (dq, rq))
    end
end

start = time()

n = BigInt(10^15)
m = BigInt(factorial(15))
k = 100
(fn_curr, fn_next) = modfib(n, m)
result = BigInt(0)

for x in 1:k
    global result
    x = BigInt(x)
    a = x^2 + x - 1
    (dp, rp) = moddivpow(x, n + 1, a, m)
    ((dc, rc), (dn, rn)) = moddivfib(n, a, m)
    d = dp * (fn_curr * x + fn_next) + rp * (dc * x + dn) + div(rp * (rc * x + rn) - x, a)
    d = mod(d, m)
    r = mod(rp * (rc * x + rn) - x, a)
    result = mod(result + d, m)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)

