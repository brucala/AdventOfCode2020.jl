module Day17

export solve1, solve2

const N_CYCLES = 6

function get_grid(x, fourD=false)
    x = split(x)
    n = length(x)
    dims = fourD ? (n, n, 1, 1) : (n, n, 1)
    grid = falses(dims .+ 2*(N_CYCLES+1))
    for i in 1:n
        if !fourD
            grid[N_CYCLES+i+1, N_CYCLES+2:N_CYCLES+n+1, N_CYCLES+2] = map(==('#'), collect(x[i]))
        else
            grid[N_CYCLES+i+1, N_CYCLES+2:N_CYCLES+n+1, N_CYCLES+2, N_CYCLES+2] = map(==('#'), collect(x[i]))
        end
    end
    return grid
end

isborder(g, pos) = any(x -> x[1] == 1 || x[1] == x[2], zip(pos, size(g)))

function step!(grid, t, n)
    flips = CartesianIndex[]
    m = N_CYCLES + 2
    imin = kmin = max(1, N_CYCLES + 1 - t)
    imax = min(size(grid)[1], N_CYCLES + 2  + n + t)
    kmax = min(size(grid)[3], N_CYCLES + 3  + t)
    I = (imin:imax, imin:imax, kmin:kmax)
    if ndims(grid) == 4
        I = (I..., kmin:kmax)
    end
    g = @view grid[I...]
    for i in eachindex(g)
        isborder(g, i.I) && continue
        flip(g, i) && push!(flips, i)
    end
    @inbounds for pos in flips
        g[pos] = ~g[pos]
    end
end

n_around(g, i, j, k) = count(@view g[i-1:i+1, j-1:j+1, k-1:k+1])
n_around(g, i, j, k, l) = count(@view g[i-1:i+1, j-1:j+1, k-1:k+1, l-1:l+1])

# for active case, use conditions + 1 because current position counts to naround
flip(naround::Int, active::Bool) = naround == 3 && !active || (naround ∉ (3, 4) && active)
function flip(g, pos)
    active = @inbounds g[pos]
    naround = n_around(g, pos.I...)
    return flip(naround, active)
end

function solve(x, fourD)
    grid = get_grid(x, fourD)
    n = size(grid)[1] - 2N_CYCLES - 2
    for t in 1:N_CYCLES
        step!(grid, t, n)
    end
    return sum(grid)
end

solve1(x) = solve(x, false)
solve2(x) = solve(x, true)

end  # module
