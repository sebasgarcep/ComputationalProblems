# Simplex algorithm

Let $R \in \mathbb{R}^{m \times n}$ and $\Delta_k = \{ x \in \mathbb{R}^k : x \ge 0 \text{ and } \bold{1}^T_k x = 1 \}$.

### Lemma 1.1

Given $a \in \Delta_m, b \in \Delta_n$

$$
\min_{b \in \Delta_n} a^T R b = \min_{1 \le j \le n} (R^T a)_j \\
\max_{a \in \Delta_m} a^T R b = \max_{1 \le i \le n} (R b)_i \\
$$

#### Proof

Suppose $g = R^T a$. Then $a^T R b = g^T b = \sum_{j = 1}^n b_j g_j$. Note that $\min_{1 \le i \le n} g_i = 
(\min_{1 \le i \le n} g_i) \cdot \sum_{j = 1}^n b_j = \sum_{j = 1}^n b_j \min_{1 \le i \le n} g_i \le \sum_{j = 1}^n b_j g_j$, and since this is true for any choice of $b$, we have proven the first statement. The second statement follows in an analogous way.

---

For a fixed $a \in \Delta_m$, let $u_R(a) = \min_{b \in \Delta_n} a^T R b$ and for a fixed $b \in \Delta_n$ let $w_R(b) = \max_{a \in \Delta_m} a^T R b$.

### Corollary 1.2 (Weak Minimax)

For fixed $a \in \Delta_m, b \in \Delta_n$, $u(a) \le w(b)$.

#### Proof

$$
u_R(a) = \min_{\beta \in \Delta_n} a^T R \beta \le a^T R b \le \max_{\alpha \in \Delta_m} \alpha^T R b = w_R(b)
$$

---

Let $c$ be a scalar such that $c \gt -\min_{1 \le i \le m, 1 \le j \le n} R_{i,j}$. Then $\tilde{R} := R + c \bold{1}_{m, n} \gt 0$.

### Definition 1.3 (Linear Program)

A *linear program* (LP) asks for the maximum or minimum of a linear function $v^T y$ over all $y \in \mathbb{R}^n$ satisfying finitely many linear constraints, each of the form $p^T y \le q, p^T y \ge q, p^T y = q$. A point satisfying all the constraints is *feasible*, and the best objective values are *optimal*.

### Proposition 1.4

Consider the two following linear programs

$$
\begin{align*}
&(P) \: \max_{y \in \mathbb{R}^n} \bold{1}_n^T y \text{ s.t. } \tilde{R} y \le 1, y \ge 0 \\
&(D) \: \min_{x \in \mathbb{R}^m} \bold{1}_m^T x \text{ s.t. } \tilde{R}^T x \ge 1, x \ge 0 \\
\end{align*}
$$

Let $\max(P), \min(D)$ be their optimal values, respectively. Then

1. $\min_{b \in \Delta_n} w_{\tilde{R}}(b) = 1/\max(P)$. If $y^*$ is optimal for $P$ then $b^* = y^* / (\bold{1}_n^T y^*)$ is the optimal point for the previous equation.
2. $\max_{a \in \Delta_m} u_{\tilde{R}}(a) = 1/\min(D)$. If $x^*$ is optimal for $D$ then $a^* = x^* / (\bold{1}_m^T x^*)$ is the optimal point for the previous equation.

#### Proof

First note that there are solutions to $P$ and $D$ given that $\tilde{R} \gt 0$.

Given a feasible $y$ for $P$, let $t := \bold{1}^T_n y$ and $b := y/t \in \Delta_n$. Then

$$
\tilde{R}y \le 1 \iff t\tilde{R}b \le 1 \iff a^T \tilde{R} b \le 1/t \iff w_{\tilde{R}}(b) \le 1/t \iff t \le 1/w_{\tilde{R}}(b)
$$

where $a \in \Delta_m$, and with the third statement being given by the Cauchy-Schwartz inequality.

