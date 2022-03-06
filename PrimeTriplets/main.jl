using Printf

function t(n)
    return (n * (n + 1)) >> 1
end

function s(n)
    limit = isqrt(t(n + 2))

    # Base
    slots = [true for _ in 1:limit]
    slots[1] = false
    # Rows
    slots_1 = [true for _ in 1:(n - 2)]
    slots_2 = [true for _ in 1:(n - 1)]
    slots_3 = [true for _ in 1:n]
    slots_4 = [true for _ in 1:(n + 1)]
    slots_5 = [true for _ in 1:(n + 2)]
    for p in 2:limit
        if slots[p]
            # Base
            for k in (p * p):p:limit
                slots[k] = false
            end
            # Rows
            offset_1 = mod(t(n - 3) + 1, p)
            for k in (mod(-offset_1, p) + 1):p:(n - 2)
                slots_1[k] = false
            end
            offset_2 = mod(t(n - 2) + 1, p)
            for k in (mod(-offset_2, p) + 1):p:(n - 1)
                slots_2[k] = false
            end
            offset_3 = mod(t(n - 1) + 1, p)
            for k in (mod(-offset_3, p) + 1):p:n
                slots_3[k] = false
            end
            offset_4 = mod(t(n) + 1, p)
            for k in (mod(-offset_4, p) + 1):p:(n + 1)
                slots_4[k] = false
            end
            offset_5 = mod(t(n + 1) + 1, p)
            for k in (mod(-offset_5, p) + 1):p:(n + 2)
                slots_5[k] = false
            end
        end
    end

    prime_triplets = [false for _ in 1:n]
    # Look for prime triplet centers in row 2
    for k in 1:(n - 1)
        if slots_2[k]
            num_neighbours = 0
            # Row 1
            if k - 1 >= 1 && slots_1[k - 1]
                num_neighbours += 1
            end
            if k <= n - 2 && slots_1[k]
                num_neighbours += 1
            end
            if k + 1 <= n - 2 && slots_1[k + 1]
                num_neighbours += 1
            end
            # Row 2
            if k - 1 >= 1 && slots_2[k - 1]
                num_neighbours += 1
            end
            if k + 1 <= n - 1 && slots_2[k + 1]
                num_neighbours += 1
            end
            # Row 3
            if k - 1 >= 1 && slots_3[k - 1]
                num_neighbours += 1
            end
            if slots_3[k]
                num_neighbours += 1
            end
            if k + 1 <= n && slots_3[k + 1]
                num_neighbours += 1
            end
            # Mark prime triplets
            if num_neighbours >= 2
                if k - 1 >= 1 && slots_3[k - 1]
                    prime_triplets[k - 1] = true
                end
                if slots_3[k]
                    prime_triplets[k] = true
                end
                if k + 1 <= n && slots_3[k + 1]
                    prime_triplets[k + 1] = true
                end
            end
        end
    end
    # Look for prime centers in row 3
    for k in 1:n
        if slots_3[k]
            num_neighbours = 0
            # Row 2
            if k - 1 >= 1 && slots_2[k - 1]
                num_neighbours += 1
            end
            if k <= n - 1 && slots_2[k]
                num_neighbours += 1
            end
            if k + 1 <= n - 1 && slots_2[k + 1]
                num_neighbours += 1
            end
            # Row 3
            if k - 1 >= 1 && slots_3[k - 1]
                num_neighbours += 1
            end
            if k + 1 <= n && slots_3[k + 1]
                num_neighbours += 1
            end
            # Row 4
            if k - 1 >= 1 && slots_4[k - 1]
                num_neighbours += 1
            end
            if slots_4[k]
                num_neighbours += 1
            end
            if k + 1 <= n + 1 && slots_4[k + 1]
                num_neighbours += 1
            end
            # Mark prime triplets
            if num_neighbours >= 2
                if k - 1 >= 1 && slots_3[k - 1]
                    prime_triplets[k - 1] = true
                end
                prime_triplets[k] = true
                if k + 1 <= n && slots_3[k + 1]
                    prime_triplets[k + 1] = true
                end
            end
        end
    end
    # Look for prime centers in row 4
    for k in 1:(n + 1)
        if slots_4[k]
            num_neighbours = 0
            # Row 3
            if k - 1 >= 1 && slots_3[k - 1]
                num_neighbours += 1
            end
            if k <= n && slots_3[k]
                num_neighbours += 1
            end
            if k + 1 <= n && slots_3[k + 1]
                num_neighbours += 1
            end
            # Row 4
            if k - 1 >= 1 && slots_4[k - 1]
                num_neighbours += 1
            end
            if k + 1 <= n + 1 && slots_4[k + 1]
                num_neighbours += 1
            end
            # Row 5
            if k - 1 >= 1 && slots_5[k - 1]
                num_neighbours += 1
            end
            if slots_5[k]
                num_neighbours += 1
            end
            if k + 1 <= n + 2 && slots_5[k + 1]
                num_neighbours += 1
            end
            # Mark prime triplets
            if num_neighbours >= 2
                if k - 1 >= 1 && slots_3[k - 1]
                    prime_triplets[k - 1] = true
                end
                if k <= n && slots_3[k]
                    prime_triplets[k] = true
                end
                if k + 1 <= n && slots_3[k + 1]
                    prime_triplets[k + 1] = true
                end
            end
        end
    end

    value = 0
    for k in 1:n
        if prime_triplets[k]
            value += t(n - 1) + k
        end
    end

    return value
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters

    # Algorithm parameters

    # Solution
    result = s(5678027) + s(7208785)

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
