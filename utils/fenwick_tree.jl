module FenwickTree

"""
Keeps track of sum(1 <= i <= k) x_i, where 1 <= k <= n.
"""
struct Additive{T<:Integer}
    data::Vector{T}

    function Additive(values::Vector{T}) where T<:Integer
        data = copy(values)
        for index in 1:length(values)
            parent_index = index + lsb(index)
            if parent_index <= length(values)
                data[parent_index] += data[index]
            end
        end
        return new{T}(data)
    end
end

"""
Returns sum(1 <= i <= index) x_i, where 1 <= index <= n.
"""
function get(this::Additive{T}, index::Int64)::T where T<:Integer
    value = 0
    curr_index = index
    while curr_index > 0
        value += this.data[curr_index]
        curr_index -= lsb(curr_index)
    end
    return value
end

"""
Returns sum(a <= i <= b) x_i, where 1 <= a <= b <= n.
"""
function get_range(this::Additive{T}, a::Int64, b::Int64)::T where T<:Integer
    return get(this, b) - get(this, a - 1)
end

"""
Sets the value of a given x_i.
"""
function set(this::Additive{T}, index::Int64, value::T) where T<:Integer
    rem_value = get(this, index - 1) - get(this, index)
    update(this, index, rem_value)
    update(this, index, value)
end

"""
Adds value to a given x_i.
"""
function update(this::Additive{T}, index::Int64, value::T) where T<:Integer
    curr_index = index
    while curr_index <= length(this.data)
        this.data[curr_index] += value
        curr_index += lsb(curr_index)
    end
end

"""
Keeps track of prod(1 <= i <= k) x_i, where 1 <= k <= n.
"""
struct Multiplicative{T<:Integer}
    data::Vector{T}
    modulo::T

    function Multiplicative(values::Vector{T}, modulo::T) where T<:Integer
        data = copy(values)
        for index in 1:length(values)
            parent_index = index + lsb(index)
            if parent_index <= length(values)
                data[parent_index] *= mod(data[index], modulo)
                data[parent_index] = mod(data[parent_index], modulo)
            end
        end
        return new{T}(data, modulo)
    end
end

"""
Returns prod(1 <= i <= index) x_i, where 1 <= index <= n.
"""
function get(this::Multiplicative{T}, index::Int64)::T where T<:Integer
    value = 1
    curr_index = index
    while curr_index > 0
        value *= this.data[curr_index]
        value = mod(value, this.modulo)
        curr_index -= lsb(curr_index)
    end
    return value
end

"""
Returns prod(a <= i <= b) x_i, where 1 <= a <= b <= n.
"""
function get_range(this::Multiplicative{T}, a::Int64, b::Int64)::T where T<:Integer
    return mod(
        get(this, b) * invmod(get(this, a - 1), this.modulo),
        this.modulo
    )
end

"""
Sets the value of a given x_i.
"""
function set(this::Multiplicative{T}, index::Int64, value::T) where T<:Integer
    current_value = get_range(this, index, index)
    update_value = mod(value * invmod(current_value, this.modulo), this.modulo)
    update(this, index, update_value)
end

"""
Multiplies a given x_i by a value.
"""
function update(this::Multiplicative{T}, index::Int64, value::T) where T<:Integer
    curr_index = index
    while curr_index <= length(this.data)
        this.data[curr_index] *= mod(value, this.modulo)
        this.data[curr_index] = mod(this.data[curr_index], this.modulo)
        curr_index += lsb(curr_index)
    end
end

"""
Keeps track of sum(1 <= i <= k) prod(1 <= j <= i) x_j, where 1 <= k <= n.
"""
struct SumProduct{T<:Integer}
    data::Vector{T}
    mult_tree::Multiplicative{T}
    modulo::T

    function SumProduct(values::Vector{T}, modulo::T) where T<:Integer
        mult_tree = Multiplicative(values, modulo)
        data = zeros(T, length(values))
        tree = new{T}(data, mult_tree, modulo)

        total = 0
        current = 1
        for index in 1:length(values)
            current = mod(current * mod(values[index], modulo), modulo)
            total = mod(total + current, modulo)
            lower = index - lsb(index)
            data[index] = mod(
                mod(total - get(tree, lower), modulo) *
                invmod(get(mult_tree, lower), modulo),
                modulo
            )
        end

        return tree
    end
end

"""
Returns sum(1 <= i <= index) prod(1 <= j <= i) x_j, where 1 <= index <= n.
"""
function get(this::SumProduct{T}, index::Int64)::T where T<:Integer
    current_index = index
    total = 0
    while current_index > 0
        next_index = current_index - lsb(current_index)
        total = mod(
            this.data[current_index] + mod(
                get_range(
                    this.mult_tree,
                    next_index + 1,
                    current_index
                ) * total,
                this.modulo
            ),
            this.modulo
        )
        current_index = next_index
    end
    return total
end

"""
Returns sum(a <= i <= b) prod(a <= j <= i) x_j, where 1 <= a <= b <= n.
"""
function get_range(this::SumProduct{T}, a::Int64, b::Int64)::T where T<:Integer
    return mod(
        mod(get(this, b) - get(this, a - 1), this.modulo) *
        invmod(get(this.mult_tree, a - 1), this.modulo),
        this.modulo
    )
end

"""
Sets the value of a given x_i.
"""
function set(this::SumProduct{T}, index::Int64, value::T) where T<:Integer
    current_value = get_range(this, index, index)
    update_value = mod(value * invmod(current_value, this.modulo), this.modulo)
    update(this, index, update_value)
end

"""
Multiplies x_i by the given value.
"""
function update(this::SumProduct{T}, index::Int64, value::T) where T<:Integer
    current_index = index
    memo_lower_mult = get_range(this.mult_tree, 1, index - 1)
    memo_lower_range = get_range(this, 1, index - 1)
    while current_index <= length(this.data)
        lower_index = current_index - lsb(current_index) + 1
        if lower_index == 1
            lower_mult = memo_lower_mult
            lower_range = memo_lower_range
        else
            lower_mult = get_range(this.mult_tree, lower_index, index - 1)
            lower_range = get_range(this, lower_index, index - 1)
        end
        term = mod(
            mod(
                this.data[current_index] - lower_range,
                this.modulo
            ) * invmod(
                lower_mult,
                this.modulo
            ),
            this.modulo
        )
        term = mod(term * value, this.modulo)
        this.data[current_index] = mod(
            lower_range + mod(lower_mult * term, this.modulo),
            this.modulo
        )
        current_index += lsb(current_index)
    end
    update(this.mult_tree, index, value)
end

"""
Returns the least significant bit of x.
"""
function lsb(x::T)::T where T<:Integer
    return x & (-x)
end

end