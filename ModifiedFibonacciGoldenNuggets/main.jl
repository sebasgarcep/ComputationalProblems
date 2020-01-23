#=
Approach:
Notice that:

AG(x) = sum(k >= 1) x^k * Gk
      = x * G1 + x^2 * G2 + sum(k >= 3) x^k * Gk
      = x * G1 + x^2 * G2 + sum(k >= 3) x^k * (Gk-1 + Gk-2)
      = x * G1 + x^2 * G2 + sum(k >= 3) x^k * Gk-1 + sum(k >= 3) x^k * Gk-2
      = x * G1 + x^2 * G2 + sum(k >= 2) x^(k+1) * Gk + sum(k >= 1) x^(k+2) * Gk
      = x * G1 + x^2 * G2 - x^2 * G1 + sum(k >= 1) x^(k+1) * Gk + sum(k >= 1) x^(k+2) * Gk
      = x * G1 + x^2 * G2 - x^2 * G1 + x * sum(k >= 1) x^k * Gk + x^2 * sum(k >= 1) x^k * Gk
      = x * G1 + x^2 * G2 - x^2 * G1 + x * AG(x) + x^2 * AG(x)

Thus:

0 = (AG(x) + G2 - G1) * x^2 + (AG(x) + G1) * x - AG(x)

And therefore we would like to find, whenever AG(x) takes positive integer values, when does x
take rational values. This is equivalent to finding when the discriminant is an integer. Thus:

(AG(x) + G1)^2 + 4 * (AG(x) + G2 - G1) * AG(x) = y^2

for some integer z. Let n = AG(x). Then:

(n + G1)^2 + 4 * (n + G2 - G1) * n = y^2
n^2 + 2 * G1 * n + G1^2 + 4 * n^2 + 4 * G2 * n - 4 * G1 * n = y^2
5 * n^2 + (2 * G1 + 4 * G2 - 4 * G1) * n + G1^2 = y^2
5 * n^2 + (4 * G2 - 2 * G1) * n + G1^2 = y^2

Using G1 = 1, G2 = 4:

5 * n^2 + 14 n + 1 = y^2
25 * n^2 + 70 n + 5 = 5 * y^2
25 * n^2 + 70 n + 7^2 - 7^2 + 5 = 5 * y^2
(5 * n + 7)^2 - 49 + 5 = 5 * y^2
(5 * n + 7)^2 - 44 = 5 * y^2
(5 * n + 7)^2 - 5 * y^2 = 44

And let x = 5 * n + 7. Then we are left with a Pell-like equation:

x^2 - 5 * y^2 = 44

Brahmagupta proved the identity (easily proven with algebra expanding the terms):

(a^2 + n * b^2) * (c^2 + n * d^2) = (a * c - n * b * d)^2 + n * (a * d + b * c)^2
                                  = (a * c + n * b * d)^2 + n * (a * d - b * c)^2

Suppose u^2 - 5 * v^2 = 1. Therefore:

44 = (u^2 - 5 * v^2) * (x^2 - 5 * y^2)
   = (u * x + 5 * v * y)^2 - 5 * (u * y + v * x)^2

which allows us to generate infinite solutions to the equation given an initial solution (u, v) to
u^2 - 5 * v^2 = 1 and "small" solutions for x^2 - 5 * y^2 = 44. Using (u, v) = (9, 4) we obtain the
increasing recursion:

xn+1 = u * xn + 5 * v * yn
yn+1 = u * yn + v * xn

Or substituting the values:

xn+1 = 9 * xn + 20 * yn
yn+1 = 4 * xn + 9 * yn

This recursion can be reversed into a decresing recursion, using the matrix inverse:

xn = 9 * xn+1 - 20 * yn+1
yn = -4 * xn+1 + 9 * yn+1

Thus we would like to find initial conditions that cannot be reversed any more. That is, solutions
with x, y > 0, but that end up with x <= 0 or y <= 0 after applying the inverse recursion. Suppose
that x <= 0 after applying the recursion. Then:

9 * x - 20 * y < 0
9 * x < 20 * y
81 * x^2 < 400 * y^2
81 * (44 + 5 * y^2) < 400 * y^2
81 * 44 + 405 * y^2 < 400 * y^2

which is impossible. Now suppose y <= 0 after applying the inverse recursion. Then:

-4 * x + 9 * y <= 0
9 * y <= 4 * x
81 * (x^2 - 44) / 5 <= 16 * x^2
81 * (x^2 - 44) <= 5 * 16 * x^2
81 * x^2 - 81 * 44 <= 80 * x^2
x^2 <= 81 * 44
x <= 18 * sqrt(11)

Thus the algorithm reduces to finding the initial seeds using the limits we just derived, then using
those solutions to generate solutions up to a given size. Whenever x = 5 * n + 7, with n >= 1, then
that n is a golden nugget. Finally, we list all the golden nuggets we found in our search, from
smallest to largest and hopefully we have a list of 30 golden nuggets.

Source:
https://math.stackexchange.com/questions/1719280/does-the-pell-like-equation-x2-dy2-k-have-a-simple-recursion-like-x2-dy2/1719500#1719500
https://math.stackexchange.com/questions/2307710/solving-pells-equation-x2-5y2-pm4-using-elementary-methods

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    k = 30

    # Algorithm parameters
    search_limit = 10^14

    sols = Set()
    max_x = convert(Int64, floor(18 * sqrt(11)))
    for x0 in 7:max_x
        if (x0^2 - 44) % 5 == 0
            y0 = isqrt(fld(x0^2 - 44, 5))
            if x0^2 - 5 * y0^2 == 44
                x = x0
                y = y0
                while x < search_limit
                    if x > 7 && x % 5 == 2
                        n = fld(x - 7, 5)
                        push!(sols, n)
                    end
                    x, y = 9 * x + 20 * y, 4 * x + 9 * y
                end
            end
        end
    end
    vals = sort(collect(sols))
    if length(vals) < k
        println("Couldn't find 30 golden nuggets.")
        return
    end
    vals = vals[1:k]

    result = sum(vals)
    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
