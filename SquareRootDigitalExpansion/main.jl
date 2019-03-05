#=
Approach:
Use the digit by digit algorithm to calculate square roots detailed in:
https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Digit-by-digit_calculation
=#

using Printf

start = time()

sq = [i * i for i in 1:10]
result = BigInt(0)

for i in 1:100
    if i in sq
        continue
    end
    p = BigInt(0)
    c = BigInt(i)
    s = 0
    while s > -100
        for d in 9:-1:0
            global result
            v = BigInt(d)
            y = v * (20 * p + v)
            if y <= c
                result = result + d
                p = 10 * p + v
                c = c - y
                break
            end
        end
        c = c * 100
        s = s - 1
    end
end

@printf("%d\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
