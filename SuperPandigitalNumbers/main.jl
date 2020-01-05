#=
Approach:
We assume that all numbers will be permutations of ba9876543210. If this is not satisfied by the end of
the algorithm (count < 10), then the algorithm fails. Start with the smallest base-12 pandigital number
(1023456789ab) and determine whether it is a 12-super-pandigital number. Then generate the following
permutation (in the lexicographical order). Repeat until you've found the 10 required numbers, or until
the algorithm has exhausted all permutations.

Proof of Next Permutation Inplace Algorithm:
Suppose we have a string sn sn-1 ... s1 and we need to find the next lexicographical string sn' sn-1' ... s1'.
Suppose the suffix si ... s1 is increasing right-to-left, with either i = n, or si+1 < si. If i = n, then
clearly this is the last lexicographical permutation. Now assume that:

si >= si-1 >= ... >= sj > si+1 >= sj-1 >= ... >= s1

Now map the following string:

si+1 si si-1 ... sj sj-1 ... s1 (1)

to:

sj s1 ... sj-1 si+1 ... si-1 (2)

Then the final string sn' sn-1' ... s1' is the prefix sn sn-1 ... si+2 appended to (2). Notice that si+1 < sj,
therefore sn' sn-1' ... s1' is clearly larger than sn sn-1 ... s1. Notice that the algorithm leaves most of the
prefix unchanged. It only modifies the pivot si+1 and replaces it with the smallest value of the suffix that
will cause the resulting string to be larger than the original one. The choice of the pivot is also made so that
the suffix after the pivot is increasing right-to-left and therefore cannot be permuted without resulting in a
smaller string. Finally, the insertion position for the pivot is chosen so that when the suffix is reversed, the
lowest possible suffix results, as the suffix will be in lexicographical order left-to-right. Therefore, the
resulting string must the be the next one in the lexicographical order.

=#

using Printf

# https://www.nayuki.io/page/next-lexicographical-permutation-algorithm
function next_permutation_inplace(array)
    # Find longest non-increasing suffix
    i = length(array)
    while i > 1 && array[i - 1] >= array[i]
        i -= 1
    end
    # Now i is the head index of the suffix

    # Are we at the last permutation already?
    if i <= 1
        return false
    end

    # Let array[i - 1] be the pivot
    # Find rightmost element that exceeds the pivot
    j = length(array)
    while array[j] <= array[i - 1]
        j -= 1
    end
    # Now the value array[j] will become the new pivot
    # Assertion: j >= i

    # Swap the pivot with j
    array[i - 1], array[j] = array[j], array[i - 1]

    # Reverse the suffix
    j = length(array)
    while i < j
        array[i], array[j] = array[j], array[i]
        i += 1
        j -= 1
    end

    # Successfully computed the next permutation
    return true
end

function super_pandigital(n, b)
    if b <= 1
        return true
    end
    test = 2^b - 1
    remainder = n
    flags = 0
    while remainder > 0
        d = mod(remainder, b)
        flags |= 1 << d
        if flags == test
            return super_pandigital(n, b - 1)
        end
        remainder = fld(remainder - d, b)
    end
    return false
end

function array_to_num(a, b)
    r = 0
    l = length(a)
    for k in 1:l
        r += a[l - k + 1] * b^(k - 1)
    end
    return r
end

function main()
    start = time()
    result = 0

    # Problem parameters
    b = 12
    k = 10

    # Generate permutations
    finished = false
    a = [i < 2 ? 1 - i : i for i in 0:(b - 1)]
    count = 0
    while !finished && count < k
        n = array_to_num(a, b)
        if super_pandigital(n, b)
            count += 1
            result += n
        end
        finished = !next_permutation_inplace(a)
    end

    if count < k
        @printf("Couldn't find all required solutions. Found: %d / %d.\n", count, k)
    else
        println(result)
    end

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
