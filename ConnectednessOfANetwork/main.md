# Connectedness of a network

<p>Here are the records from a busy telephone system with one million users:</p>
<div class="center">
<table class="grid" style="margin:0 auto;"><tr><th>RecNr</th><th width="60" align="center">Caller</th><th width="60" align="center">Called</th></tr><tr><td align="center">1</td><td align="center">200007</td><td align="center">100053</td></tr><tr><td align="center">2</td><td align="center">600183</td><td align="center">500439</td></tr><tr><td align="center">3</td><td align="center">600863</td><td align="center">701497</td></tr><tr><td align="center">...</td><td align="center">...</td><td align="center">...</td></tr></table></div>
<p>The telephone number of the caller and the called number in record n are Caller(n) = S<sub>2n-1</sub> and Called(n) = S<sub>2n</sub> where S<sub>1,2,3,...</sub> come from the "Lagged Fibonacci Generator":</p>

<p>For 1 ≤ k ≤ 55, S<sub>k</sub> = [100003 - 200003k + 300007k<sup>3</sup>] (modulo 1000000)<br />
For 56 ≤ k, S<sub>k</sub> = [S<sub>k-24</sub> + S<sub>k-55</sub>] (modulo 1000000)</p>

<p>If Caller(n) = Called(n) then the user is assumed to have misdialled and the call fails; otherwise the call is successful.</p>

<p>From the start of the records, we say that any pair of users X and Y are friends if X calls Y or vice-versa. Similarly, X is a friend of a friend of Z if X is a friend of Y and Y is a friend of Z; and so on for longer chains.</p>

<p>The Prime Minister's phone number is 524287. After how many successful calls, not counting misdials, will 99% of the users (including the PM) be a friend, or a friend of a friend etc., of the Prime Minister?</p>

## Solution

We use a disjoint-set forest data structure to keep tabs of the different connected components of the graph as we add calls (edges) to the graph. Once the connected component of the PM is large enough we are done.