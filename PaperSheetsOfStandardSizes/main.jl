#=
Approach:
Run through the tree of possibilities. Keep numerators and denominators separate
to avoid losing precision.
=#

using Printf

function search(probs, envelope, found, num, den)
    total = sum(envelope)

    if total == 0
        (a, b) = probs[found + 1]
        rat = (a * den + b * num, b * den)
        factor = gcd(rat[1], rat[2])
        rat = (div(rat[1], factor), div(rat[2], factor))
        probs[found + 1] = rat
        return
    end

    if total == 1 && envelope[1] == 0
        found = found + 1
    end

    total = BigInt(total)
    for (pos, quantity) in enumerate(envelope)
        quantity = BigInt(quantity)
        if quantity == 0
            continue
        end
        remaining = copy(envelope)
        remaining[pos] = remaining[pos] - 1
        for idx in 1:(pos - 1)
            remaining[idx] = remaining[idx] + 1
        end
        search(probs, remaining, found, num * quantity, den * total)
    end
end

start = time()

probs = [(BigInt(0), BigInt(1)) for _ in 1:4]
envelope = [1, 1, 1, 1]
found = 0
num = BigInt(1)
den = BigInt(1)
search(probs, envelope, found, num, den)

result = 0
for (pos, (num, den)) in enumerate(probs)
    global result
    result = result + (pos - 1) * num / den
end

@printf("%.6f\n", result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)


