module Factorize
    using Memoize

    export get_next

    @memoize function get_next(remaining::T) where {T<:Integer}
        if remaining == 1
            return nothing
        end
        expo = 0
        if remaining & 1 == 0
            prime = 2
            while remaining & 1 == 0
                expo += 1
                remaining = remaining >> 1
            end
        else
            for test in 3:2:isqrt(remaining)
                if remaining % test == 0
                    prime = test
                    while remaining % test == 0
                        expo += 1
                        remaining = fld(remaining, test)
                    end
                    break
                end
            end
            if expo == 0
                expo = 1
                prime = remaining
                remaining = 1
            end
        end
        return prime, expo, remaining
    end
end
