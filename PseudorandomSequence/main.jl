using Printf

function char_to_num(c)
    v = Int(c)
    # Uppercase
    if 65 <= v && v <= 90
        return v - 65 + 26
    end
    # Lowercase
    return v - 97
end

function rand48(v)
    return (Int128(25214903917) * Int128(v) + Int128(11)) & Int128((1 << 48) - 1)
end

function get_b(a)
    return mod(a >> 16, 52)
end

function text_to_nums(text)
    return [char_to_num(c) for c in collect(text)]
end

function search_initial(seed)
    seed_nums = text_to_nums(seed)
    possible = []
    for a0 in 0:((1 << 18) - 1)
        a = a0
        valid = true
        for b in seed_nums
            if (b & 3) != (get_b(a) & 3)
                valid = false
                break
            end
            a = rand48(a)
        end
        if valid
            push!(possible, a0)
        end
    end
    for c0 in possible
        b0 = seed_nums[1]
        m0 = (b0 - (c0 >> 16)) >> 2
        for d0 in m0:13:((1 << 30) - 1)
            a0 = Int128((d0 << 18) + c0)
            a = a0
            found = true
            for b in seed_nums
                if b != get_b(a)
                    found = false
                    break
                end
                a = rand48(a)
            end
            if found
                return a0
            end
        end
    end
end

function beta(x)
    if x & 3 == 1
        return x
    else
        return -x
    end
end

function lambda(x)
    y = BigInt(x)
    res = powermod(y, Int128(1) << (48 - 1), Int128(1) << (2 * 48 - 1)) - 1
    res = res >> (48 + 1)
    return Int128(res & ((1 << (48 - 2)) - 1))
end

function theta(x)
    return lambda(beta(x))
end

function main()
    # Begin time measurement
    start = time()
    result = 0

    # Problem parameters
    seed = "PuzzleOne"
    objective = "LuckyText"

    # Algorithm parameters

    # Solution
    a0 = Int128(search_initial(seed))
    an = Int128(search_initial(objective))
    a = Int128(25214903917)
    b = Int128(11)
    c = ((a - 1) * a0 + b) & ((1 << 48) - 1)
    d = ((a - 1) * an + b) & ((1 << 48) - 1)
    e = (invmod(c, 1 << 48) * d) & ((1 << 48) - 1)

    ta = theta(a)
    te = theta(e)
    n_candidate = (invmod(ta, (1 << (48 - 2))) * te) & ((1 << (48 - 2)) - 1)

    if powermod(a, n_candidate, (1 << 48)) == e
        result = n_candidate
    else
        result = n_candidate + (1 << (48 - 2))
    end

    # Show result
    println(result)

    # End time measurement
    elapsed = time() - start
    @printf("Took: %.4f secs\n", elapsed)
end

main()
