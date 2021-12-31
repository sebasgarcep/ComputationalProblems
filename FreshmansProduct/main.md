# Freshman's Product

If $a,b$ are two nonnegative integers with decimal representations $a=(\dots a_2a_1a_0)$ and $b=(\dots b_2b_1b_0)$ respectively, then the <i>freshman's product</i> of $a$ and $b$, denoted $a\boxtimes b$, is the integer $c$ with decimal representation $c=(\dots c_2c_1c_0)$ such that $c_i$ is the last digit of $a_i\cdot b_i$.<br />
For example, $234 \boxtimes 765 = 480$.

Let $F(R,M)$ be the sum of $x_1 \boxtimes \dots \boxtimes x_R$ for all sequences of integers $(x_1,\dots,x_R)$ with $0\leq x_i \leq M$.<br />
For example, $F(2, 7) = 204$, and $F(23, 76) \equiv 5870548 \pmod{ 1\,000\,000\,009}$.

Find $F(234567,765432)$, give your answer modulo $1\,000\,000\,009$

## Solution

Each of the digit is independent from each other. Thus the sum can be calculated over each digit. For a digit position $k$ calculate how often each number from $0$ to $9$ occurs for all $0 \leq x \leq M$. Assuming the Freshman Product is associative we can calculate it iteratively. Initialize an array with the number of occurrences of each number. Clearly, if $R = 1$ then this is the final number of occurrences of each digit. For each iteration from $2$ to $R$ initialize a zero array to be the number of occurrences for this iteration. Calculate the Freshman Product $c$ for each pair $(a, b)$. Add to the number of occurrences of $c$ for this iteration, the number of occurrences of the previous iteration of $a$ times the number of occurrences of $b$. After all $R - 1$ iterations multiply the number of occurrences of each digit times the digit and add all those together to form $v_k$. The final result is $\sum_k v_k \cdot 10^k \pmod{10^9 + 9}$.