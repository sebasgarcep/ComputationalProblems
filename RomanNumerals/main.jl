#=
Approach:
The problem clearly states that all configurations are valid and that no numeral
appears more than 5 times in a row. This means that to simplify the current expressions
we must make use of subtractive combinations. Notice that the only possible subtractive
combinations that actually simplify the expression are:

1. IV = IIII
2. IX = VIIII

3. XL = XXXX
4. XC = LXXXX

5. CD = CCCC
6. CM = DCCCC

Notice that we must first replace the even indexed matches, as the odd indexed
matches are substrings of them.

=#

using Printf

function find_minimal(numeral)
    value = numeral

    value = replace(
        value,
        "VIIII" => "IX"
    )

    value = replace(
        value,
        "IIII" => "IV"
    )

    value = replace(
        value,
        "LXXXX" => "XC"
    )

    value = replace(
        value,
        "XXXX" => "XL"
    )

    value = replace(
        value,
        "DCCCC" => "CM"
    )

    value = replace(
        value,
        "CCCC" => "CD"
    )

    return value
end

start = time()
result = 0

contents = open("roman.txt") do file
    read(file, String)
end

contents = strip(contents)
contents = split(contents, '\n')

result = sum(length.(contents)) - sum(length.(find_minimal.(contents)))

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
