# Cardano Triplets

A triplet of positive integers (<var>a</var>,<var>b</var>,<var>c</var>) is called a Cardano Triplet if it satisfies the condition:
$$\sqrt[3]{a + b \sqrt{c}} + \sqrt[3]{a - b \sqrt{c}} = 1$$


For example, (2,1,5) is a Cardano Triplet.


There exist 149 Cardano Triplets for which <var>a</var>+<var>b</var>+<var>c</var> ≤ 1000.


Find how many Cardano Triplets exist such that <var>a</var>+<var>b</var>+<var>c</var> ≤ 110,000,000.


## Solution

We can rewrite the main equation as $8a^3+15a^2+6a-1 = 27b^2 c$. The LHS can be factored as $(a+1)^2 (8a-1) = 27b^2 c$. One can easily show that $a \equiv 2 \pmod 3$, in which case the LHS is a multiple of $27$. Thus, for any valid $a$ we want to find all different ways of expressing $(a+1)^2 (8a-1)$ as $27b^2 c$. For this we need to find all square divisors of $\frac{(a+1)^2 (8a-1)}{27}$.

Suppose $d \mid a+1, 8a-1 \Rightarrow d \mid 8a+8-8a+1=9$ and thus $\gcd(a+1, 8a-1) = 3^v$ for some non-negative integer $v$. Thus we can express $(a+1)^2 (8a-1)$ as a product of three coprime factors: $(a+1)^2 (8a-1) = 3^v \cdot \frac{(a+1)^2}{3^{2v_1}} \cdot \frac{8a-1}{3^{v_2}}$ where $2v_1 + v_2 = v$. Thus any square divisor of $(a+1)^2 (8a-1)$ is the product of three coprime factors:

- any square divisor of $3^{v-3}$, i.e. any number of the form $3^{2 v_3}$ where $2v_3 \le v-3$.
- any divisor of $\frac{(a+1)}{3^{v_1}}$
- any square divisor of $\frac{8a-1}{3^{v_2}}$

Now we need to find the search space of $a$. Fix the value of $a$. We want to find a lower bound for $a + b + c$ given $(a+1)^2 (8a-1) = 27b^2 c$. Let $M = \frac{(a+1)^2 (8a-1)}{27}$. Then $b^2 c = M$. The objective function can be rewritten as $f(b) := a + b + \frac{M}{b^2}$. Notice that $f'(b) = 1-\frac{2M}{b^3}$. Solving $f'(b) = 0$ we get $b = \sqrt[3]{2M}$. Thus $c = \sqrt[3]{\frac{M}{4}}$. Putting everything together we get $a + \sqrt[3]{2M} + \sqrt[3]{M/4} \le a+b+c \le N$. But one can easily prove that for $a \gt 1$ then $8a^3 \le (a+1)^2 (8a-1) = 27M \Rightarrow \frac{2a}{3} \le \sqrt[3]{M}$. Thus $a + \frac{2 \sqrt[3]{2} a}{3} + \frac{2a}{3 \sqrt[3]{4}} \le N \Rightarrow 2a \le N$.
