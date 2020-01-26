#=
Approach:

Suppose f(u, k) is the number of non-trivial sequences starting in u, with k nonprimes. Therefore:

p(n, k) = sum(u <= n) f(u, k)

Or equivalently:

p(n, k) = p(n - 1, k) + f(n, k), p(0, k) = 0

Therefore the approach would be to use a prime sieve to calculate the prime counting function up to
n. Then for each initial value iteratively generate the sequeunces and add to the corresponding tally
of f(n, k). At the end use the recursion to calculate p(n, k) for k = 0, 1, ... . P(n) is the product
of these values.

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    n = 10^8
    m = 1000000007

    # Algorithm parameters
    max_k = 12

    # Solution
    slots = [p & 1 == 1 for p in 1:n]
    slots[1] = false
    slots[2] = true
    for p in 3:2:n
        if slots[p]
            for t in p^2:p:n
                slots[t] = false
            end
        end
    end

    memo_pi_fn = [0 for _ in 1:n]
    acc = 0
    for p in 1:n
        if slots[p]
            acc += 1
        end
        memo_pi_fn[p] = acc
    end

    f = zeros(Int64, n, max_k + 1)
    for u in 1:n
        ui = u
        k = 0
        i = 0
        while true
            i += 1
            if !slots[ui]
                k += 1
            end
            if i >= 2
                f[u, k + 1] += 1
            end
            if ui == 1
                break
            end
            ui = memo_pi_fn[ui]
        end
    end

    result = 1
    for k in 0:max_k
        total = 0
        for u in 1:n
            total += f[u, k + 1]
        end
        if total > 0
            result = mod(result * mod(total, m), m)
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
