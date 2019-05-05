#=
Approach:
Build a list of all the square so that no consecutive pair of squares is larger
than 10^8. Clearly, if we've already found the smallest consecutive pair that
satisfies this property, then all subsequent pairs will satisfy it. Then build all
sums over the consecutive squares in this list. For each sum test whether it
satisfies the palindromic property. Because we cannot ensure that a number will
not get repeated by two different sums, whenever we find a number that satisfies
all these properties we add it to a Set. Finally, add all the numbers in the set.
=#

using Printf

function is_palindromic(n)
    strn = string(n)
    len = length(strn)
    for i in 1:fld(len, 2)
        if strn[i] != strn[len - i + 1]
            return false
        end
    end
    return true
end

start = time()
result = 0

result_set = Set()

bound = 10^8

squares = []
curri = 0
currs = 0
nexti = 1
nexts = 1
while currs + nexts < bound
    global curri, currs, nexti, nexts
    push!(squares, nexts)
    curri = nexti
    currs = nexts
    nexti = curri + 1
    nexts = nexti^2
end

for fst in 1:(length(squares) - 1)
    global result_set
    total = squares[fst]
    for lst in (fst + 1):length(squares)
        total += squares[lst]
        if total >= bound
            break
        end
        if is_palindromic(total)
            push!(result_set, total)
        end
    end
end

println(result_set)
result = sum(result_set)
println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
