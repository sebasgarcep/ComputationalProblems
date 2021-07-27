# Scoring Probabilities

<p>Barbara is a mathematician and a basketball player. She has found that the probability of scoring a point when shooting from a distance <var>x</var> is exactly (1 - <sup><var>x</var></sup>/<sub><var>q</var></sub>), where <var>q</var> is a real constant greater than 50.</p>

<p>During each practice run, she takes shots from distances <var>x</var> = 1, <var>x</var> = 2, ..., <var>x</var> = 50 and, according to her records, she has precisely a 2 % chance to score a total of exactly 20 points.</p>

<p>Find <var>q</var> and give your answer rounded to 10 decimal places.</p>

## Solution

Clearly, the odds of not scoring from a distance $x$ is $x/q$. Then the following polynomial in $y$ is the generating function for the odds of each scenario (scoring $0, 1, \dots$ times):

$$
\prod_{x = 1}^{50} (\frac{x}{q} + (1 - \frac{x}{q})y)
$$

Then the odds of scoring $20$ times is given by the coefficient of $y^{20}$. We already know that this coefficient is $0.02$, therefore we only need to find a value for $q$ such that the resulting coefficient has this value.

We know that $x / q \leq 1$ for all $x = 1, 2, \dots, 50$. Thus $50 / q \leq 1 \Rightarrow 50 \leq q$. Thus we only need to find an upper bound for the search space. Notice that the larger $q$ is, then the likelier that the player will score, meaning that the odds of getting more than $20$ shots increases, reducing the odds of getting $20$ or less. Thus, for large enough $q$, the coefficient of $y^{20}$ will be smaller than $0.02$. We can find an upper bound that satisfies this condition by iteratively doubling the lower bound of $50$ until we have found such value.

At this point we have a lower bound $q_{\text{min}} = 50$ and an upper bound $q_{\text{max}}$, and we know our value of $q$ is in this range. We also assume that the function that retuns the value of the coefficient for a given $q$ will be decreasing in this interval. A binary search with a tolerance on the output of the function can help us find the desired value of $q$.