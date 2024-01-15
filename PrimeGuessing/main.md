# Prime Guessing

A prime is drawn uniformly from all primes not exceeding $N$. The prime is written in binary notation, and a player tries to guess it bit-by-bit starting at the least significant bit. The player scores one point for each bit they guess correctly. Immediately after each guess, the player is informed whether their guess was correct, and also whether it was the last bit in the number - in which case the game is over.

Let $E(N)$ be the expected number of points assuming that the player always guesses to maximize their score. For example, $E(10)=2$, achievable by always guessing "1". You are also given $E(30)=2.9$.

Find $E(10^8)$. Give your answer rounded to eight digits after the decimal point.

## Solution

Build a binary tree of depth $\lceil \log_2(N + 1) \rceil$ where each node holds a count. Mark the root node as $r$ and each left node as $0$ and each right node as $1$. Then for each prime $p$ start at the roof and iterate over the bits of the $p$. For each bit, if that is a zero bit go left and add one to that node. Otherwise go right and add one to that node. After you've done this for each prime, this tree will tell you the absolute frequency of the next bit and you can use it to make best guesses for the next bit when playing the game.

Use this tree and calculate the result for each prime $p$ not exceeding $N$, then average over the number of primes. This is the result.

Ties when exploring the tree are resolved by a coin toss, which gives an expected value of 0.5 from this guess.
