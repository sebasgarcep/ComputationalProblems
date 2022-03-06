# Prime triplets

<p>Build a triangle from all positive integers in the following way:</p>

<p style="font-family:'courier new', monospace;font-weight:bold;margin-left:50px;"> 1<br />
 <span style="color:#FF0000;">2</span>  <span style="color:#FF0000;">3</span><br />
 4  <span style="color:#FF0000;">5</span>  6<br />
 <span style="color:#FF0000;">7</span>  8  9 10<br /><span style="color:#FF0000;">11</span> 12 <span style="color:#FF0000;">13</span> 14 15<br />
16 <span style="color:#FF0000;">17</span> 18 <span style="color:#FF0000;">19</span> 20 21<br />
22 <span style="color:#FF0000;">23</span> 24 25 26 27 28<br /><span style="color:#FF0000;">29</span> 30 <span style="color:#FF0000;">31</span> 32 33 34 35 36<br /><span style="color:#FF0000;">37</span> 38 39 40 <span style="color:#FF0000;">41</span> 42 <span style="color:#FF0000;">43</span> 44 45<br />
46 <span style="color:#FF0000;">47</span> 48 49 50 51 52 <span style="color:#FF0000;">53</span> 54 55<br />
56 57 58 <span style="color:#FF0000;">59</span> 60 <span style="color:#FF0000;">61</span> 62 63 64 65 66<br />
. . .</p>

<p>Each positive integer has up to eight neighbours in the triangle.</p>

<p>A set of three primes is called a <i>prime triplet</i> if one of the three primes has the other two as neighbours in the triangle.</p>

<p>For example, in the second row, the prime numbers 2 and 3 are elements of some prime triplet.</p>

<p>If row 8 is considered, it contains two primes which are elements of some prime triplet, i.e. 29 and 31.<br />
If row 9 is considered, it contains only one prime which is an element of some prime triplet: 37.</p>

<p>Define S(<var>n</var>) as the sum of the primes in row <var>n</var> which are elements of any prime triplet.<br />
Then S(8)=60 and S(9)=37.</p>

<p>You are given that S(10000)=950007619.</p>

<p>Find  S(5678027) + S(7208785).</p>

## Solution

A number is part of a prime triplet if it satisfies one of the following conditions:

1. It has at least two prime neighbours.
2. It is a neighbour to another prime with at least two prime neighbours.

Thus if we want to know all prime triplets in row $n$ we only need to know the primes in rows $n-2, n-1, n, n+1, n+2$. Because any number is prime if and only if it is not divisible by a number less than or equal to its square roots, we only need to check divisibility by primes up to the square root of the largest element in row $n+2$.

If $T(n)$ is the $n$-th triangular number, then it is easy to see that row $n$ goes from $T(n-1) + 1$ to $T(n)$. Thus we need to check divisibility in the rows $n-2, n-1, n, n+1, n+2$ by primes up to $\sqrt{T(n+2)}$.

We can use a prime sieve to find the primes up to $\sqrt{T(n+2)}$, and then use these primes to sieve the elements of each row, which will tell us the prime numbers in each of the rows. After this we need to find primes in each of the rows that have at least two prime neighbours, and mark any neighbour (or itself) in row $n$ as a member of a prime triplet.

Finally, we add all found prime triplets.