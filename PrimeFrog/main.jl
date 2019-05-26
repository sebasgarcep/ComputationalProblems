#=
Approach:
Use the Sieve of Eratosthenes to calculate primes for numbers 1 through 500. We
will use the fact that if we are currently on round N it doesn't matter what happened
during the previous N-1 rounds, only the odds of getting to the position we got.
Therefore, in each round we calculate, given the current probability of ending up
where we ended, what is the probability of the next state that matches the given
sequence and we add that probability to the accumulator for the position of the
next state. We will do this until we've exhausted the given sequence. The final
probability is the sum over the final probabilities for each position.
=#

using Printf

start = time()
result = 0

bound = 500
sequence = "PPPPNNPPPNPPNPN"

slots = [true for _ in 1:bound]
slots[1] = false
for n in 2:bound
    if slots[n]
        for k in (2 * n):n:bound
            slots[k] = false
        end
    end
end

function fracsim(n, d)
    c = gcd(n, d)
    n = fld(n, c)
    d = fld(d, c)
    return n, d
end

function fracadd(n1, d1, n2, d2)
    return fracsim(n1 * d2 + n2 * d1, d1 * d2)
end

function fracmul(n1, d1, n2, d2)
    return fracsim(n1 * n2, d1 * d2)
end

res_num = 0
res_den = 1

curr = [(BigInt(1), BigInt(bound)) for _ in 1:bound]
for k in 1:length(sequence)
    global curr
    next = [(BigInt(0), BigInt(1)) for _ in 1:bound]
    for pos in 1:bound
        curr_num, curr_den = curr[pos]
        for j in -1:2:1
            if (j == -1 && pos == 1) || (j == 1 && pos == bound)
                continue
            end
            pr_num = slots[pos] == (sequence[k] == 'P') ? 2 : 1
            pr_den = pos > 1 && pos < bound ? 6 : 3
            new_num, new_den = fracmul(curr_num, curr_den, pr_num, pr_den)
            next_num, next_den = next[pos + j]
            next[pos + j] = fracadd(next_num, next_den, new_num, new_den)
        end
    end
    curr = next
end

for pos in 1:bound
    global res_num, res_den
    curr_num, curr_den = curr[pos]
    res_num, res_den = fracadd(res_num, res_den, curr_num, curr_den)
end

result = @sprintf("%d/%d", res_num, res_den)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
