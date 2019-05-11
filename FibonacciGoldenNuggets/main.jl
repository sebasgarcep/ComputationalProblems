#=
Approach:
First assume x >= 0. Notice that:

AF(x) = x * F1 + x^2 * F2 + x^3 * F3 + ...
x * AF(x) = x^2 * F1 + x^2 * F2 + x^3 * F3 + ...

Therefore:

AF(x) + x * AF(x) = x * F1 + x^2 * (F1 + F2) + x^3 * (F2 + F3) + ...
AF(x) + x * AF(x) = x * F1 + x^2 * F3 + x^3 * F4 + ...
AF(x) + x * AF(x) = x * F1 + x^2 * F3 + x^3 * F4 + ...
AF(x) + x * AF(x) = x * F1 - F1 - x * F2 + F1 + x * F2 + x^2 * F3 + x^3 * F4 + ...
AF(x) + x * AF(x) = x * F1 - F1 - x * F2 + (x * F1 + x^2 * F2 + x^3 * F3 + x^4 * F4 + ...) / x
AF(x) + x * AF(x) = x * F1 - F1 - x * F2 + AF(x) / x
x * AF(x) + x^2 * AF(x) = x^2 * F1 - x * F1 - x^2 * F2 + AF(x)
(x^2 + x - 1) * AF(x) = x^2 * F1 - x * F1 - x^2 * F2
AF(x) = (x^2 * F1 - x * F1 - x^2 * F2) / (x^2 + x - 1)
AF(x) = - x / (x^2 + x - 1)

Notice that therefore AF(x) has singularities at the roots of x^2 + x - 1, which
are +- sqrt(5)/2 - 1/2. Notice that the limit as x approaches sqrt(5)/2 - 1/2
from the left side goes to positive infinity as in that vecinity x^2 + x - 1 < 0.
Therefore, because the function at x = 0 takes the value of 0, and because the
function is continuous, it must take the value of all positive integers at some
point in the range (0, sqrt(5)/2 - 1/2). Let y = AF(x). Then:

y = - x / (x^2 + x - 1)
y * (x^2 + x - 1) = - x
y * x^2 + y * x - y = - x
y * x^2 + (y + 1) * x - y = 0

And because x >= 0.

x = (- (y + 1) + sqrt((y + 1)^2 + 4 * y^2)) / (2 * y)

Therefore x is rational whenever sqrt((y + 1)^2 - 4 * y^2) is rational. Notice;

sqrt((y + 1)^2 + 4 * y^2)
sqrt(y^2 + 2 * y + 1 + 4 * y^2)
sqrt(5 * y^2 + 2 * y + 1)

Because y is an integer, then 5 * y^2 + 2 * y + 1 has a square root when there is
an integer z such that 5 * y^2 + 2 * y + 1 = z^2. Therefore:

5 * y^2 + 2 * y + 1 = z^2
25 * y^2 + 10 * y + 5 = 5 * z^2
25 * y^2 + 10 * y + 1 - 1 + 5 = 5 * z^2
(5 * y + 1)^2 + 4 = 5 * z^2

Let p = 5 * y + 1, q = z. Then:

p^2 + 4 = 5 * q^2
p^2 - 5 * q^2 = -4

Notice that p^2 - 5 * q^2 = p^2 - q^2 = 0 mod 4, and because squares are either
0 or 1 mod 4, then p^2 = q^2 = 0 mod 4 or p^2 = q^2 = 1 mod 4, and therefore p
and q have the same parity.

(https://math.stackexchange.com/questions/2307710/solving-pells-equation-x2-5y2-pm4-using-elementary-methods)
First let's try to solve p^2 - 5 * q^2 = +- 4. Clearly, if we find all solutions
to the previous problem, the solution to ours falls from it. Define:

p' = (5 * q - p) / 2
q' = (p - q) / 2

Then p' and q' are integers, and:

p'^2 - 5 * q'^2 = (5 * q - p)^2 / 4 - 5 * (p - q)^2 / 4
                = (25 * q^2 - 10 * p * q + p^2 - 5 * p^2 + 10 * p * q - 5 * q^2) / 4
                = (25 * q^2 - 10 * p * q + p^2 - 5 * p^2 + 10 * p * q - 5 * q^2) / 4
                = (25 * q^2 + p^2 - 5 * p^2 - 5 * q^2) / 4
                = (20 * q^2 - 4 * p^2) / 4
                = 5 * q^2 - p^2
                = -+ 4

Therefore if (p, q) is a solution, then (p', q') is too. Assume p, q > 0. Let's
prove that p', q' >= 0. If q' < 0 then p < q and p^2 - 5 * q^2 < - 4 * p^2 <= -4,
which is false. So q' >= 0. If p' < 0, then 5 * q < p, and 25 * q^2 < p^2 or
p^2 - 5 * q^2 > 20 * q^2 > 4, which is false. Therefore p' >= 0.

Now let's prove that whenever q >= 2, then q' < q. Notice that otherwise:

q' >= q
(p - q) / 2 >= q
p - q >= 2 * q
p >= 3 * q
p^2 >= 9 * q^2
p^2 - 9 * q^2 >= 0
+-4 = p^2 - 5 * q^2 >= 4 * q^2
+-4 >= 4 * q^2

which is only possible when q = 0 or q = 1. Therefore any solution can be reduced
in the second coordinate by using this transformation that takes the solution (p, q)
to (p', q') until q' = 0 or q' = 1. But if q = 0 then p = 2, and if q = 1 then
p = 1 or p = 3 (depending on whether we chose +4 or -4 on the right side of the
original equation). Because we are considering only the solutions of p^2 - 5 * q^2 = -4,
the p = 1. But notice that if (p, q) = (1, 1) then:

p' = (5 * 1 - 1) / 2 = 2
q' = (1 - 1) / 2 = 0

Therefore all solutions to the equation arise by reversing the transformation we
previously defined (it is clearly inverible) and by starting from (p, q) = (2, 0).
Specifically, the inverted transformation is:

p' = (p + 5 * q) / 2
q' = (p + q) / 2

=#

using Printf

start = time()
result = 0

count = 0
p = 2
q = 0
while true
    global count, result, p, q
    if mod(p - 1, 5) == 0 && p - 1 != 0
        result = fld(p - 1, 5)
        count += 1
        if count >= 15
            break
        end
    end
    pt = p
    qt = q
    p = fld(pt + 5 * qt, 2)
    q = fld(pt + qt, 2)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
