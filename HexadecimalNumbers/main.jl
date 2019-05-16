#=
Approach:
Let n be the length of the string that represents a given number in hexadecimal.
Because the string must contain 0, 1 and A at least once then n >= 3. Let X be
the set of all length n strings that have no 0's, Y be the set of length n strings
that have no 1's and Z be the set of length n strings that have no A's. Let X',
Y', and Z' be the complements of X, Y, and Z, respectively. Then the problem asks
us to find |X' & Y' & Z'|, where & represents set intersection. Notice that if T
is the set of all length n strings, then:

|X' & Y' & Z'| = |T| - |(X' & Y' & Z')'|
               = |T| - |X U Y U Z|

Because |T| = 15 * 16^(n - 1), it suffices to know |X U Y U Z|. Notice that:

|X U Y U Z| = |X| + |Y| + |Z|
            - |X & Y| - |X & Z| - |Y & Z|
            + |X & Y & Z|

Finally, using:

|X| = 15^n
|Y| = 14 * 15^(n - 1)
|Z| = 14 * 15^(n - 1)
|X & Y| = 14^n
|X & Z| = 14^n
|Y & Z| = 13 * 14^(n - 1)
|X & Y & Z| = 13^n

we can solve the problem.

=#

using Printf

start = time()
result = 0

for n in 3:16
    global result
    t = 15 * 16^(n - 1)
    u = 15^n + 2 * 14 * 15^(n - 1) - 2 * 14^n - 13 * 14^(n - 1) + 13^n
    result += t - u
end

result = uppercase(string(result, base = 16))

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
