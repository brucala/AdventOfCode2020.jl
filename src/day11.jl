module Day11

export solve1, solve2

isvalid_index(grid, i, j) = 1 <= i <= size(grid)[1] && 1<= j <= size(grid)[2]

noccupied(grid) = count(==('#'), grid)

# part 1 (includes position i,j in the count)
function noccupied_neighbors(grid, i, j)
    n, m = size(grid)
    noccupied(@view grid[max(i-1, 1):min(i+1, n), max(j-1, 1):min(j+1, m)])
end

function noccupied_neighbors(grid, i, j, fulldepth)
    # because it's much faster
    fulldepth || return noccupied_neighbors(grid, i, j)

    directions = [(i,j) for i=-1:1, j=-1:1 if (i,j)!=(0,0)]
    return sum(find_occupied(grid, i, j, dir, fulldepth) for dir in directions)
end

function find_occupied(grid, i, j, direction, fulldepth)
    depth, maxdepth = 0, fulldepth ? 10000 : 1
    while depth < maxdepth
        depth += 1
        i, j = (i,j) .+ direction
        isvalid_index(grid, i, j) || return 0
        grid[i,j] == '.' && continue
        return grid[i,j] == '#' ? 1 : 0
    end
    return 0
end

function step(grid, i, j, fulldepth)
    grid[i,j] == '.' && return '.'
    nocc = noccupied_neighbors(grid, i, j, fulldepth)
    grid[i,j] == 'L' && nocc == 0 && return '#'
    # note that nocc includes pos i,j in the count for part1 -> require >=5 for both parts
    grid[i,j] == '#' && nocc >= 5  && return 'L'
    return grid[i,j]
end

function step(grid, fulldepth)
    oldg = copy(grid)
    n, m = size(grid)
    changed = false
    for i in 1:n, j in 1:m
        grid[i,j] = step(oldg, i, j, fulldepth)
        if grid[i,j] != oldg[i,j] changed = true end
    end
    grid, !changed
end

function get_grid(x)
    grid = readlines(IOBuffer(x)) .|> collect
    hcat(grid...)
end

function solve(x, fulldepth=false)
    grid = get_grid(x)
    i = 0
    while true
        i += 1
        grid, stop = step(grid, fulldepth)
        stop && break
    end
    return noccupied(grid)
end

solve1(x) = solve(x)
solve2(x) = solve(x, true)


end  # module