For a fixed $b$, $t$ is maximized when $t = 1 / w_{\tilde{R}}(b)$. So $t$ is maximized, i.e. $t = \max(P)$, when $w_{\tilde{R}}(b)$ is minimized. This implies $\max(P) = 1 / \min_{b \in \Delta_n} w_{\tilde{R}}(b) = 1/\max(P)$. An analogous argument can be made to prove the second part of Proposition 1.4.

---

### Definition 2.1 (Standard form of a LP)

Let $G \in \mathbb{R}^{m \times n}, y \in \mathbb{R}^n, v \in \mathbb{R}^n, h \in \mathbb{R}^m$. A LP in standard form is

$$
\max_{y \in \mathbb{R}^n} v^T y \text{ s.t. } Gy \le h, y \ge 0 
$$

### Definition 2.2 (outcomes)

- A *feasible solution* is an $y \in \mathbb{R}^n$ with $Gy \le h$ and $y \ge 0$. The set of them is the feasible region.
- The LP is *infeasible* if the feasible region is empty.
- A feasible $y^*$ is *optimal* if $v^T y^* \ge v^T y$ for every feasible $y$. $v^T y^*$ is the optimal value.
- The LP is *unbounded* if for any $N > 0$ you can find feasible $y$ such that $v^T y \ge N$.

### Definition 2.3 (slack variables)

Let $s \in \mathbb{R}^m, z = (y, s) \in \mathbb{R}^{n+m}, \hat{G} = (G \:\: I_m) \in \mathbb{R}^{m \times (n + m)}$ and $\hat{v} = (v \;\; \bold{0}_m) \in \mathbb{R}^{n+m}$. The standard-form LP becomes the *equality form*

$$
\max_{z \in \mathbb{R}^{n+m}} \hat{v}^T z \text{ s.t. } \hat{G}z = h, z \ge 0
$$

Note that $\text{rank}(\hat{G}) = m$, since the $m$ columns of $I_m$ are linearly independent.

### Lemma 2.4

There is a bijection between the feasible regions of the standard form and the equality form of an LP. An optimal value of the standard form $y^*$ is mapped to an optimal value in the equality form.

#### Proof

Note that both feasible regions are equivalent since $h = \hat{G}z = Gy + s \iff s = h - Gy$ and $z \ge 0 \iff y \ge 0, s \ge 0 \iff y \ge 0, h - Gy \ge 0$.

The objective is also preserved since $\hat{v}^T z = v^T y$.

---

### Remark 2.5

Any LP can be put in standard form:
- A minimizing objective can be flipped by mapping $v \rightarrow -v$
- $p^T y \ge q$ can be flipped by mapping $(p, q) \rightarrow (-p, -q)$
- $p^T y = q$ can be expressed as $p^T y \le q, p^T y \ge q$
- A set of constraints $p_1^T y \le q_1, \dots, p_k^T y \le q_k$ can be concatenated into $G = (p_1 \dots p_k)^T, h = (q_1 \dots q_k)^T$ to produce the first half of the feasibility constraints
- Express $y = \alpha - \beta$ with $\alpha, \beta \ge 0$. This allows us to enforce the $y \ge 0$ part of the standard form. That $y$ doesn't have a unique representation doesn't matter. Consider the following transformations:
    - $v \rightarrow (v \; \; {-v})^T$
    - $y \rightarrow (\alpha \; \; \beta)^T$
    - $G \rightarrow (G \; \; {-G})^T$
    - $h \rightarrow (h \; \; {-h})^T$
    
    Then $v^T y = v^T \alpha - v^T \beta = (v \; \; {-v})^T \cdot (\alpha \; \; \beta)^T$. Thus the optimal value obtained with $\alpha, \beta$ corresponds to an optimal value for $y$.

### Definition 3.1 (Basis)

A *basis* is a set $B \subset \{ 1, 2, \dots, n + m \}$ of size $m$ such that $\hat{G}_B$ is invertible. Its complement $C$, of size $n$ is the set of *nonbasic* variables; the variables in $B$ are *basic*.

### Definition 3.2 (Basis data)

