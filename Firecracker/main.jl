#=
Approach:
Notice that parabolic movement always occurs along a plane, so we can find the 2D shape of the region
then obtain the volume using a solid of revolution approach. Notice that the trajectory of any fragment
is determined solely by its angle u with respect to the horizon. Particularly, any position (x, y) of the
fragment at time t must satisfy:

x = cosu * v * t
y = -1/2 * g * t^2 + sinu * v * t + h

where v is the initial speed, h the initial height and g is gravity. Therefore, by substitution of
t = x / (cosu * v) we get:

y = -1/2 * g * x^2 / (cosu^2 * v^2) + sinu * x / cosu + h
0 = -1/2 * g * x^2 / (cosu^2 * v^2) + sinu * x / cosu + h - y
0 = -1/2 * g * x^2 / v^2 * secu^2 + x * tanu + h - y
0 = -1/2 * g * x^2 / v^2 * (1 + tanu^2) + x * tanu + h - y

Let A = -1/2 * g * x^2 / v^2, B = x, C = h - y:

0 = A * (1 + tanu^2) + B * tanu + C
0 = A * tanu^2 + B * tanu + A + C
tanu = (-B +- sqrt(B^2 - 4 * A * (A + C))) / (2 * A)

Notice that tanu can take any real value, therefore this equation cannot be solved only when
B^2 - 4 * A * (A + C) < 0. Thus the equation B^2 - 4 * A * (A + C) = 0 allows us to find the curve that
bounds what possible values (x, y) can take. Thus:

B^2 - 4 * A * (A + C) = 0
B^2 - 4 * A^2 - 4 * A * C = 0
x^2 - 4 * (-1/2 * g * x^2 / v^2)^2 - 4 * (-1/2 * g * x^2 / v^2) * (h - y) = 0
x^2 - (g * x^2 / v^2)^2 + 2 * (g * x^2 / v^2) * (h - y) = 0
x^2 / (g * x^2 / v^2) - (g * x^2 / v^2) + 2 * (h - y) = 0
v^2 / g - (g * x^2 / v^2) + 2 * (h - y) = 0
v^2 / (2 * g) - g / (2 * v^2) * x^2 + h = y
y = h + v^2 / (2 * g) - g / (2 * v^2) * x^2

Notice that the volume R is given by the formula:

R = pi * int(y = 0, y = ymax) x(y)^2 dy

where ymax = h + v^2 / (2 * g) and:

x(y)^2 = 2 * v^2 (h + v^2 / (2 * g) - y) / g

Therefore:

R = pi * int(y = 0, y = ymax) 2 * v^2 (h + v^2 / (2 * g) - y) / g dy
R = 2 * v^2 * pi / g * int(y = 0, y = ymax) h + v^2 / (2 * g) - y dy
R = 2 * v^2 * pi / g * ((h + v^2 / (2 * g))^2 - int(y = 0, y = ymax) y dy)
R = 2 * v^2 * pi / g * ((h + v^2 / (2 * g))^2 - 1/2 * (h + v^2 / (2 * g))^2)
R = 2 * v^2 * pi / g * (1/2 * (h + v^2 / (2 * g))^2)
R = v^2 * pi / g * (h + v^2 / (2 * g))^2

=#

using Printf

function main()
    start = time()
    result = 0

    v = 20.0
    h = 100.0
    g = 9.81

    result = v^2 * pi / g * (h + v^2 / (2 * g))^2

    @printf("%.4f\n", result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
