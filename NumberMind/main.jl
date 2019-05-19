#=
Approach:
For each attempt, assign all possible configurations of correct guesses, until a
string is compatible with all guesses.
=#

using Printf

function search(n, attempts, forbidden, k, state, idx, curr)
    # No more attempts to consider
    if k > length(attempts)
        # It is sometimes possible to find solutions that leave a digit unassigned.
        # In this case we need to assign all possible digits to this solution
        # at these positions.
        dashidx = findfirst(x -> x == '-', state)
        if !isnothing(dashidx)
            for dig in 0:9
                new_state = copy(state)
                new_state[dashidx] = Char(dig + '0')
                result = search(n, attempts, forbidden, k, new_state, 0, 1)
                if !isempty(result)
                    return result
                end
            end
            return []
        end
        # If this is the correct solution then it has to match every string
        # at exactly the number of positions as correct matches there are.
        for (item, correct) in attempts
            count = sum([state[pos] == item[pos] ? 1 : 0 for pos in 1:n])
            if count != correct
                return []
            end
        end
        return state
    end
    # Extract current attempt info
    (item, num) = attempts[k]
    # If there are no correct guesses in the string, then we don't need to consider
    # it, as it is only used to set the forbidden.
    # If there are correct guesses, then we can only continue when we have found
    # a viable string.
    if num == 0 || num - curr < 0
        return search(n, attempts, forbidden, k + 1, state, 0, 1)
    end
    # Exclude solutions early by comparing with all attempts and making sure no
    # solution has more corrects than it should.
    for (entry, correct) in attempts
        count = sum([state[pos] == entry[pos] ? 1 : 0 for pos in 1:n])
        if count > correct
            return []
        end
    end
    # There are two options: either we set a new digit, or we allow an old digit
    # to correspond to the correct guess for this item.
    for pos in (idx + 1):(n - num + curr)
        dig = parse(Int64, item[pos])
        if state[pos] == '-'
            # If this digit is forbidden just continue.
            if forbidden[pos][dig + 1]
                continue
            end
            # Otherwise assign the new digit.
            new_state = copy(state)
            new_state[pos] = item[pos]
            result = search(n, attempts, forbidden, k, new_state, pos, curr + 1)
            if !isempty(result)
                return result
            end
        elseif state[pos] == item[pos]
            # If this assigned digit is forbidden then exit early.
            if forbidden[pos][dig + 1]
                return []
            end
            # Otherwise allow the old digit to correspond to the correct guess for
            # this item.
            result = search(n, attempts, forbidden, k, state, pos, curr + 1)
            if !isempty(result)
                return result
            end
        end
    end
    # If we have tried every possibility and nothing works then exit with error.
    return []
end

start = time()
result = 0

#=
n = 5
attempts = [
    ("90342", 2),
    ("70794", 0),
    ("39458", 2),
    ("34109", 1),
    ("51545", 2),
    ("12531", 1),
]
=#

n = 16
attempts = [
    ("5616185650518293", 2),
    ("3847439647293047", 1),
    ("5855462940810587", 3),
    ("9742855507068353", 3),
    ("4296849643607543", 3),
    ("3174248439465858", 1),
    ("4513559094146117", 2),
    ("7890971548908067", 3),
    ("8157356344118483", 1),
    ("2615250744386899", 2),
    ("8690095851526254", 3),
    ("6375711915077050", 1),
    ("6913859173121360", 1),
    ("6442889055042768", 2),
    ("2321386104303845", 0),
    ("2326509471271448", 2),
    ("5251583379644322", 2),
    ("1748270476758276", 3),
    ("4895722652190306", 1),
    ("3041631117224635", 3),
    ("1841236454324589", 3),
    ("2659862637316867", 2),
]

sort!(attempts, by = tup -> tup[2], rev = true)

k = 1
forbidden = [[false for _ in 0:9] for _ in 1:n]
for (item, num) in attempts
    global forbidden
    if num != 0
        continue
    end
    for pos in 1:n
        dig = parse(Int64, item[pos])
        forbidden[pos][dig + 1] = true
    end
end

state = ['-' for _ in 1:n]
result = search(n, attempts, forbidden, k, state, 0, 1)
if !isempty(result)
    result = join(result)
else
    result = ""
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
