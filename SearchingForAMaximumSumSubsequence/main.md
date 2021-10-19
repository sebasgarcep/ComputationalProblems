# Searching for a maximum-sum subsequence

<p>Looking at the table below, it is easy to verify that the maximum possible sum of adjacent numbers in any direction (horizontal, vertical, diagonal or anti-diagonal) <span style="white-space:nowrap;">is 16 (= 8 + 7 + 1).</span></p>

<div class="center">
<table border="1" cellpadding="6" cellspacing="0" style="margin:auto;"><tbody align="right"><tr><td>−2</td><td>5</td><td>3</td><td>2</td></tr><tr><td>9</td><td>−6</td><td>5</td><td>1</td></tr><tr><td>3</td><td>2</td><td>7</td><td>3</td></tr><tr><td>−1</td><td>8</td><td>−4</td><td>  8</td></tr></tbody></table></div>

<p>Now, let us repeat the search, but on a much larger scale:</p>

<p>First, generate four million pseudo-random numbers using a specific form of what is known as a "Lagged Fibonacci Generator":</p>

<p>For 1 ≤ <i>k</i> ≤ 55, <i>s</i><sub><i>k</i></sub> = [100003 − 200003<i>k</i> + 300007<i>k</i><sup>3</sup>] (modulo 1000000) − 500000.<br />
For 56 ≤ <i>k</i> ≤ 4000000, <i>s</i><sub><i>k</i></sub> = [<i>s</i><sub><i>k−24</i></sub> + <i>s</i><sub><i>k−55</i></sub> + 1000000] (modulo 1000000) − 500000.</p>

<p>Thus, <i>s</i><sub>10</sub> = −393027 and <i>s</i><sub>100</sub> = 86613.</p>

<p>The terms of <i>s</i> are then arranged in a 2000×2000 table, using the first 2000 numbers to fill the first row (sequentially), the next 2000 numbers to fill the second row, and so on.</p>

<p>Finally, find the greatest sum of (any number of) adjacent entries in any direction (horizontal, vertical, diagonal or anti-diagonal).</p>

## Solution

Apply Kadane's Algorithm over each row, column, diagonal and anti-diagonal. This runs in $O(N^2)$ time. Then return the maximum value obtained over all runs.

Kadane's algorithm is the following:

```python
def max_subarray(numbers):
    """Find the largest sum of any contiguous subarray."""
    best_sum = 0  # or: float('-inf')
    current_sum = 0
    for x in numbers:
        current_sum = max(0, current_sum + x)
        best_sum = max(best_sum, current_sum)
    return best_sum
```

And it is easy to prove that such algorithm returns the contiguous subarray with maximum sum.