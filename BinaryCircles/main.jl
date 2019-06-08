#=
Approach:
For a 2^N length string, there are 2^N possible rotations. Therefore we need to
take exactly 2^N steps in our recursive search. In each step we branch out by
attempting to add either a 0 or 1 to the end, if we haven't already used the
subsequence it forms. We keep track of the used subsequences with a bitflag.
Once we already have a length 2^N string we need to wrap it around and test if
the resulting subsequences haven't been used with the bitflag.
=#

using Printf

start = time()
result = 0

n = 3
m = 2^n

function search(acc, k, flag)
    global result
    if k >= m
        result += acc
        return
    end
    if k <= m - n
        acc_zero = acc * 2
        mark_zero = 2^(acc_zero & (m - 1))
        if flag & mark_zero == 0
            search(acc_zero, k + 1, flag | mark_zero)
        end
        acc_ones = acc * 2 + 1
        mark_ones = 2^(acc_ones & (m - 1))
        if flag & mark_ones == 0
            search(acc_ones, k + 1, flag | mark_ones)
        end
    else
        r = n - m + k
        acc_test = (acc << r) & (2^n - 1)
        mark_test = 2^acc_test
        if flag & mark_test == 0
            search(acc, k + 1, flag | mark_test)
        end
    end
end

search(0, 1, 1)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