Given a basis $B$, define

$$
\beta = \hat{G}_B^{-1} h, \; \tilde{\alpha} = \hat{G}_B^{-1} \hat{G}_C, \; \tilde{x} = \hat{G}_B^{-T} \hat{v}_B, \; d = \hat{v} - \hat{G}^{T} \tilde{x}
$$

$\tilde{x}$ is the basis's *dual vector*, $d$ are the *reduced costs*. Note $d_B = \hat{v}_B - \hat{G}_B^T \hat{G}_B^{-T} \hat{v}_B = 0$.

### Lemma 3.3 (Rewriting the LP)

- $d_B = 0$
- For every $z \in \mathbb{R}^{n+m}$, $\hat{G}z = h$ if and only if $z_B = \beta - \tilde{\alpha} z_C$
- For every $z \in \mathbb{R}^{n+m}$, if $\hat{G}z = h$ then $\hat{v}^T z = h^T \tilde{x} + d_C^T z_C$

#### Proof

1. $d_B = \hat{v}_B - \hat{G}_B^T \tilde{x} = \hat{v}_B - \hat{G}_B^T \hat{G}_B^{-T} \hat{v}_B = 0$
2. $\hat{G}z = h \iff \hat{G}_B^{-1} \hat{G} z = \hat{G}_B^{-1} h \iff \hat{G}_B^{-1} (\hat{G}_B z_B + \hat{G}_C z_C) = \beta \iff z_B = \beta - \tilde{\alpha} z_C$
3. $\hat{v}^T z = d^T z + \tilde{x}^T \hat{G} z = d_B^T z_B + d_C^T z_C + \tilde{x}^T h = h^T \tilde{x} + d_C^T z_C$

---

### Definition 3.4 (Dictionary)

The *dictionary* of $B$ is the system

$$
z_B = \beta - \tilde{\alpha} z_C \\
\hat{v}^T z = h^T \tilde{x} + d_C^T z_C \\
$$

By Lemma 3.3 it is equivalent to the LP's constraints $\hat{G} z = h$ and its objective.

### Definition 3.5 (Basic solution)

The *basic solution* of $B$ sets every nonbasic variable to zero. Its objective value is $h^T \tilde{x}$. $B$ is a *feasible basis* if $\beta \ge 0$, which makes the basic solution feasible.

### Corollary 3.6

The dictionary, and so the basic solution, is determined by the set $B$ alone. In particular, there are $\binom{n+m}{m}$ choices for the basis.

### Proposition 3.7 (Feasibility of the slack basis)

Take $B$ to be the $m$ slack variables and suppose $h \ge 0$. Then $B$ is a feasible basis.

#### Proof

$\beta = \hat{G}_B^{-1} h = I_m^{-1} h = h \ge 0$

---

We are now going to introduce the main results leading up to the simplex method. The main idea of the simplex method is moving between feasible bases without ever decreasing the objective, and stopping when the reduced costs are non-positive (which we will prove certifies optimality).

Throughout the next section $B$ is a feasible basis.

### Theorem 4.1 (Optimality criterion)

If $d_C \le 0$, the basic solution of $B$ is optimal.

#### Proof

Since $d_C \le 0$ and $z_C \ge 0$ then, by Lemma 3.3, $\hat{v}^T z = h^T \tilde{x} + d_C^T z_C \le h^T \tilde{x}$. For the basic solution $z_C = \bold{0}_n$, thus $\hat{v}^T z = h^T \tilde{x}$, i.e. it is optimal.

Note that the basic solution in this case would be globally optimal since we've optimized $\hat{v}^T z$ over the whole feasible region.

Furthermore, since $z_B$ is an affine function of $z_C$, this fully determines $z$.

---

