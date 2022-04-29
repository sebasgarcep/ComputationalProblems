# Almost Pi

<p>Let <var>f</var><sub><var>n</var></sub>(<var>k</var>) = <var>e</var><sup><var>k</var>/<var>n</var></sup> - 1, for all non-negative integers <var>k</var>.</p>
<p>Remarkably, <var>f</var><sub>200</sub>(6) + <var>f</var><sub>200</sub>(75) + <var>f</var><sub>200</sub>(89) + <var>f</var><sub>200</sub>(226) = <u>3.1415926</u>44529… ≈ <var>π</var>.</p>
<p>In fact, it is the best approximation of <var>π</var> of the form <var>f</var><sub><var>n</var></sub>(<var>a</var>) + <var>f</var><sub><var>n</var></sub>(<var>b</var>) + <var>f</var><sub><var>n</var></sub>(<var>c</var>) + <var>f</var><sub><var>n</var></sub>(<var>d</var>) for <var>n</var> = 200.</p>
<p>Let <var>g</var>(<var>n</var>) = <var>a</var><sup>2</sup> + <var>b</var><sup>2</sup> + <var>c</var><sup>2</sup> + <var>d</var><sup> 2</sup> for <var>a</var>, <var>b</var>, <var>c</var>, <var>d</var> that minimize the error: | <var>f</var><sub><var>n</var></sub>(<var>a</var>) + <var>f</var><sub><var>n</var></sub>(<var>b</var>) + <var>f</var><sub><var>n</var></sub>(<var>c</var>) + <var>f</var><sub><var>n</var></sub>(<var>d</var>) - <var>π</var>|<br />
(where |<var>x</var>| denotes the absolute value of <var>x</var>).</p>
<p>You are given <var>g</var>(200) = 6<sup>2</sup> + 75<sup>2</sup> + 89<sup>2</sup> + 226<sup>2</sup> = 64658.</p>
<p>Find <var>g</var>(10000).<sup></sup></p>

## Solution

Notice that $f_n(k) \gt 0$. Suppose $k'$ is the smallest number such that $f_n(k') \gt \pi$. Then any approximation using $k \ge k'$ will set the other three inputs to $1$. Therefore the closest approximation that uses $k \ge k'$ is the one that uses $k'$ and we only need to search on inputs to $f_n$ not exceeding $\left\lceil n \log(1 + \pi) \right\rceil$.

Now we apply a meet-in-the-middle approach by saving all combinations $f_n(a) + f_n(b)$ in a sorted list and for all combinations $f_n(c) + f_n(d)$ we look for the element in the previous list that helps us approximate $\pi$ the most. The search can be done efficiently using binary search as the list is sorted.