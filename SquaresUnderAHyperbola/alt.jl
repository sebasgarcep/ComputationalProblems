#=
Approach:
The Priority Queue in main.jl inserts in O(n) time. We will use a standard priority queue to reduce
insertion time.
=#

using DataStructures
using Printf

function diagonal_sq(x0, y0)
    num = (x0 - y0) + sqrt((x0 - y0) ^ 2 + 4)
    x1 = num / 2.0
    y1 = 2.0 / num
    d1 = (y1 - y0)^2 + (x1 - x0)^2
    return (x1, y1, d1)
end

function main()
    start = time()
    result = 0

    max_i = 3
    max_j = 3

    count = 0
    limit = binomial(max_i + max_j, max_i)

    queue = PriorityQueue()

    i, j, x0, y0 = 0.0, 0.0, 1.0, 0.0
    (x1, y1, d1) = diagonal_sq(x0, y0)
    enqueue!(queue, (i, j, x0, y0, x1, y1), -d1)

    while count < limit
        result += 1
        (i, j, x0, y0, x1, y1) = dequeue!(queue)
        if i == max_i && j == max_j
            count += 1
        end
        (x2, y2, d2) = diagonal_sq(x0, y1)
        enqueue!(queue, (i + 1, j, x0, y1, x2, y2), -d2)
        (x2, y2, d2) = diagonal_sq(x1, y0)
        enqueue!(queue, (i, j + 1, x1, y0, x2, y2), -d2)
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
