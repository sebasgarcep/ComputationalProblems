#=
Approach:
Then the string is composed of the following set of non-adjacent substrings:

- single L
- double L
- single A
- arbitrary number of O's

with the restriction that there can never be more than one A.

Assume the period length is p. Suppose there are k1 single Ls and k2 double Ls.
They can be ordered in (k1 + k2 choose k1) different ways leaving p - k1 - 2 * k1
characters to take the value of either A or O. Notice that for each pair of single L
or double L substrings there is at least one non-L substring in between. Therefore
k1 + 2 * k2 + k1 + k2 - 1 <= p, or 2 * k1 + 3 * k2 <= p + 1, or k2 <= (p + 1 - 2 * k1) / 3.
If k2 = 0, then k1 <= (p + 1) / 2. After choosing k1 and k2 we need to set k1 + k2 - 1
O's in between the single L's and double L's (assuming no A's are to be placed, we
will deal with that later). The remaining characters are therefore r = p - 2 * k1 - 3 * k2 + 1,
which we have to distribute among k1 + k2 + 1 bins. The number of different ways
of doing this is (r + k1 + k2 choose r). Notice that we can either place A or not.
If we do not place A, then the previous calculations allow us to calculate the number
of arrangements. If we do, then we only have to calculate the number of arrangements
for the substring to the left of A and multiply it by the number of different arrangements
of the substring to the right of A, for each possible location where A can be placed.
=#

using Printf

function arrangements(period)
    total = 0
    for k1 in 0:fld(period + 1, 2)
        for k2 in 0:fld(period + 1 - 2 * k1, 3)
            remaining = period - max(0, 2 * k1 + 3 * k2 - 1)
            arrangements = binomial(k1 + k2, k1) * binomial(remaining + k1 + k2, remaining)
            total += arrangements
        end
    end
    return total
end

period = 30

start = time()
result = 0

for a in 0:period
    global result
    if a == 0
        result += arrangements(period)
    else
        result += arrangements(a - 1) * arrangements(period - a)
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
