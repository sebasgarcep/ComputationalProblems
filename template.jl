#=
Approach:
=#

using Printf

function main()
    start = time()
    result = 0

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
