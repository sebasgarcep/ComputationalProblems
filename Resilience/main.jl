#=
Approach:
The number of resilient fractions for a given d is:

phi(d) / (d - 1) = d / (d - 1) * prod(p | d, p prime) (1 - 1 / p)

Notice that r = 2 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23 * 29 satisfies the condition. Therefore we
need to find a smaller number that satisfies the condition. One might therefore try using multiples
of r / 29 and the smallest multiple that satisfies the condition is:

2^3 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23

Notice also that any other number with the same, or more prime factors as r will be larger than r.
Therefore the solution has at most 9 prime factors (as r has 10 and it is the smallest possible
solution with 10 prime factors, and we have already found a better solution with only 9 factors).

Now notice that prod(p | d, p prime) (1 - 1 / p) is minimal, for a fixed number of primes k, when
the primes are exactly the first k primes. Also, d / (d - 1) -> 1. Therefore phi(d) / (d - 1) is
smaller as d grows. Assume, for the sake of argument that d = 1 (the best possible case). Then
the problem reduces to prod(p | d, p prime) (1 - 1 / p) < 15499 / 94744.  Thus if we have 8 or less
prime factors, the minimal solution is 2 * 3 * 5 * 7 * 11 * 13 * 17 * 19. But this solution on the
best case (d / (d - 1) = 1) does not satisfy the condition. Therefore the solution to the problem
must have exactly 9 different prime factors.

Thus the largest prime factor in the product has to be such that:

2 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * p <= 2^3 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23
p <= 2^2 * 23
p <= 92

Thus the list of primes is:

2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89

From this list we have to choose 9 primes, and find all multiples such that the multiple factor
is divisible only by these primes and the number itself is less then or equal to the largest solution
up to that point in the search, starting with 2^3 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23. If that
multiple satisfies the condition then we update the solution and stop searching with that choice,
as any further multiples must be larger.

Finally, because the largest multiple is 4, we only have to check whether 2 or 3 are part of the list
of primes.

=#

using Printf

function main()
    start = time()
    result = 0

    # Problem parameters
    l = 15499.0 / 94744.0

    # Algorithm parameters
    initial_solution = 2^3 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23

    # Solution
    result = initial_solution
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89]

    # Generate all possible choices of 9 different prime factors
    for a in 1:length(primes)
        for b in (a + 1):length(primes)
            for c in (b + 1):length(primes)
                for d in (c + 1):length(primes)
                    for e in (d + 1):length(primes)
                        for f in (e + 1):length(primes)
                            for g in (f + 1):length(primes)
                                for h in (g + 1):length(primes)
                                    for i in (h + 1):length(primes)
                                        # Multiply the prime factors
                                        m = 1
                                        m *= primes[a]
                                        m *= primes[b]
                                        m *= primes[c]
                                        m *= primes[d]
                                        m *= primes[e]
                                        m *= primes[f]
                                        m *= primes[g]
                                        m *= primes[h]
                                        m *= primes[i]
                                        # Obtain prod(p | d, p prime) (1 - 1 / p)
                                        v = 1
                                        v *= 1.0 - 1.0 / primes[a]
                                        v *= 1.0 - 1.0 / primes[b]
                                        v *= 1.0 - 1.0 / primes[c]
                                        v *= 1.0 - 1.0 / primes[d]
                                        v *= 1.0 - 1.0 / primes[e]
                                        v *= 1.0 - 1.0 / primes[f]
                                        v *= 1.0 - 1.0 / primes[g]
                                        v *= 1.0 - 1.0 / primes[h]
                                        v *= 1.0 - 1.0 / primes[i]
                                        # Test whether 1 * m satisfies the condition
                                        if v * m / (m - 1) < l &&
                                            m < result
                                            result = m
                                            continue
                                        end
                                        # Test whether 2 is in the list of chosen primes
                                        # and 2 * m satisfies the condition
                                        if primes[a] == 2 &&
                                            v * 2 * m / (2 * m - 1) < l &&
                                            2 * m < result
                                            result = 2 * m
                                            continue
                                        end
                                        # Test whether 3 is in the list of chosen primes
                                        # and 3 * m satisfies the condition
                                        if (primes[a] == 3 || primes[a] == 3) &&
                                            v * 3 * m / (3 * m - 1) < l &&
                                            3 * m < result
                                            result = 3 * m
                                            continue
                                        end
                                        # Test whether 2 is in the list of chosen primes
                                        # and 4 * m satisfies the condition
                                        if primes[a] == 2 &&
                                            v * 4 * m / (4 * m - 1) < l &&
                                            4 * m < result
                                            result = 4 * m
                                            continue
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    println(result)

    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
