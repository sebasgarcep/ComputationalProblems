#=
Approach:
We need to maximize Pm(x1, x2, ... , xm) = prod(i = 1, m) xi^i, subject to
sum(i = 1, m) xi = m. We will use Lagrange multipliers to solve this problem.
By the theory of Lagrange multipliers, we maximize the function by solving the
following system:

D(prod(i = 1, m) xi^i) = l * D(sum(i = 1, m) xi - m)
sum(i = 1, m) xi - m = 0

where D is the gradient, and l is the lambda constant. Notice that for 1 <= j <= m,
Dj(prod(i = 1, m) xi^i) = j / xj * prod(i = 1, m) xi^i, and Dj(sum(i = 1, m) xi - m) = 1.
Therefore:

j / xj * prod(i = 1, m) xi^i = 1, for j = 1, 2, ... , m
prod(i = 1, m) xi^i = xj / j, for j = 1, 2, ... , m

Therefore:

x1 / 1 = x2 / 2 = ... = xm / m
x1 = xj / j, j = 1, 2, ... , m
xj = j * x1

Therefore:

sum(j = 1, m) xj = m
sum(j = 1, m) j * x1 = m
x1 * sum(j = 1, m) j = m
x1 * m * (m + 1) / 2 = m
x1 = 2 / (m + 1)

And therefore:

xj = j * 2 / (m + 1)

And therefore:

Pm = prod(i = 1, m) (i * 2 / (m + 1))^i

Finally we need to prove that the theory of Lagrange multipliers works.

(https://math.dartmouth.edu/archive/m14f04/public_html/math_14_lagrange.pdf)

Lemma 1
Let u, v in R^n with u != 0. Let T denote the set of all vectors x in R^n that
are orthogonal to u. If x is orthogonal to v for all x in T, then v is a scalar
multiple of u.
Proof:
Let u, x1, x2, ... , xn-1 be a basis for R^n. Then x1, x2, ... , xn-1 belong to T.
Therefore v is orthogonal to x1, x2, ... , xn-1 and thus v, x1, x2, ... , xn-1
is a basis for R^n, with v linearly independent from x1, x2, ... , xn-1. Therefore
v must be in the linear space spanned by u, and therefore they are scalar multiples
of each other.

Now let's state state the implicit function theorem without proof (it was already
proved in my differential geometry course :) ):

Theorem (Implicit Function)
Let F: R^(n+1) -> R be a C1 function. Denoting points in R^(n+1) by R(x, z), where
x in R^n and z in R, assume that (x0, z0) in R^(n+1) satisfies

F(x0, z0) = 0 and dF/dz(x0, z0) != 0

Then there is a ball U in R^n containing x0, an open interval V in R containing z0
and a unique function g: U -> R, so that F(x, z) = 0 with x in U and z in V if and
only if z = g(x). Moreover, the function g is C1 with partial derivatives given
by

dg/dxi = - (dF/dxi) / (dF/dz)

for i = 1, 2, ... , n.

Lemma 2
Let U in R^n be open and let g: U -> R be a C1 function. Let x0 in U, c = g(x0)
and let S be the level set of g with value C. Assume that D(g)(x0) != 0. Then given
any vector v with D(g)(x0) . v = 0, there is a C1 path c: [-a, a] -> R^n so that:

1. c(t) in S for all t in [-a, a]
2. c(0) = x0
3. c'(0) = v

Proof:
Since D(g)(x0) != 0, there is some xi so that dg/dxi(x0) != 0. Without loss of generality
let's assume that dg/dxn(x0) != 0. Let x0 = (y1, y2, ... , yn). By the implicit
function theorem there is a ball U in R^(n-1) containing (y1, y2, ... , yn-1),
an interval V in R containing yn and a C1 function h defined on U so that
g(x1, x2, ... , xn) = c if and only if xn = h(x1, x2, ... , xn-1).

That is, for points on the level set S near x0 we can solve for xn in terms of
x1, x2, ... , xn-1. Hence, at least locally, S is the graph of some function. Let
v = (v1, v2, ... , vn) be orthogonal to D(g)(x0). Define:

c1(t) = (y1 + t * v1, y2 + t * v2, ... , yn-1 + t * vn-1)

and

c(t) = (c1(t), h(c1(t)))

For small t, c1(t) will lie in U and so we are guaranteed that

g(c(t)) = g(c1(t), h(c1(t))) = c

Therefore the path c(t) will lie entirely in the level set S, provided we keep t
small. This proves part 1 of the lemma.

As for part 2 we have

c(0) = (c1(0), h(c1(0)))
     = (y1, y2, ... , yn-1, yn)
     = x0

Finally, for part 3, using the chain rule:

d(h(c1))/dt(0) = D(h)(c1(0)) . c1'(0)
               = D(h)(y1, y2, ... , yn-1) . (v1, v2, ... , vn-1)
               = dh/dx1 * v1 + dh/dx2 * v2 + ... + dh/dxn-1 * vn-1

The implicit function theorem tells us how to compute the partial derivatives of
h. Therefore:

dh/dx1 * v1 + dh/dx2 * v2 + ... + dh/dxn-1 * vn-1
= - 1 / (dg/dxn) * (dg/dx1 * v1 + dg/dx2 * v2 + ... + dg/dxn-1 * vn-1)
= - 1 / (dg/dxn) * (D(g)(y1, y2, ... , yn-1, h(y1, y2, ... , yn-1)) . v - dg/dxn * vn)
= - 1 / (dg/dxn) * (D(g)(y1, y2, ... , yn-1, yn) . v - dg/dxn * vn)
= - 1 / (dg/dxn) * (D(g)(x0) . v - dg/dxn * vn)

But because v is orthogonal to D(g)(x0) then:

dh/dx1 * v1 + dh/dx2 * v2 + ... + dh/dxn-1 * vn-1 = - 1 / (dg/dxn) * (- dg/dxn * vn)
                                                  = vn

Therefore d(h(c1))/dt(0) = vn, and:

c'(0) = (c1'(0), d(h(c1))/dt(0))
      = (v1, v2, ... , vn-1, vn)
      = v

which proves part 3.

Theorem (Lagrange multipliers)
Let U in R^n be an open set and let f: U -> R, g: U -> R be C1 functions. Let
x0 in U, c = g(x0), and let S be the level set of g with value c. Suppose that
D(g)(x0) != 0. If the function has a local extrema at x0, then there is a l in R
so that:

D(g)(x0) = l * g(x0)

Proof:
Let T be the tangent space space to S at x0, which we will define as the set of
all vectors x such that D(g)(x0) . (x - x0) = 0. We will show that for every x in
T we have D(f)(x0) . (x - x0) = 0. Let x in T. Then (x - x0) is orthogonal to D(g)(x0).
Choose a path c(t) with the conditions of Lemma 2, where v = x - x0. Let h(t) = f(c(t)).
By the chain rule dh/dt = D(f)(c(t)) . c'(t). Since c(t) in S has a maximum or minimum
at x0, the function h has a maximum or minimum at t = 0. Therefore:

0 = dh/dt(0)
  = D(f)(c(0)) . c'(0)
  = D(f)(x0) . (x - x0)

Because x was arbitrary, then D(f)(x0) is orthogonal to every x in T. Since D(g)(x0) != 0,
Lemma 1 implies that D(f)(x0) is a scalar multiple of D(g)(x0).

=#

using Printf

start = time()
result = 0

for m in 2:15
    global result
    p = 1
    for j in 1:m
        x = j * 2.0 / (m + 1.0)
        p *= x^j
    end
    result += floor(Int64, p)
end


println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
