#=
Approach:

First use deduction to fill as much of the sudoku as possible. After no more positions
are deducible, use backtracing to guess a solution.

=#

using Printf

function set_impossible(possible, i, j, k)
    # Square origin
    u = 3 * (cld(i, 3) - 1) + 1
    v = 3 * (cld(j, 3) - 1) + 1
    for s in 1:9
        # Set cell
        possible[i, j, s] = 0
        # Set row
        possible[i, s, k] = 0
        # Set column
        possible[s, j, k] = 0
        # Set square
        possible[u + mod(s - 1, 3), v + fld(s - 1, 3), k] = 0
    end
end

function step(puzzle, possible)
    # While we still can find deductions to make
    deducible = true
    while deducible
        deducible = false
        for i in 1:9
            for j in 1:9
                # If the cell is unfilled
                if puzzle[i, j] != 0
                    continue
                end
                # Determine how many possibilities there are for that cell
                total_possible = sum(possible[i, j, :])
                # If there are no possibilities then this board is unsolvable
                if total_possible == 0
                    return (-1, puzzle, possible)
                end
                # If there is more than one possibility then this cell is not deducible
                if total_possible > 1
                    continue
                end
                # Otherwise the cell is deducible
                deducible = true
                for k in 1:9
                    # Find the possible value and set it
                    if possible[i, j, k] == 1
                        puzzle[i, j] = k
                        set_impossible(possible, i, j, k)
                        break
                    end
                end
                # Test whether we have already filled the board, as it must
                # always add up to 405.
                if sum(puzzle) == 405
                    return (1, puzzle, possible)
                end
            end
        end
    end

    # Find the cell with the least amount of possibilities
    min_i = 0
    min_j = 0
    min_possible = 10
    for i in 1:9
        for j in 1:9
            # If the cell is set we cannot make a guess
            if puzzle[i, j] != 0
                continue
            end
            total_possible = sum(possible[i, j, :])
            if total_possible < min_possible
                min_i = i
                min_j = j
            end
        end
    end

    # Now make a guess (Notice that exactly one of these guesses will be right)
    # Test all possible values from 1-9
    for k in 1:9
        # If this value is not possible do not test it
        if possible[min_i, min_j, k] != 1
            continue
        end
        # Otherwise make a copy of the board and the possible states
        next_puzzle = copy(puzzle)
        # Set the guess
        next_puzzle[min_i, min_j] = k
        next_possible = copy(possible)
        # Set its impossibilities
        set_impossible(next_possible, min_i, min_j, k)
        # Go through another step of deductions and guesses
        (step_result, step_puzzle, step_possible) = step(next_puzzle, next_possible)
        # The possible results are:
        # -1 => The board is unsolvable
        # 0 => The board was not completely solved (should be unreachable)
        # 1 => The board was succesfully solved
        if step_result > 0
            return (step_result, step_puzzle, step_possible)
        end
    end

    # Should be unreachable
    return (0, puzzle, possible)
end

function solve(puzzle)
    # Fill all initial possibilities
    possible = ones(Int64, 9, 9, 9)
    for i in 1:9
        for j in 1:9
            k = puzzle[i, j]
            if k != 0
                for s in 1:9
                    set_impossible(possible, i, j, k)
                end
            end
        end
    end
    # Obtain the result of the deductions, guess steps
    (_, final_puzzle, _) = step(puzzle, possible)
    # Set the puzzle to the final result
    for i in 1:9
        for j in 1:9
            puzzle[i, j] = final_puzzle[i, j]
        end
    end
end

start = time()
result = 0

contents = open("sudoku.txt") do file
    read(file, String)
end

contents = strip(contents)
contents = split(contents, '\n')

puzzles = []
idx = 0
row = 0

for line in contents
    global idx, puzzles, row
    if occursin("Grid ", line)
        idx += 1
        push!(puzzles, zeros(Int64, 9, 9))
        row = 1
    else
        for column in 1:9
            puzzles[idx][row, column] = parse(Int64, line[column])
        end
        row += 1
    end
end

for (pos, item) in enumerate(puzzles)
    global result
    solve(item)
    result += item[1, 1] * 100 + item[1, 2] * 10 + item[1, 3]
end

println(result)

elapsed = time() - start
@printf("Took: %.4f secs\n", elapsed)
