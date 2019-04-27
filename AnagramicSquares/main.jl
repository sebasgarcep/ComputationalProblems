#=
Approach:
An anagramic square is a pair of different words that are anagrams of each other,
and that when the digits are replaced by numbers, both are squares. To solve this
problem we sort the letters of every word and only when two words in sorted order
are equal are they anagrams of each other. Therefore for these sets of words we
only need to find a mapping that produces square for each pair. Finally we solve
this problem by generating all mappings and testing the results of each on each
pair of anagramic words.
=#

using Printf

function generate_maps(maps, key, pos, current, remaining)
    if pos > length(key)
        push!(maps, current)
        return
    end
    if pos > 1 && key[pos - 1] == key[pos]
        generate_maps(maps, key, pos + 1, current, remaining)
        return
    end
    for i in 1:10
        if !remaining[i]
            continue
        end
        next_current = copy(current)
        next_current[key[pos]] = mod(i, 10)
        next_remaining = copy(remaining)
        next_remaining[i] = false
        generate_maps(maps, key, pos + 1, next_current, next_remaining)
    end
end

function map_word(word, transf)
    val = 0
    for char in word
        val = val * 10 + transf[char]
    end
    return val
end

function test_anagram(key, squares, vi, vj)
    return in(vi, squares) &&
        in(vj, squares) &&
        vi >= 10^(length(key) - 1) &&
        vj >= 10^(length(key) - 1)
end

start = time()
result = 0

contents = open("words.txt") do file
    read(file, String)
end
contents = strip(contents)
contents = split(contents, ",")
contents = map(x -> replace(x, "\"" => ""), contents)
contents = sort(contents)

groups = Dict()
for text in contents
    sorted = join(sort(collect(text)), "")
    if !haskey(groups, sorted)
        groups[sorted] = []
    end
    push!(groups[sorted], text)
end

max_length = 0
for (key, coll) in groups
    global max_length
    if length(coll) < 2
        continue
    end
    max_length = max(max_length, length(key))
end
squares = Set([i^2 for i in 1:isqrt(10^max_length)])

for (key, coll) in groups
    if length(coll) < 2
        continue
    end
    maps = []
    generate_maps(maps, key, 1, Dict(), [true for _ in 1:10])
    for i in 1:(length(coll) - 1)
        for j in 2:length(coll)
            for transf in maps
                global result
                vi = map_word(coll[i], transf)
                vj = map_word(coll[j], transf)
                if test_anagram(key, squares, vi, vj)
                    result = max(result, vi, vj)
                end
            end
        end
    end
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
