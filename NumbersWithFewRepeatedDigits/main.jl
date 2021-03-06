#=
Approach:
Notice that we want to find the solutions to the equation:

x0 + x1 + ... + x9 = 18

where 0 <= xi <= 3, for i = 0, 1, ... , 9. Then, if (x0, x1, ... , x9) is a solution
the numbers generated by that solution are 18! / (x0! * x1! * ... * x9!). If x0 > 0
we need to subtract (18 - 1)! / ((x0 - 1)! * x1! * ... * x9!) = 18! / (x0! * x1! * ... * x9!) * x0 / 18,
which are the amount of numbers with a leading zero.

=#

using Printf

digits = 18

function solve(acc, free, d, z, sols)
    if d > 10
        if z > 0
            other = fld(sols * z, digits)
            return acc + sols - other
        else
            return acc + sols
        end
    end

    # There is only one way to do the last pick
    if d == 10
        if free > 3
            return acc
        else
            return solve(acc, 0, d + 1, free, sols)
        end
    end

    for x in 0:min(free, 3)
        new_sols = sols * binomial(free, x)
        acc = solve(acc, free - x, d + 1, z, new_sols)
    end

    return acc
end

start = time()
result = solve(0, digits, 1, 0, 1)

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
