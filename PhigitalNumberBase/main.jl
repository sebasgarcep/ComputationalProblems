#=
Approach:
Notice that phi^47 < 10^10 < phi^48. Therefore all number will have at most
47 digits after the decimal point.

Notice also that:
phi^-1 = 2 / (1 + sqrt(5)) = 2 * (1 - sqrt(5)) / (1 - 5) = (-1 + sqrt(5)) / 2

It is easy to show that all elements of the sequence phi^n are of the form a + b * sqrt(5):

phi^n = (a + b * sqrt(5)) / 2
phi * phi^n = (1 + sqrt(5)) * (a + b * sqrt(5)) / 4
            = (a + b * sqrt(5) + a * sqrt(5) + 5 * b) / 4
            = ((a + 5 * b) / 2 + (a + b) / 2 * sqrt(5)) / 2

phi^-n = (c - d * sqrt(5)) / 2
phi^-1 * phi^-n = (-1 + sqrt(5)) / 2 * (c - d * sqrt(5)) / 2
                = (- c + d * sqrt(5) + c * sqrt(5) - d * 5) / 4
                = (- (c + 5 * d) / 2 + (c + d) / 2 * sqrt(5)) / 2

This also allows us to prove that if phi^n = an + bn * sqrt(5), then:

an+1 = (an + 5 * bn) / 2, n >= 1
bn+1 = (an + bn) / 2, n >= 1

a0 = 2
b0 = 0

a-n = (-1)^n * an, n > 0
b-n = (-1)^(n-1) * bn, n > 0

Notice that due to the shape of the elements of phi^n, a sum of elements of this
sequence is only an integer when the the sum of the bn terms equals 0. Because
bn > 0 for n > 0, then the only sum of positive powers of phi that reduces to
an integer is phi^0 = 1. Therefore, for all other sums, because we care about
palindromic digital representations, whenever we add phi^n we need to add phi^-(n + 1)
too.

Notice that because powers of phi cannot be consecutive, then phi^0 cannot be part
of our sum for other integer values.

Let's prove that an + a-(n + 1) forms the sequence:

1, 0, 1, 1, 0, 1, 1, ...

Notice that a0 = 1, b0 = 0. Then:

a1 = (2 + 5 * 0) / 2 = 1
b1 = (2 + 0) / 2  = 1

a2 = (1 + 5 * 1) / 2 = 3
b2 = (1 + 1) / 2 = 1

a3 = (3 + 5 * 1) / 2 = 4
b3 = (3 + 1) / 2 = 2

a4 = (4 + 5 * 2) / 2 = 7
b4 = (4 + 2) / 2 = 3

Thus:

a0 + a-1 = a0 - a1 = 2 - 1 = 1 = 1 (mod 2)
a1 + a-2 = a1 + a2 = 1 + 3 = 4 = 0 (mod 2)
a2 + a-3 = a2 - a3 = 3 - 4 = -1 = 1 (mod 2)

Because a0 = a3 = 0 (mod 2) and a1 = a4 = 1 (mod 2), then the cycle repeats on and on
to infinity, as addition and subtraction are equivalent (mod 2).

Notice also that the sum over the an's must equal 0 (mod 2). Therefore we can
solve this equation by choosing, from each consecutive pair of 1's either one
of them, or none of them. After we've found our tentative solution, we look
for -bn terms in the solutions with just the 0s. If the 1's solution and the 0's
solution are compatible, then we add them.

=#

using Printf

start = time()
result = 0

phi = (1 + sqrt(5)) / 2
bound = 10^10
max_power = floor(Int64, log(phi, bound))

phi_vals = []
a_prev = 2
b_prev = 0
for n in 0:max_power
    global a_prev, b_prev
    a_next = fld(a_prev + 5 * b_prev, 2)
    b_next = fld(a_prev + b_prev, 2)
    curr_val = [a_prev + (-1)^(n + 1) * a_next, b_prev + (-1)^n * b_next]
    push!(phi_vals, curr_val)
    a_prev = a_next
    b_prev = b_next
end

sqrt_5 = sqrt(5)
phi_length = length(phi_vals)

zero_sols = Dict()
function search_zeros(acc, k, pows)
    if acc[1] + acc[2] * sqrt_5 > 2 * bound
        return
    end
    if !haskey(zero_sols, acc[2])
        zero_sols[acc[2]] = []
    end
    push!(zero_sols[acc[2]], (acc, pows))
    for j in (k + 3):3:phi_length
        if mod(phi_vals[j][1], 2) != 0
            continue
        end
        next_pows = copy(pows)
        next_pows[j] = 1
        search_zeros(acc + phi_vals[j], j, next_pows)
    end
end
search_zeros([0, 0], -1, [0 for _ in 1:phi_length])

function iscompatible(ones_pows, zero_pows)
    for i in 1:length(ones_pows)
        if ones_pows[i] == 1
            if i > 1
                if zero_pows[i - 1] == 1
                    return false
                end
            end
            if i < length(ones_pows)
                if zero_pows[i + 1] == 1
                    return false
                end
            end
        end
    end
    return true
end

function search_ones(acc, k, pows)
    global result
    if acc[1] + acc[2] * sqrt_5 > 2 * bound
        return
    end
    if acc[1] % 2 == 0
        if haskey(zero_sols, -acc[2])
            for (zero_acc, zero_pows) in zero_sols[-acc[2]]
                if iscompatible(pows, zero_pows)
                    result += fld(acc[1] + zero_acc[1], 2)
                end
            end
        end
    end
    for j in (k + 2):phi_length
        if mod(phi_vals[j][1], 2) == 0
            continue
        end
        next_pows = copy(pows)
        next_pows[j] = 1
        search_ones(acc + phi_vals[j], j, next_pows)
    end
end
search_ones([0, 0], 0, [0 for _ in 1:phi_length])

result += 1

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
