# Pandigital Prime Sets

Using all of the digits $1$ through $9$ and concatenating them freely to form decimal integers, different sets can be formed. Interestingly with the set $\{2,5,47,89,631\}$, all of the elements belonging to it are prime.

How many distinct sets containing each of the digits one through nine exactly once contain only prime elements?

## Solution

We can enumerate all pandigital sets by generating all permutations of the $9$ digits and then adding commas in between the digits. We should ignore the sets where the elements are not in increasing order to ensure uniqueness. Finally we test the primality of each element in the set to find the sets we should count.

This approach generates $9! \cdot 2^8 \lt 10^8$ sets, which is small enough that we can brute force the problem.