Suppose $d_C \le 0$ does not hold. Fix $k \in C$ with $d_k > 0$. For each $\theta \ge 0$, define $z(C, k, \theta)$ by $z_B = \beta - \tilde{\alpha} z_C, z_k = \theta, z_{C \setminus \{k\}} = 0$. Note that the objective function becomes $\hat{v}^T z = h^T \tilde{x} + \theta d_k$, which is optimized by increasing $\theta$. The feasibility region is given by the constraint $0 \le z_B = \beta - \tilde{\alpha} z_C \Rightarrow \beta - \theta \tilde{\alpha}_k \ge 0$.

### Lemma 4.2 (Unboundedness test)

If $\tilde{\alpha}_k \le 0$, the LP is unbounded.

#### Proof

Note that, since $\theta \ge 0$, for large enough $\theta$ the constraint $\beta - \theta \tilde{\alpha}_k \ge 0$ is satisfied. Thus the objective function can grow without bounds, making the LP unbounded in the objective.

---

### Definition 4.3 (ratio test)

Let

$$
\ell =  \argmin \{ \frac{\beta_r}{\tilde{\alpha}_{r,k}} : r \in B, \tilde{\alpha}_{r,k} > 0\} \\
\theta^* = \frac{\beta_\ell}{\tilde{\alpha}_{\ell,k}}
$$

Then $z_k$ is called the *entering variable* and $z_l$ the *leaving variable*: The first basic variable to hit zero as $\theta$ grows.

### Lemma 4.4 (Pivot)

Let $k \in C$ be a nonbasic index with $d_k > 0$, such that $\tilde{\alpha}_{r,k} > 0$ for at least one $r \in B$. Then $B' = (B \setminus \{\ell\}) \; \cup \; \{k\}$ is a feasible basis, its basic solution is $z(C, k, \theta^*)$, and its objective value is $h^T \tilde{x} + \theta^* d_k \ge h^T \tilde{x}$.

#### Proof

Note that $\hat{G}_C = \hat{G}_B \tilde{\alpha}$. Thus 

$$
\hat{G}_k
=
\begin{pmatrix*}
\sum_{r \in B} \hat{G}_{1,r} \tilde{\alpha}_{r,k} \\
\vdots \\
\sum_{r \in B} \hat{G}_{m,r} \tilde{\alpha}_{r,k} \\
\end{pmatrix*}
=
\sum_{r \in B}
\begin{pmatrix*}
\hat{G}_{1,r} \\
\vdots \\
\hat{G}_{m,r} \\
\end{pmatrix*}
\tilde{\alpha}_{r,k}
=
\sum_{r \in B}
\hat{G}_r
\tilde{\alpha}_{r,k}
$$

with $\tilde{\alpha}_{\ell,k} > 0$. Consider the equation

$$
\sum_{r \in B \setminus \{ \ell \}} \lambda_r \hat{G}_r + \mu \hat{G}_k = 0
$$

Substituting the previous expression for $\hat{G}_k$ we get

$$
\sum_{r \in B \setminus \{ \ell \}} (\lambda_r + \mu \tilde{\alpha}_{r,k}) \hat{G}_r + \mu \tilde{\alpha}_{\ell,k} \hat{G}_\ell = 0
$$

Since the columns of $\hat{G}_B$ are linearly independent then the coefficients in the above formula must all be zero. Since $\tilde{\alpha}_{\ell,k} > 0 \Rightarrow \mu = 0 \Rightarrow \lambda_r = 0$ since the columns of $\hat{G}_{B \setminus \{\ell\}}$ must also be lineary independent. Thus, the columns of $\hat{G}_{B'}$ are linearly independent, i.e. $B'$ is a basis.

Furthermore, note that $z(C, k, \theta^*)_\ell = \beta_\ell - \tilde{\alpha}_{\ell,k} \theta^* = 0$ and zero as well for all the entries corresponding to elements in $C \setminus \{k\}$. Thus $z(C, k, \theta^*)$ is the basic solution for $B'$.

Furthermore $z(C, k, \theta^*)_B = \beta - \tilde{\alpha} z(C, k, \theta^*)_C$ (By Lemma 3.3, this satisfies the equality constraint). But $z(C, k, \theta^*)_C$ is zero everywhere except in the $k$-th entry, where it equals $\theta^* \ge 0$. Thus

$$
z(C, k, \theta^*)_B = \beta - \tilde{\alpha}_k \theta^*
$$

Given the minimality of $\theta$, this expression has to be non-negative. Thus $z(C, k, \theta^*)_{B'} \ge 0$, which implies $z(C, k, \theta^*)$ is a feasible solution of the linear program (i.e. it satisfies $z \ge 0$ and $z_B = \beta - \tilde{\alpha} z_C \iff \hat{G}z = h$).

Let $C' = (C \setminus \{ k \}) \; \cup \; \{ \ell \}$. Note that $z(C, k, \theta^*)_{C'} = \bold{0}_n$. Thus $\beta' = z(C, k, \theta^*)_{B'} \ge 0$, where $\beta'$ is the value of $\beta$ corresponding to the choice of $B'$. Therefore $B'$ is a feasible basis.

