#=
Approach:
Let s be fixed. Let n be such that r | n + (r - 1), where 1 <= r <= s.
Let c = lcm(1, 2, ... , s). Notice that the same property holds for n + t * c,
where t is any integer such that n + t * c > 0. In particular this property
holds when n = 1 and t = 0. To see that all n with this property are congruent
to n = 1 mod c, assume that there is an n' such that n' != 1 mod c. Then
r | (n' - n). Then, by definition, c = lcm(1, 2, ... s) | (n' - n). Thus
n' = n = 1 mod c, a contradiction.

Finally, to find all necessary sequences test all sequences starting from
1 + t * c, whether (s + 1) does not divide 1 + t * c + s.

Bounds:

t > 0
1 + t * c <= N - 1
t * c <= N - 2
t <= (N - 2) / c
=#

using Printf

start = time()
result = 0

function p(s, n)
    r = 0
    c = BigInt(lcm(1:s))
    for t in 1:floor((n - 2) / c)
        if mod(1 + t * c + s, s + 1) != 0
            r += 1
        end
    end
    return r
end

for i in 1:31
    global result
    result += p(i, 4^i)
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
