#=
Approach:
Let S(p) be the sum of all n, so that T(n) is p-smooth. Notice that T(n) = n * (n + 1) / 2.
Thus T(n) is p-smooth if n and n+1 are p-smooth, for p > 2.

Using Stormer's theorem with Lehmer's method we can solve this problem.

FIXME: missing proof for Stormer's theorem.

Finally, from OEIS A117581, the largest p-smooth number for p = 47 is 1109496723125. Thus,
we can stop searching when we go over this value.

Sources:
https://en.wikipedia.org/wiki/St%C3%B8rmer%27s_theorem
https://projecteuclid.org/download/pdf_1/euclid.ijm/1256067456

=#

using Printf

function is_smooth(primes, x)
    xv = x
    for p in primes
        while xv % p == 0
            xv = fld(xv, p)
        end
    end
    return xv == 1
end

function solve(primes, v, s)
    r = 0
    n = 0
    d = 2 * v
    ul = BigInt(2)^65 + 1 # (p - 1) / 2 < 2^64
    # Solve Pell's equation
    a0 = BigInt(floor(sqrt(d)))
    mk = BigInt(0)
    dk = BigInt(1)
    ak = a0
    p_prev = BigInt(1)
    q_prev = BigInt(0)
    p = ak
    q = BigInt(1)
    while n < s && p < ul
        mk = ak * dk - mk
        dk = div(d - mk^2, dk)
        ak = div(a0 + mk, dk)
        p_temp = p
        q_temp = q
        p = ak * p + p_prev
        q = ak * q + q_prev
        p_prev = p_temp
        q_prev = q_temp
        if p^2 - d * q^2 == 1
            # Generate result
            x1 = fld(p - 1, 2)
            x2 = fld(p + 1, 2)
            if is_smooth(primes, x1) && is_smooth(primes, x2)
                r += x1
            end
            n += 1
        end
    end
    return r
end

function search(result, primes, s, i, q)
    if i > length(primes)
        if q != 2
            result += solve(primes, q, s)
        end
        return result
    end
    result = search(result, primes, s, i + 1, q)
    result = search(result, primes, s, i + 1, q * primes[i])
    return result
end

start = time()
result = 0

p = 47

primes = []
slots = [true for _ in 1:p]
slots[1] = false
for k in 2:p
    global slots
    if slots[k]
        push!(primes, k)
        for t in (2 * k):k:p
            slots[t] = false
        end
    end
end

pmax = last(primes)
s = max(3, fld(pmax + 1, 2))
result = search(result, primes, s, 1, 1)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
