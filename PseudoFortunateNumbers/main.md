# Pseudo-Fortunate Numbers

# Definition: Admissible Number

An admissible number is one whose distinct prime factors are the consecutive primes starting at $2$ and ending at its largest prime factor. For example, $4 = 2^2$, $30 = 2 * 3 * 5$ are admissible numbers but $10 = 2 * 5$ isn't, as $2$ and $5$ aren't consecutive, and $15 = 3 * 5$ isn't as the prime factors do not start at $2$.

# Approach

1. Use a prime sieve to determine which numbers are prime.
2. Use the primality flags from the prime sieve to calculate Pseudo-Fortunate Numbers for every number. To do this, start at the last slot in the prime sieve flag array and work backwards. Whenever you find a prime number two slots to your right, set $m$ to $2$. As you go backwards increment $m$ by $1$ for each step. At each step set the Pseudo-Fortunate number corresponding to that slot to the value of $m$.
3. Because admissible numbers are of the form $2^{r_1} 3^{r_2} 5^{r_3} ...$ then we can generate all these numbers using a recursive search. To bound the recursion, note that after a finite number of steps the product of the first $k + 1$ consecutive primes must surpass the value of $n$. Therefore all admissible numbers will use at most the first $k$ primes.