Finally, using the objective value function for basis $B$

$$
\hat{v}^T z(C, k, \theta^*) = h^T \tilde{x} + d_C^T \cdot z(C, k, \theta^*)_C = h^T \tilde{x} + \theta^* d_k
$$

---

### Definition 4.5 (degenerate pivot)

A pivot is *degenerate* if $\theta^* = 0$, which happens when $\beta_\ell = 0$. The basis changes but the point and the objective do not.

### Algorithm 4.6 (simplex)

Start from a feasible basis $B$. Repeat:

1. Compute the dictionary of $B$
2. If $d_C \le 0$, stop: the basic solution is optimal (Theorem 4.1)
3. Choose an entering $k \in C$ with $d_k > 0$
4. If $\tilde{\alpha}_k \le 0$, stop: the LP is unbounded (Lemma 4.2)
5. Choose a leaving $\ell \in B$ by the ratio test
6. Set $B \leftarrow (B \setminus \{ \ell \}) \; \cup \; \{ k \}$, go back to step $1$

### Remark 4.7

If a run of the simplex algorithm never visits the same basis twice, it stops after finitely many pivots, given there are finitely many bases.

### Theorem 4.8 (Bland's rule)

Index the variables $1, \dots, n+m$. Enter the smallest index $k$ with $d_k > 0$, and break ties in the ratio test by the smallest index $\ell$. Then no run of simplex visits the same basis twice.

#### Proof

Suppose a run visits some basis twice; the pivots between the two visits form a *cycle*. The objective cannot decrease (guaranteed by the simplex algorithm), and if it increases then when it goes back to the original basis it must decrease, which is a contradiction. Therefore the objective stays constant throughout the cycle and every pivot is degenerate, so the basic solution is a fixed point $\bar{z}$ throughout. Call a variable *fickle* if it enters (and so leaves) somewhere in the cycles. A fickle variable is nonbasic at some point, so $\bar{z}$ has it equal to $0$. Let $q$ be the largest fickle index.

Let $D$ be a dictionary in the cycle where $q$ leaves and some fickle $p \not= q$ enters (with basis $B$), and let $D^*$ be one where $q$ enters, with basis $B^*$ and reduced costs $d*$. Bland's entering rule in $D$ gives $d_q^* > 0$ and $d_r^* \le 0$ for all $r < q$.

Walk along D's edge: $z_p = \theta$, other $D$-nonbasic variables 0, $z_r = \beta_r - \theta \tilde{\alpha}_{r,p}$ for $r \in B$. Every point in this line satisfies $\hat{G} z = h$. The objective with dictionary $D$ is $h^T \tilde{x} + d_p \theta$ and with dictionary $D^*$ is $h^T \tilde{x}^* + \sum_{t \in C^*} d_t^* z_t = h^T \tilde{x}^* + d^* \cdot z$ since $d_{B^*} = 0$. Setting $z_p = \theta$, other $D$-nonbasic variables 0, $z_r = \beta_r - \theta \tilde{\alpha}_{r,p}$ for $r \in B$ we get:

