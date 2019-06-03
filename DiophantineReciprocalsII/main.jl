#=
Approach:
We build on Diophantine Reciprocals I for our solution.

To optimize the previous procedure let n = p1^k1 * p2^k2 * ... * pm^km. If k = 1
then for n = a * b and gcd(a, b) = 1, a must use a complete prime power or none
of it. Therefore there are 2^m different picks of prime powers. Notice that for
each pick, its complement is also a valid pick, and because a <= b either the pick
or the complement can be assigned to a. Therefore there are 2^m/2 = 2^(m - 1) ways
to pick a for a given prime factorization.

Now suppose k > 1. The previous logic can be applied to n/k. Notice that if k completely
uses r prime powers, then there are 2^(m - r - 1) possible picks for a. Therefore
we can calculate the number of solutions for this equation by using the fact that
all values of k that do not completely exhaust a prime power will have the same
number of solutions if the amount of times they take from each of the other prime
powers remains fixed. Therefore we can muliply over these possible values for k,
for each prime power. If a value of k completely exhausts a prime power then we
don't have to muliply but instead increase the value of r.

Notice that the previous description doesn't care about the values of the primes
that divide n. Therefore our solution will have the first n primes, raised to a
sequence of non-increasing powers.

The product of the first 15 primes produces 7174454 solutions. Therefore our solution
will have at most 15 different primes.

Notice that 2^60 > (product of first 15 primes). Therefore, for any prime p,
p^60 is larger than the product of the first 15 primes. Therefore we can safely
assume that our solution won't have any prime power larger than 60.

Finally, we will use tree search on the powers of the first 15 primes, where
each prime can only have at most the same exponent value as the prime before it.
If we find a value that is larger than the current minimal value, then we can
exit early from that branch of the tree.

=#

using Printf

start = time()
result = 0

primes = [
    Int128(2),
    Int128(3),
    Int128(5),
    Int128(7),
    Int128(11),
    Int128(13),
    Int128(17),
    Int128(19),
    Int128(23),
    Int128(29),
    Int128(31),
    Int128(37),
    Int128(41),
    Int128(43),
    Int128(47)
]

min_value = prod(primes)

function count_step(factors, acc, k, p, r)
    if k > length(factors) || factors[k] == 0
        m = k - 1
        if m - r == 0
            return acc + 1
        end
        return acc + p * 2^(m - r - 1)
    end
    acc = count_step(factors, acc, k + 1, p * factors[k], r)
    acc = count_step(factors, acc, k + 1, p, r + 1)
    return acc
end

function count(factors)
    return count_step(factors, 0, 1, 1, 0)
end

function search(value, factors, k)
    global min_value
    if k > 15
        if count(factors) > 4 * 10^6
            if value < min_value
                min_value = value
            end
        end
        return
    end
    if k == 1
        upper = 60
    else
        upper = factors[k - 1]
    end
    acc = 1
    for p in 0:upper
        next_value = value * acc
        if next_value >= min_value
            return
        end
        next_factors = copy(factors)
        push!(next_factors, p)
        search(next_value, next_factors, k + 1)
        acc *= primes[k]
    end
end

search(Int128(1), [], 1)
result = min_value

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
