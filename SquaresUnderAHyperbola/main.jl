#=
Approach:
Given a lower-left corner (x0, y0) for a square, the diagonal side of that square can be
found by finding the intersection point between the line parallel to y = x that goes
through (x0, y0) and y = 1 / x. The previous line can be expressed as:

y - y0 = x - x0
y = x + (y0 - x0)

Equating both formulas:

1 / x = x + (y0 - x0)
x^2 + (y0 - x0) * x - 1 = 0
x1 = ( (x0 - y0) + sqrt((x0 - y0)^2 + 4) ) / 2
y1 = 2 / ( (x0 - y0) + sqrt((x0 - y0)^2 + 4) )

With the distance being:

d = sqrt((x1 - x0)^2 + (y1 - y0)^2)

Notice that if d1 <= d2 if and only if d1^2 <= d2, thus we can remove the final square root
from our calculations.

To solve this problem we use a priority queue. Every time we find a square, the next squares are
given by the upper-left and the lower-right corners of that square. Thus, if we keep an ordered
lists of all possible next squares, in order from smallest to largest, at each iteration we only
have to remove the rightmost square in the list as it is the next largest square.

Finally, every time we reach position (3, 3) we increment a counter. Once the counter reaches
(3 + 3 choose 3), we can stop looking as that has to be our last square. This follows from the
fact that on each square we have to make a choice between going up or going right, and thus
the number of possible paths one can take to (3, 3) must be (3 + 3 choose 3) = (6 choose 3).

=#

using Printf

function get_insert_position(a, e)
    if length(a) == 0
        return 1
    end
    lower = 1
    upper = length(a) + 1
    while upper - lower > 1
        test = fld(lower + upper, 2)
        if a[test] == e
            lower = test
            upper = test
        elseif a[test] < e
            lower = test
        else
            upper = test
        end
    end
    if lower == upper || a[lower] > e
        return lower
    else
        return upper
    end
end

function priority_queue_insert(queue, priorities, e, v)
    pos = get_insert_position(priorities, v)
    insert!(queue, pos, e)
    insert!(priorities, pos, v)
end

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
    max_j = 2

    count = 0
    limit = binomial(max_i + max_j, max_i)

    queue = []
    priorities = []

    i, j, x0, y0 = 0.0, 0.0, 1.0, 0.0
    (x1, y1, d1) = diagonal_sq(x0, y0)
    priority_queue_insert(queue, priorities, (i, j, x0, y0, x1, y1), d1)

    while count < limit
        result += 1
        (i, j, x0, y0, x1, y1) = pop!(queue)
        if i == max_i && j == max_j
            count += 1
        end
        (x2, y2, d2) = diagonal_sq(x0, y1)
        priority_queue_insert(queue, priorities, (i + 1, j, x0, y1, x2, y2), d2)
        (x2, y2, d2) = diagonal_sq(x1, y0)
        priority_queue_insert(queue, priorities, (i, j + 1, x1, y0, x2, y2), d2)
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
