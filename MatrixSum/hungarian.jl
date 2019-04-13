#=
Approach:
To prove that the Hungarian Algorithm works:

Notice that from the initial reduction, if we obtain n vertical lines, that means
that we have a set of disjoint minimal values already, and so we are done.
=#

# Hungarian Algorithm ==========================================================
# sources:
# https://stackoverflow.com/questions/23278375/hungarian-algorithm
# http://csclab.murraystate.edu/~bob.pilgrim/445/munkres.html

DONE = -1
STEP_COVER_COLUMNS = 0
STEP_PRIME_UNCOVERED = 1
STEP_INCREMENT_SET = 2
STEP_MAKE_MORE_ZEROES = 3

# For each row, subtract its lowest element
function reduce_matrix(mat, matlen)
    for i in 1:matlen
        mat[i, :] .-= minimum(mat[i, :])
    end
end

# Star all zeros that do not share a column or row with a starred zero
function init_stars(mat, matlen, starred)
    for i in 1:matlen
        for j in 1:matlen
            if mat[i, j] == 0 && sum(starred[i, :]) == 0 && sum(starred[:, j]) == 0
                starred[i, j] = 1
            end
        end
    end
end

# Cover each column of starred zeros
function cover_columns_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines)
    for j in 1:matlen
        if sum(starred[:, j]) > 0
            vlines[j] = 1
        end
    end

    # Test whether an optimal assignment is possible
    if sum(vlines) == matlen
        return DONE
    end

    return STEP_PRIME_UNCOVERED
end

# Find a noncovered zero and prime it
function prime_some_uncovered_zero(mat, matlen, starred, primed, hlines, vlines)
    while true
        # Find a noncovered zero and prime it.
        row = -1
        col = -1
        found_noncovered = false
        for i in 1:matlen
            if hlines[i] != 0
                continue
            end
            for j in 1:matlen
                if mat[i, j] != 0 || vlines[j] != 0
                    continue
                end
                row = i
                col = j
                found_noncovered = true
                break
            end
            if found_noncovered
                break
            end
        end
        if row == -1
            return (STEP_MAKE_MORE_ZEROES, -1, -1)
        else
            primed[row, col] = 1
            # Find star in row
            coltmp = -1
            for j in 1:matlen
                if starred[row, j] == 1
                    coltmp = j
                    break
                end
            end
            if coltmp == -1
                return (STEP_INCREMENT_SET, row, col)
            else
                # Cover this row and uncover the starred column
                col = coltmp
                hlines[row] = 1
                vlines[col] = 0
            end
        end
    end
end

# Construct a series of alternating primed and starred zeros as follows.
function increment_set_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines, row, col)
    # Let Z0 represent the uncovered primed zero found in Step 4.
    path = [(row, col)]
    while true
        # Let Z1 denote the starred zero in the column of Z0 (if any).
        row = -1
        for i in 1:matlen
            if starred[i, col] == 1
                row = i
                break
            end
        end
        if row == -1
            break
        end
        push!(path, (row, col))
        # Let Z2 denote the primed zero in the row of Z1 (there will always be one).
        col = -1
        for j in 1:matlen
            if primed[row, j] == 1
                col = j
                break
            end
        end
        push!(path, (row, col))
    end
    # Continue until the series terminates at a primed zero that has no starred zero in its column.
    # Unstar each starred zero of the series, star each primed zero of the series,
    for (idx, (row, col)) in enumerate(path)
        starred[row, col] = idx % 2
    end
    # erase all primes
    for i in 1:matlen
        for j in 1:matlen
            primed[i, j] = 0
        end
    end
    # uncover every line in the matrix.
    for i in 1:matlen
        hlines[i] = 0
    end
    for j in 1:matlen
        vlines[j] = 0
    end
    return STEP_COVER_COLUMNS
end

# Add the smallest uncovered value to every element of each covered row
# Subtract it from every element of each uncovered column.
function make_more_zeroes(mat, matlen, starred, primed, hlines, vlines)
    val = 0
    found = false
    for i in 1:matlen
        if hlines[i] != 0
            continue
        end
        for j in 1:matlen
            if vlines[j] != 0
                continue
            end
            if !found || mat[i, j] < val
                val = mat[i, j]
                found = true
            end
        end
    end

    for i in 1:matlen
        if hlines[i] == 1
            mat[i, :] .+= val
        end
    end

    for j in 1:matlen
        if vlines[j] == 0
            mat[:, j] .-= val
        end
    end

    return STEP_PRIME_UNCOVERED
end

function hungarian(mat)
    mat = copy(mat)
    matlen, = size(mat)
    reduce_matrix(mat, matlen)
    starred = zeros(matlen, matlen)
    init_stars(mat, matlen, starred)
    primed = zeros(matlen, matlen)
    hlines = zeros(matlen)
    vlines = zeros(matlen)
    step = STEP_COVER_COLUMNS
    row = -1
    col = -1
    count = 0
    while step != DONE
        if step == STEP_COVER_COLUMNS
            step = cover_columns_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines)
        elseif step == STEP_PRIME_UNCOVERED
            (step, row, col) = prime_some_uncovered_zero(mat, matlen, starred, primed, hlines, vlines)
        elseif step == STEP_INCREMENT_SET
            step = increment_set_of_starred_zeroes(mat, matlen, starred, primed, hlines, vlines, row, col)
        elseif step == STEP_MAKE_MORE_ZEROES
            step = make_more_zeroes(mat, matlen, starred, primed, hlines, vlines)
        end
    end
    return starred
end
