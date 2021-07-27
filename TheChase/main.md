# The Chase

<p><dfn>The Chase</dfn> is a game played with two dice and an even number of players.</p>

<p>The players sit around a table and the game begins with two opposite players having one die each. On each turn, the two players with a die roll it.</p>

<p>If the player rolls 1, then the die passes to the neighbour on the left.<br />
If the player rolls 6, then the die passes to the neighbour on the right.<br />
Otherwise, the player keeps the die for the next turn.</p>

<p>The game ends when one player has both dice after they have been rolled and passed; that player has then lost.</p>

<p>In a game with 100 players, what is the expected number of turns the game lasts?</p>
<p>Give your answer rounded to ten significant digits.</p>

## Solution

Suppose there are $n$ people playing this game, and $n$ is even. The game can be at any of the following states:

$$
d_r = \text{The dice are $r$ distance apart}
$$

where $r$ goes from $0$ to $n/2$.

The possible state transitions for $r = 1$:

- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r-1}$
- $2 \cdot 1/6 \cdot 1/6 + 4/6 \cdot 4/6 + 1/6 \cdot 1/6 = 19/36$ odds of staying at $d_r$
- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r+1}$
- $1/6 \cdot 1/6 = 1/36$ odds of moving to $d_{r+2}$

The possible state transitions for $r = n/2 - 1$:

- $1/6 \cdot 1/6 = 1/36$ odds of moving to $d_{r-2}$
- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r-1}$
- $2 \cdot 1/6 \cdot 1/6 + 4/6 \cdot 4/6 + 1/6 \cdot 1/6 = 19/36$ odds of staying at $d_r$
- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r+1}$

The possible state transitions for $r = n/2$ are

- $2 \cdot 1/6 \cdot 1/6 = 2/36$ odds of moving to $d_{r-2}$
- $4 \cdot 1/6 \cdot 4/6 = 16/36$ odds of moving to $d_{r-1}$
- $2 \cdot 1/6 \cdot 1/6 + 4/6 \cdot 4/6 = 18/36$ odds of staying at $d_r$

The possible state transitions for $1 < r < n/2 - 1$:

- $1/6 \cdot 1/6 = 1/36$ odds of moving to $d_{r-2}$
- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r-1}$
- $2 \cdot 1/6 \cdot 1/6 + 4/6 \cdot 4/6 = 18/36$ odds of staying at $d_r$
- $2 \cdot 1/6 \cdot 4/6 = 8/36$ odds of moving to $d_{r+1}$
- $1/6 \cdot 1/6 = 1/36$ odds of moving to $d_{r+2}$

The game ends when the system reaches state $d_0$. The system starts at state $d_{n/2}$. Therefore set a state vector with all values $0$ except for a $1$ at the position corresponding to $d_{n/2}$. Then build the transition matrix corresponding to all the cases above. Once that's done the solution is found by using the markov process to calculate the probability of each state after $n$ iterations. We multiply the odds of being at a winning state times $n$ and add for all $n$, until the sum converges.