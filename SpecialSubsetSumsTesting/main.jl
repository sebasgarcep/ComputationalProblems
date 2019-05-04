#=
Approach:
Test all sets.
=#

using Printf

start = time()
result = 0

function test_recursive(test_set, idx, b, c)
    if idx > length(test_set)
        lb = length(b)
        lc = length(c)
        if lb == 0 || lc == 0
            return true
        end
        sb = sum(b)
        sc = sum(c)
        if lb == lc
            return sb != sc
        elseif lb > lc
            return sb > sc
        else # lb < lc
            return sb < sc
        end
    end

    if !test_recursive(test_set, idx + 1, b, c)
        return false
    end

    new_b = copy(b)
    push!(new_b, test_set[idx])
    if !test_recursive(test_set, idx + 1, new_b, c)
        return false
    end

    new_c = copy(c)
    push!(new_c, test_set[idx])
    if !test_recursive(test_set, idx + 1, b, new_c)
        return false
    end

    return true
end

function test(test_set)
    return test_recursive(test_set, 1, [], [])
end

contents = open("sets.txt") do file
    read(file, String)
end

contents = strip(contents)
contents = split(contents, "\n")
contents = map(x -> string.(split(x, ",")), contents)
contents = map(x -> parse.(Int64, x), contents)

for item in contents
    global result
    if test(item)
        result += sum(item)
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
