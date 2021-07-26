# License Plates

<p>
Oregon licence plates consist of three letters followed by a three digit number (each digit can be from [0..9]).<br />
While driving to work Seth plays the following game:<br />
Whenever the numbers of two licence plates seen on his trip add to 1000 that's a win.
</p>
<p>
E.g. MIC-012 and HAN-988 is a win and RYU-500 and SET-500 too (as long as he sees them in the same trip). 
</p><p>
</p><p>
Find the expected number of plates he needs to see for a win.<br />
Give your answer rounded to 8 decimal places behind the decimal point.
</p>
<p style="font-size:88%;">
<b>Note:</b> We assume that each licence plate seen is equally likely to have any three digit number on it.
</p>

## Solution

The person can be at any of the following states, at any given moment:

$$
S_0(r) = \text{The person has seen $r$ distinct numbers, excluding $500$} \\
S_1(r) = \text{The person has seen $r$ distinct numbers, including $500$} \\
W = \text{the person has won}
$$

Suppose you are at state $S_0(r)$ and see a new plate. Then you have:

- $1/1000$ chance of it being $0$ (staying at $S_0(r)$)
- $1/1000$ chance of it being $500$ (moving to $S_1(r + 1)$)
- $r/1000$ chance of it being repeated (staying at $S_0(r)$)
- $r/1000$ chance of winning (moving to $W$)
- $(998 - 2r)/1000$ chance of seeing a new plate (moving to $S_0(r + 1)$)

If you have seen $500$ then you have:

- $1/1000$ chance of it being $0$ (staying at $S_1(r)$)
- $r/1000$ chance of winning (moving to $W$)
- $(r - 1)/1000$ chance of it being repeated (staying at $S_1(r)$)
- $(1000 - 2r)/1000$ chance of seeing a new plate (moving to $S_1(r + 1)$)

And we can build a transition matrix from each of the possible states to each other. Notice that $r$ goes from $0$ to $499$ for $S_0$ and from $1$ to $500$ for $S_1$. Therefore there are $1001$ possible states. Finally, set up a markov process such that the initial value for the node $S_0(0)$ is $1$, and $0$ for all other states. Then start applying the transition matrix to the state vector, and at each iteration calculate $n$ times the value of state $W$. If we sum up these terms we get an approximation to the expected value, that we can assume converges.