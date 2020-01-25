#=
Approach:

Rotate and translate the coordinate system so that the marsh is completely vertical and A is located
at the origin. Because the shortest path between two points at constant speed is the straight line,
then the problem reduces to finding the entry and exit points of each section of the marsh that minimize
the total time travelled, in straight line segments.

Theorem (Snell's Law)
---------------------

If the speed on mediums 1 and 2 are s1 and s2, respectively, and the angles of incidence of the shortest
path between mediums 1 and 2 are t1 and t2, respectively, then the shortest path satisfies:

s2 / s1 = sin(t2) / sin(t1)

Proof:
------

Let u and w be points located on different mediums separated by a vertical line with x = vx. Suppose
we want to take the shortest path between u and w. By the same logic as before the shortest path will
be two line segments with each one having one endpoint on either u or w, and the other endpoints
meeting at the line x = vx. We would therefore like to find the value for vy of the meeting point
v = (vx, vy) such that the total travel time is minimized.

Assume without loss of generality that ux <= wx, uy <= wy. It is obvious that ux <= vx <= wx. Also
we can show uy <= vy <= wy, as if vy < uy, then vy = uy would be a better solution and if vy > wy
then vy = wy would be a better solution. Let the speeds for the mediums 1 and 2 be s1 and s2,
respectively. Then the total travel time is given by the expression:

1/s1 * sqrt((vx - ux)^2 + (vy - uy)^2) + 1/s2 * sqrt((wx - vx)^2 + (wy - vy)^2)

Both vx - ux, wx - vx > 0, therefore the expression is smooth. Calculating the derivative with respect
to vy and equating it to 0 we can find the optimal point satisfies:

1/s1 * (vy - uy) / sqrt((vx - ux)^2 + (vy - uy)^2) + 1/s2 * (vy - wy) / sqrt((wx - vx)^2 + (wy - vy)^2) = 0
1/s1 * (vy - uy) / sqrt((vx - ux)^2 + (vy - uy)^2) = 1/s2 * (wy - vy) / sqrt((wx - vx)^2 + (wy - vy)^2)

Let the incidence angle of medium 1 be t1 and the incidence angle of medium 2 be t2. Then:

sin(t1) = (vy - uy) / sqrt((vx - ux)^2 + (vy - uy)^2)
sin(t2) = (wy - vy) / sqrt((wx - vx)^2 + (wy - vy)^2)

therefore

1/s1 * sin(t1) = 1/s2 * sin(t2)
s2 / s1 = sin(t2) / sin(t1)

Clearly, if we keep the speeds and angles of incidence constant, then no matter the choice of u, vx,
w, we will always arrive at the same result.

---------------------------------------------------------------------------------------------------

Giving an initial angle of incidence q the repeated application of Snell's law gives the shortest path
from A to a point P(q), where P(q) is the intersection of the final line ray with x = Bx. Notice Also
that as q increases, so does the y component of P(q), using the same reasoning as the one we used to
prove that uy <= vy <= wy in the proof of Snell's law, but applied iteratively. Thus, bisection search
will allow us to find the value of q that gives P(q) = (Bx, By).

=#

using Printf

function snell_path(speeds, boundaries, q_arg)
    q = q_arg
    y = 0.0
    t = 0.0
    for idx in 1:length(speeds)
        x_iter = boundaries[idx + 1] - boundaries[idx]
        y_iter = x_iter * tan(q)
        y += y_iter
        t += sqrt(x_iter^2 + y_iter^2) / speeds[idx]
        if idx < length(speeds)
            q = mod2pi(asin(sin(q) * speeds[idx + 1] / speeds[idx]))
        end
    end
    return (y, t)
end

function main()
    start = time()
    result = 0.0

    # Problem parameters
    epsilon = 1e-12
    y_obj = 100.0 * sqrt(2.0) / 2.0
    speeds = [
        10.0,
        9.0,
        8.0,
        7.0,
        6.0,
        5.0,
        10.0,
    ]
    boundaries = [
        0.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0 + 10.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0 + 20.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0 + 30.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0 + 40.0,
        100.0 * sqrt(2.0) / 4.0 - 25.0 + 50.0,
        100.0 * sqrt(2.0) / 2.0
    ]

    # Algorithm parameters
    q_min = 0.0 * pi
    q_max = 0.4 * pi

    # Solution
    q_lwr = q_min
    q_upr = q_max
    while true
        q_test = (q_lwr + q_upr) / 2.0
        (y_test, _) = snell_path(speeds, boundaries, q_test)
        if abs(y_test - y_obj) < epsilon
            q_lwr = q_test
            q_upr = q_test
            break
        end
        if y_test > y_obj
            q_upr = q_test
        else
            q_lwr = q_test
        end
    end
    q_test = (q_lwr + q_upr) / 2.0
    (y_test, t_test) = snell_path(speeds, boundaries, q_test)
    result = t_test

    @printf("%.10f\n", result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
