#=
Approach:
Suppose s1 s2 ... sk is a k digit increasing number. Then

9 9 ... 9 - s1 s2 ... sk = (9 - s1) (9 - s2) ... (9 - sk)

is a decreasing number. Therefore, unless s1 s2 ... sk is also a decreasing number,
i.e. s1 = s2 = ... = sk, then for each possible s1 s2 ... sk, with s1 != 9 we can
generate a new non-bouncy number. Therefore we only need to count decreasing numbers
with k digits, multiply the result by 2 and subtract the amount of numbers that are
both increasing and decreasing. Because this last condition implies s1 = s2 = ... = sk,
there are only 8 possible numbers with k digits and such property.

Notice that if s1 s2 ... sk is a decreasing number, then so is s2 ... sk. Therefore,
if dec(k, r) is the amount of decreasing numbers of k digits that start with r,
dec(k) is the amount of decreasing numbers with k digits:

dec(k) = dec(k, 1) + dec(k, 2) + ... + dec(k, 9)

and:

dec(k, r) = dec(k - 1, r) + dec(k - 1, r - 1) + ... + dec(k - 1, 1) + 1
dec(1, r) = 1

=#

using Printf

start = time()
result = 0

max_digits = 100
dec = [1 for r in 1:9]
for d in 1:max_digits
    global dec, result
    result += 2 * sum(dec[1:8]) + dec[9] - 8
    next_dec = [1 for _ in 1:9]
    for r in 1:9
        for t in 1:r
            next_dec[r] += dec[t]
        end
    end
    dec = next_dec
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
