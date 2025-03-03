module FenwickTree

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

function get(this::Additive{T}, index::Int64)::T where T<:Integer
    value = 0
    curr_index = index
    while curr_index > 0
        value += this.data[curr_index]
        curr_index -= lsb(curr_index)
    end
    return value
end

function set(this::Additive, index::Int64, value::T) where T<:Integer
    rem_value = get(this, index - 1) - get(this, index)
    update(this, index, rem_value)
    update(this, index, value)
end

function update(this::Additive{T}, index::Int64, value::T) where T<:Integer
    curr_index = index
    while curr_index <= length(this.data)
        this.data[curr_index] += value
        curr_index += lsb(curr_index)
    end
end

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

function set(this::Multiplicative, index::Int64, value::T) where T<:Integer
    rem_value = mod(
        invmod(get(this, index), this.modulo) * get(this, index - 1),
        this.modulo
    )
    update(this, index, rem_value)
    update(this, index, value)
end

function update(this::Multiplicative{T}, index::Int64, value::T) where T<:Integer
    curr_index = index
    while curr_index <= length(this.data)
        this.data[curr_index] *= mod(value, this.modulo)
        this.data[curr_index] = mod(this.data[curr_index], this.modulo)
        curr_index += lsb(curr_index)
    end
end

function lsb(x::T)::T where T<:Integer
    return x & (-x)
end

end