module Day20

export solve1#, solve2

const SEA_MONSTER_STR =
"""
                  #.
#    ##    ##    ###
 #  #  #  #  #  #  .
"""

toint(x) = parse(Int, x)

struct Tile
    id::Int
    grid::BitMatrix
end
function Tile(x::AbstractString)
    x = split(strip(x), '\n')
    id = x[1][6:end-1] |> toint
    grid = getgrid(x[2:end])
    Tile(id, grid)
end

getgrid(x::AbstractString) = getgrid(split(strip(x, '\n'), '\n'))
function getgrid(x)
    n, m = length(x), length(x[1])
    grid = map(==('#'), Iterators.flatten(x))
    return reshape(grid, (m,n))'  # so it's well oriented
end

borders(t::Tile) = @views [t.grid[1,:], t.grid[:,1], t.grid[end,:], t.grid[:,end]]

overlaps(v1::AbstractVector, v2::AbstractVector) = v1 == v2 ? :yes : v1 == reverse(v2) ? :flipped : :no
function overlaps(t1::Tile, t2::Tile)
    for v1 in borders(t1), v2 in borders(t2)
        overlaps(v1, v2) ∈ (:yes, :flipped) && return true
    end
    return false
end

function parse_input(x)
    grids = Tile.(split(x, "\n\n"))
end

# checks that the overlap matrix is minimum for a NxN grid, i.e.:
# 4 corners (overlap 2)
# 4(N-2) non cornered borders (overlap 3)
# (N-2)^2 non borders (overlap 4)
# this greatly simplifies the problem
check(x::AbstractString) = check(parse_input(x))
check(grids::Vector{Tile}) = check(noverlaps(grids))
function check(n)
    N = √(length(n)) |> Int
    nexpected = (4, 4(N-2), (N-2)^2)
    nfound = Tuple(count(==(i), n) for i in 2:4)
    return nfound == nexpected
end

function noverlaps(grids)
    N = length(grids)
    n = zeros(Int, N)
    for i in 1:N, j in i+1:N
        o = overlaps(grids[i], grids[j])
        n[i] += o
        n[j] += o
    end
    return n
end

function solve1(x)
    grids = parse_input(x)
    n = noverlaps(grids)
    @assert check(n)
    return prod(grids[i].id for i in findall(==(2), n))
end

function solve2(x)
end

end  # module
