# Sum of a Square and a Cube

Many numbers can be expressed as the sum of a square and a cube. Some of them in more than one way.

Consider the palindromic numbers that can be expressed as the sum of a square and a cube, both greater than $1$, in <b>exactly</b> $4$ different ways.<br>
For example, $5229225$ is a palindromic number and it can be expressed in exactly $4$ different ways:
$2285^2 + 20^3$<br>
$2223^2 + 66^3$<br>
$1810^2 + 125^3$<br>
$1197^2 + 156^3$
 
Find the sum of the five smallest such palindromic numbers.

## Solution

Generate all values $a^2 + b^3 \le N$ and increment a counter for the found number. Then iterate over them and hope there are enough numbers that satisfy the conditions.