$$
\begin{align*}
h^T \tilde{x}^* + d^* \cdot z
&= h^T \tilde{x}^* + d_p^* z_p + \sum_{r \in B} d_r^* z_r + \sum_{t \in C \setminus \{ p \}} d_t^* z_t \\
&= h^T \tilde{x}^* + d_p^* \theta + \sum_{r \in B} d_r^* (\beta_r - \theta \tilde{\alpha}_{r,p}) \\
\end{align*}
$$

Since both expressions represent the same point for a given $\theta$, by matching coefficients we get

$$
d_p = d_p^* - \sum_{r \in B} d_r^* \tilde{\alpha}_{r,p}
$$

Now $d_p > 0$ (as it is an entering variable) and $d_p^* \le 0$ (since $p < q$ and by assumption $d_r^* \le 0$ for all $r < q$). So $\sum_{r \in B} d_r^* \tilde{\alpha}_{r,p} < 0$, and some $r \in B$ has $d_r^* \tilde{\alpha}_{r,p} < 0$. For this $r$:

1. $d_r^* \not= 0$, so $r$ is non-basic in $D^*$ (if it were basic, the associated reduced cost would be zero) and basic in $D$ (since it belongs to $B$). So $r$ is fickle, and $r \le q$.
2. $q$ leaves in $D$, so $\tilde{\alpha}_{q,p} > 0$ (as required by the ratio test) and $d_q^* > 0$ (since $q$ enters in $D^*$). Thus $d_q^* \tilde{\alpha}_{q,p} > 0$, which implies $r \not= q \Rightarrow r < q$ (by maximality of $q$).
3. Since $r < q$ then $d_r^* \lt 0$. Since $d_r^* \tilde{\alpha}_{r,p} < 0$ then $\tilde{\alpha}_{r,p} > 0$.

In $D$, $\beta_r$ is the value of $r$ in the basic solution $\bar{z}$, and $\bar{z}_r = 0$ because $r$ is fickle. So $\beta_r = 0$, and since $\tilde{\alpha}_{r,p} > 0$, $r$ had ration $\beta_r / \tilde{\alpha}_{r,p} = 0$ in $D$'s ratio test. The same holds for $q$, so $r$ tied with $q$ for the minimum. Bland's tie break would have chosen $r < q$ to leave, not $q$. This is a contradiction, and thus, no basis can repeat under Bland's rule.

### Theorem 4.9 (fundamental theorem, for $h \ge 0$)

A standard form LP with $h \ge 0$ is either unbounded or has an optimal solution. In the second case some basic feasible solution is optimal, and simplex with Bland's rule, started at the slack basis, finds it.

#### Proof

The slack basis is feasible (by proposition 3.7), so it is a valid starting point for simplex. Simplex with Bland's rule can only stop when the solution is globally optimal or the LP is found to be unbounded (and it stop after finitely many steps). Therefore simplex finds the optimal solution if one exists.

---

### Corollary 4.10

The game LP (P) has an optimal solution, and simplex started at $y = \bold{0}_n$ computes it.

#### Proof

The LP is bounded and $h = \bold{1}_n \ge 0$. Thus, by Theorem 4.9 it must have an optimal solution and such solution can be found using the simplex algorithm with Bland's rule.

---

### Definition 5.1 (Dual)

The *dual* of the standard-form LP $\max v^T y \; \text{ s.t. } \; G y \le h, y \ge 0$ (the *primal*) is

$$
\min_{x \in \mathbb{R}^m} h^T x \; \text{ s.t. } \; G^T x \ge v, x \ge 0
$$

The dual has one variable $x_i$ per primal constraint and one constraint per primal variable $y_j$.

### Theorem 5.2 (Weak duality)

If $y$ is primal feasible and $x$ is dual feasible then $v^T y \le h^T x$.

#### Proof

$v^T y \le (G^T x)^T y = x^T (Gy) \le x^T h$

---

### Corollary 5.3

If $v^T y = h^T x$ for some primal feasible $y$ and dual feasible $x$, both are optimal.

#### Theorem 5.4 (Strong duality, read off simplex)

