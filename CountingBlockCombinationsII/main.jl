#=
Approach:
Use binary search to find a solution.
=#

using Printf

function f(m, n)
    total = 0
    for k in 0:div(n + 1, m + 1)
        r = n - (m + 1) * k + 1
        s = 2 * k + 1
        total += binomial(r + s - 1, r)
    end
    return total
end

start = time()

m = 50
lower = 50
upper = 50

while f(m, upper) < 10^6
    global upper
    upper = upper * 2
end

while upper - lower > 1
    global lower, upper
    test = div(lower + upper, 2)
    value = f(m, test)
    if value == 10^6
        lower = test
        upper = test
        break
    elseif value < 10^6
        lower = test
    else
        upper = test
    end
end

result = upper

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)


