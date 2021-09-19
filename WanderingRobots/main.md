# Wandering Robots

It was quite an ordinary day when a mysterious alien vessel appeared as if from nowhere. After waiting several hours and receiving no response it is decided to send a team to investigate, of which you are included. Upon entering the vessel you are met by a friendly holographic figure, Katharina, who explains the purpose of the vessel, Eulertopia.

She claims that Eulertopia is almost older than time itself. Its mission was to take advantage of a combination of incredible computational power and vast periods of time to discover the answer to life, the universe, and everything. Hence the resident cleaning robot, Leonhard, along with his housekeeping responsibilities, was built with a powerful computational matrix to ponder the meaning of life as he wanders through a massive 1000 by 1000 square grid of rooms. She goes on to explain that the rooms are numbered sequentially from left to right, row by row. So, for example, if Leonhard was wandering around a 5 by 5 grid then the rooms would be numbered in the following way.

<div class="center">
<img src="https://projecteuler.net/project/images/p575_wandering_robot_1_5x5.png" alt="p575_wandering_robot_1_5x5.png" />
</div>

Many millenia ago Leonhard reported to Katharina to have found the answer and he is willing to share it with any life form who proves to be worthy of such knowledge.

Katharina further explains that the designers of Leonhard were given instructions to program him with equal probability of remaining in the same room or travelling to an adjacent room. However, it was not clear to them if this meant (i) an equal probability being split equally between remaining in the room and the number of available routes, or, (ii) an equal probability (50%) of remaining in the same room and then the other 50% was to be split equally between the number of available routes.

<div class="center">
<img src="https://projecteuler.net/project/images/p575_wandering_robot_2_fixed.png" alt="p575_wandering_robot_2_fixed.png" /><br />
<div style="font-style:italic;">(i) Probability of remaining related to number of exits</div>
<br />
<img src="https://projecteuler.net/project/images/p575_wandering_robot_3_dynamic.png" alt="p575_wandering_robot_3_dynamic.png" /><br />
<div style="font-style:italic;">(ii) Fixed 50% probability of remaining</div>
</div>

The records indicate that they decided to flip a coin. Heads would mean that the probability of remaining was dynamically related to the number of exits whereas tails would mean that they program Leonhard with a fixed 50% probability of remaining in a particular room. Unfortunately there is no record of the outcome of the coin, so without further information we would need to assume that there is equal probability of either of the choices being implemented.

Katharina suggests it should not be too challenging to determine that the probability of finding him in a square numbered room in a 5 by 5 grid after unfathomable periods of time would be approximately 0.177976190476 [12 d.p.].

In order to prove yourself worthy of visiting the great oracle you must calculate the probability of finding him in a square numbered room in the 1000 by 1000 lair in which he has been wandering.<br />
(Give your answer rounded to 12 decimal places)

## Solution

We will prove that in both cases, the stationary distribution is given by three distinct values: the probability of the corner cells $P_c$, the probability of the side cells $P_s$ and the probability of the middle cells $P_m$. To prove this we will show that this layout enforces a consistent and non-degenerate system of linear equations, and therefore this layout must be the stationary distribution.

Let $n \geq 3$. Assume that we are dealing with the first case, i.e. an equal probability being split equally between remaining in the room and the number of available routes. Then if the stationary distribution has the shape we propose earlier, it must satisfy all the following equations (given by the transition matrix of this Markov process):

$$
P_c = \frac{1}{3} P_c + \frac{1}{4} P_s + \frac{1}{4} P_s \\
P_s = \frac{1}{4} P_s + \frac{1}{3} P_c + \frac{1}{4} P_s + \frac{1}{5} P_m \\
P_s = \frac{1}{4} P_s + \frac{1}{4} P_s + \frac{1}{4} P_s + \frac{1}{5} P_m \\
P_m = \frac{1}{5} P_m + \frac{1}{4} P_s + \frac{1}{4} P_s + \frac{1}{5} P_m + \frac{1}{5} P_m \\
P_m = \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{4} P_s \\
P_m = \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{5} P_m + \frac{1}{5} P_m \\
4 P_c + 4 (n - 2) P_s + (n - 2)^2 P_m = 1 \\
$$

which can be shown to reduce to the following consistent and non-degenerate system of equations

$$
\frac{2}{3} P_c - \frac{1}{2} P_s = 0 \\
\frac{1}{4} P_s - \frac{1}{5} P_m = 0 \\
4 P_c + 4 (n - 2) P_s + (n - 2)^2 P_m = 1 \\
$$

Once we have the values of $P_c, P_s, P_m$ we can obtain the probability of ending up at a square numbered room for this case. Let this probability be $P_1$.

Now assume that we are dealing with the second case, i.e. an equal probability (50%) of remaining in the same room and then the other 50% was to be split equally between the number of available routes.

By the same logic as before we end up with the following system of equations:

$$
P_c = \frac{1}{2} P_c + \frac{1}{6} P_s + \frac{1}{6} P_s \\
P_s = \frac{1}{2} P_s + \frac{1}{4} P_c + \frac{1}{6} P_s + \frac{1}{8} P_m \\
P_s = \frac{1}{2} P_s + \frac{1}{6} P_s + \frac{1}{6} P_s + \frac{1}{8} P_m \\
P_m = \frac{1}{2} P_m + \frac{1}{6} P_s + \frac{1}{6} P_s + \frac{1}{8} P_m + \frac{1}{8} P_m \\
P_m = \frac{1}{2} P_m + \frac{1}{8} P_m + \frac{1}{8} P_m + \frac{1}{8} P_m + \frac{1}{6} P_s \\
P_m = \frac{1}{2} P_m + \frac{1}{8} P_m + \frac{1}{8} P_m + \frac{1}{8} P_m + \frac{1}{8} P_m \\
4 P_c + 4 (n - 2) P_s + (n - 2)^2 P_m = 1 \\
$$

which can be shown to reduce to the following consistent and non-degenerate system of equations

$$
\frac{1}{2} P_c - \frac{1}{3} P_s = 0 \\
\frac{1}{6} P_s - \frac{1}{8} P_m = 0 \\
4 P_c + 4 (n - 2) P_s + (n - 2)^2 P_m = 1 \\
$$

Once we have the values of $P_c, P_s, P_m$ we can obtain the probability of ending up at a square numbered room for this case. Let this probability be $P_2$.

Then the solution is $P = \frac{1}{2} P_1 + \frac{1}{2} P_2$ where the $\frac{1}{2}$ come from the process of flipping the coin and choosing the strategy accordingly.