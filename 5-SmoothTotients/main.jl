"""
Approach:
If phi(n) is a Hamming Number then its largest prime factor doesn't exceed 5.
Therefore phi(n) = 2^k1 * 3^k2 * 5^k3. If n = p1^r1 * p2^r2 * ... * pm^rm,
then phi(n) = p1^(r1 - 1) * (p1 - 1) * p2^(r2 - 1) * (p2 - 1) * ... * pm^(rm - 1) * (pm - 1),
where ri > 0 and pi are distinct prime numbers. If ri = 1, then (pi - 1) | phi(n),
and thus (pi - 1) is a Hamming Number. Otherwise pi = 2, 3, 5.

Let, without loss of generality, n = 2^r1 * 3^r2 * 5^r3 * p4 * p5 * ... * pm.
Therefore we need to take factors of 2, 3 and 5 from the factorization of phi(n)
and test whether the product of those factors plus one is a prime number.

To prevent duplicates, lets start with n = p4 * p5 * ... * pm. Then we add
factors of 2, 3, 5 until we reach the L limit. For this let's find all prime
numbers we can form. Then we find all distinct possible products of these
prime numbers by iterating over the list of primes and skipping
that prime one one of the recursive branches and multiplying it to a running total
on the other.

"""

using Printf

start = time()
result = 0

l = 10^12
m = 2^32
primes = []

function is_prime(n)
    if n == 1
        return false
    end
    if n == 2
        return true
    end
    if mod(n, 2) == 0
        return false
    end
    for k in 3:2:isqrt(n)
        if n % k == 0
            return false
        end
    end
    return true
end

function traverse(primes, index, total)
    if index > length(primes)
        return
    end
    next_total = BigInt(total) * primes[index]
    if next_total <= l
        next_total = Int64(next_total)
        search(next_total)
        traverse(primes, index + 1, total)
        traverse(primes, index + 1, next_total)
    end
end

function search(total)
    for k3 in 0:floor(log(5, l / (total * 1.0)))
        for k2 in 0:floor(log(3, l / (total * 5^k3)))
            k1 = floor(log(2, l / (total * 3^k2 * 5^k3)))
            global result
            # 2^0 + 2^1 + ... + 2^k1 = 2^(k1 + 1) - 1
            result += total * 5^k3 * 3^k2 * (2^(k1 + 1) - 1)
            result = mod(result, m)
        end
    end
end

function generate_primes()
    global primes
    for k3 in 0:floor(log(5, l))
        for k2 in 0:floor(log(3, l / 5^k3))
            for k1 in 0:floor(log(2, l / (3^k2 * 5^k3)))
                p = Int64(2^k1 * 3^k2 * 5^k3 + 1)
                if p > l || p <= 5
                    continue
                end
                if is_prime(p)
                    push!(primes, p)
                end
            end
        end
    end
    primes = unique(primes)
    primes = sort(primes)
end

generate_primes()
search(1)
traverse(primes, 1, 1)

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