Suppose simplex stops at a feasible basis $B$ with $d_C \le 0$. Then the dual vector $\tilde{x} = \hat{G}_B^{-T} \hat{v}_B$ is dual feasible and $h^T \tilde{x}$ equals the primal optimum.

#### Proof

At termination $d = \hat{v} - \hat{G}^T \tilde{x} \le 0$. Split $d$ into the $y$-block and the slack block and we get:

- $v - G^T \tilde{x} \le 0 \Rightarrow G^T \tilde{x} \ge v$
- $\bold{0}_m - I_m \tilde{x} \le 0 \Rightarrow \tilde{x} \ge 0$

Thus $\tilde{x}$ is dual feasible. Furthermore, the optimal value of this LP is $h^T \tilde{x}$.

### Theorem 5.5 (Complementary slackness)

Assume $h \ge 0$. Let $y$ be primal feasible and $x$ dual feasible. Both are optimal if and only if

$$
x_i (h - Gy)_i = 0 
$$

for all $i$ and

$$
y_j (G^T x - v)_j = 0
$$

for all $j$

#### Proof

Note that $h^T x - v^T y = x^T (h - Gy) + y^T (G^T x - v)$. Applying the "only if" part of the statement we get $h^T x - v^T y = 0$ and by Corollary 5.3, this is optimal.

Now assume that both $y$ and $x$ are optimal. Then the optimal value for $v^T y$ is $h^T \tilde{x}$. Since $h^T x \le h^T \tilde{x} = v^T y$ and $v^T y \le h^T x$, then $v^T y = h^T x$. So $x^T (h - Gy) + y^T (G^T x - v) = 0$. Since $x \ge 0, y \ge 0, Gy \le h, G^T x \ge v$, then each term in the sum is strictly non-negative. Thus each term $x_i (h - Gy)_i$ and $y_j (G^T x - v)_j$ must be zero for all $i$ and $j$.

---

### Theorem 6.1 (Minimax theorem)

For every $m \times n$ matrix $R$,

$$
\max_{a \in \Delta_m} \min_{b \in \Delta_n} a^T R b = \min_{b \in \Delta_n} \max_{a \in \Delta_m} a^T R b
$$

and both sides are attained.

#### Proof

Shift $R$ to the positive matrix $\tilde{R}$. By Corollary 4.10, $P$ has an optimal $y^*$; call its value $\tau^*$ and note that it is positive. By theorem 5.4, $D$ has an optimal $x^*$ with the same value $\tau^*$. By Proposition 1.4, $\min_{b \in \Delta_n} w_{\tilde{R}}(b) = 1/\tau^* = \max_{a \in \Delta_m} u_{\tilde{R}}(a)$, attained at $b^* = y^* / \tau^*$ and $a^* = x^* / \tau^*$. Since $w_{\tilde{R}} = w_R + c$ and $u_{\tilde{R}} = u_R + c$, subtracting $c$ gives $\min_{b \in \Delta_n} w_{R}(b) = \max_{a \in \Delta_m} u_{R}(a) = 1/\tau^* - c$.

Corollary 1.2 already gave max–min $\le$ min–max. The content of the theorem is that LP duality closes the gap.

---

Suppose $R$ is the payoff matrix, $a$ is the probability distribution for the player and $b$ the probability distribution for the opponent.

Then we are trying to find $\max_{a \in \Delta_m} \min_{b \in \Delta_n} a^T R b$ and by Theorem 6.1 we know this equals $\min_{b \in \Delta_n} \max_{a \in \Delta_m} a^T R b$.

Note that $\min_{b \in \Delta_n} \max_{a \in \Delta_m} a^T R b = \min_{b \in \Delta_n} w_R(b) = -c + \min_{b \in \Delta_n} w_{\tilde{R}}(b)$. By theorem 1.4 we have $\min_{b \in \Delta_n} w_{\tilde{R}}(b) = 1/\max(P)$, and by Corollary 4.10 the linear program $P$ can be solved using the simplex algorithm.
