# Digital root sums of factorisations

A composite number can be factored many different ways.  
For instance, not including multiplication by one, 24 can be factored in 7 distinct ways:
<div class="margin_left">
24 = 2x2x2x3<br />
24 = 2x3x4<br />
24 = 2x2x6<br />
24 = 4x6<br />
24 = 3x8<br />
24 = 2x12<br />
24 = 24
</div>
Recall that the digital root of a number, in base 10, is found by adding together the digits of that number, 
and repeating that process until a number is arrived at that is less than 10.  
Thus the digital root of 467 is 8.
We shall call a Digital Root Sum (DRS) the sum of the digital roots of the individual factors of our number.<br />
 The chart below demonstrates all of the DRS values for 24.
<table class="grid center"><tr><th>Factorisation</th><th>Digital Root Sum</th></tr><tr><td>2x2x2x3</td><td>9</td></tr><tr><td>2x3x4</td><td>9</td></tr><tr><td>2x2x6</td><td>10</td></tr><tr><td>4x6</td><td>10</td></tr><tr><td>3x8</td><td>11</td></tr><tr><td>2x12</td><td>5</td></tr><tr><td>24</td><td>6</td></tr></table>The maximum Digital Root Sum  of 24 is 11.<br />
The function mdrs(<var>n</var>) gives the maximum Digital Root Sum of <var>n</var>. So  mdrs(24)=11.<br />
Find <span style="font-size:larger;"><span style="font-size:larger;">∑</span></span> mdrs(<var>n</var>) for 1 &lt; <var>n</var> &lt; 1,000,000.

## Solution

First let's memoize all values of the DRS function for $1 \le k \le n$ (which can be calculated recursively as per the definition). Furthermore, note that

$$
\text{mdrs}(k) = \max(\text{DRS}(k), \max_{d \mid k} \text{DRS}(d) + \text{mdrs}(k/d))
$$

Thus, $\text{mdrs}(k)$ can be calculated recursively as well.