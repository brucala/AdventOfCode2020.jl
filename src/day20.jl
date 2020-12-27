module Day20
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

@enum Dir N E S W
Base.:(+)(d::Dir, n::Int) = Dir((Int(d) + n) % 4)
opposite(d::Dir) = d + 2
nrotations(from::Dir, to::Dir) = Int(to + (4 - Int(from)))
sameaxis(d1::Dir, d2::Dir) = d1 === d2 || d1 === opposite(d2)
isvertical(d::Dir) = d === N || d === S

bitGrid(x) = getgrid(x,==('#'))

mutable struct Tile
    id::Int
    grid::BitMatrix
    neighbors::Dict{Int, Dir}
end
function Tile(x::AbstractString)
    x = splitlines(strip(x))
    id = x[1][6:end-1] |> toint
    grid = bitGrid(x[2:end])
    Tile(id, grid, Dict())
end
len(t::Tile) = size(t.grid)[1]

border(::Val{N}, t::Tile) = t.grid[1,:]
border(::Val{E}, t::Tile) = t.grid[:,end]
border(::Val{S}, t::Tile) = t.grid[end,:]
border(::Val{W}, t::Tile) = t.grid[:,1]
borders(t::Tile) = @views [border(Val(d), t) for d in [N, E, S, W]]

"do these tiles overlap? (updates the 'overlaps' field with the overlapping direction)"
function overlaps!(t1::Tile, t2::Tile)
    for (i1, v1) in enumerate(borders(t1)), (i2, v2) in enumerate(borders(t2))
        overlaps(v1, v2) || continue
        t1.neighbors[t2.id] = Dir(i1-1)
        t2.neighbors[t1.id] = Dir(i2-1)
        return true
    end
    return false
end
overlaps(v1::AbstractVector, v2::AbstractVector) = v1 == v2 || v1 == reverse(v2)

function parse_input(x)
    grids = Tile.(split(x, "\n\n"))
end

"""
checks that the overlap matrix is minimum for a NxN grid, i.e.:
4 corners (overlap 2)
4(N-2) non cornered borders (overlap 3)
(N-2)^2 non borders (overlap 4)
this greatly simplifies the problem
"""
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
        overlaps!(grids[i], grids[j]) || continue
        n[i] += 1
        n[j] += 1
    end
    return n
end

function solve1(grids)
    n = noverlaps(grids)
    @assert check(n)
    return prod(grids[i].id for i in findall(==(2), n))
end

const SEA_MONSTER_STR =
"""
                  #.
#    ##    ##    ###
 #  #  #  #  #  #  .
"""
const SEA_MONSTER = bitGrid(SEA_MONSTER_STR)

const Δ = Dict(E => (0,1), W => (0, -1), S => (1, 0), N => (-1, 0))

# a flip is around the axis. E.g. vflip is around vertical axis
vflip(grid) = grid[1:end, end:-1:1]
hflip(grid) = grid[end:-1:1, 1:end]
flip(axis::Dir, grid) = isvertical(axis) ? vflip(grid) : hflip(grid)
rotate(::Val{0}, grid) = grid
rotate(::Val{1}, grid) = vflip(grid')
rotate(::Val{2}, grid) = grid[end:-1:1, end:-1:1]  # same as vflip + hflip
rotate(::Val{3}, grid) = hflip(grid')

rotate(n::Int, d::Dict{Int, Dir}) = Dict(id => dir + n for (id, dir) in d)
function rotate!(t::Tile, n::Int)
    t.grid = rotate(Val(n), t.grid)
    t.neighbors = rotate(n, t.neighbors)
end
function flip!(t::Tile, axis::Dir)
    t.grid = flip(axis, t.grid)
    for id in keys(t.neighbors)
        if !sameaxis(t.neighbors[id], axis)
            t.neighbors[id] += 2
        end
    end
end

"rotates and flips t2 as necessary to fit t1"
function fit!(t1::Tile, t2::Tile)
    dir = t1.neighbors[t2.id]
    from_dir = t2.neighbors[t1.id]
    to_dir = opposite(dir)
    # 1. rotate
    nrots = nrotations(from_dir, to_dir)
    rotate!(t2, nrots)
    # 2. flip if needed
    if border(Val(dir), t1) ≠ border(Val(to_dir), t2)
        flip!(t2, to_dir)
    end
end

function fix_and_fit!(tiles, id, fixed=Set{Int}())
    push!(fixed, id)
    for (nid, ndir) ∈ tiles[id].neighbors
        nid ∈ fixed && continue
        fit!(tiles[id], tiles[nid])
        fix_and_fit!(tiles, nid, fixed)
    end
end

function image(tiles)
    Npixels = len(first(tiles)[2])
    Ngrids = length(tiles)
    N = (Npixels - 2) * Int(√Ngrids)
    image = falses(N, N)
    # find first (top-left)
    tid = findfirst(t -> Set(values(t.neighbors)) == Set([E, S]), tiles)
    # create image using top left corner as seed
    image!(image, tiles, tid, 1, 1)
end

function image!(image, tiles, tid, r, c, added=Set{Int}())
    tile = tiles[tid]
    grid = @view tile.grid[2:end-1,2:end-1]
    N = size(grid)[1]
    pos = Tuple(1+N*(p-1):N*(p) for p in (r,c))
    image[pos...] = grid
    push!(added, tile.id)
    #add neighbors
    for (nid, ndir) in tile.neighbors
        nid ∈ added && continue
        rr, cc = (r, c) .+ Δ[ndir]
        image!(image, tiles, nid, rr, cc, added)
    end
    return image
end

function scan_sea_monsters(image)
    for nrots in 0:3, flip in (false, true)
        img, monsters = scan_sea_monsters(image, nrots, flip)
        count(monsters) ≠ 0 && return count(img .& .~monsters)
    end
end
function scan_sea_monsters(image, nrotations, flip)
    img = flip ? vflip(image) : image
    img = rotate(Val(nrotations), img)
    monsters = falses(size(img))
    n, m = size(SEA_MONSTER)
    N = size(img)[1]
    for i in 1:N-n, j in 1:N-m
        if @views img[i:i+n-1, j:j+m-1] .& SEA_MONSTER == SEA_MONSTER
            monsters[i:i+n-1, j:j+m-1] = SEA_MONSTER
        end
    end
    return img, monsters
end

function solve2(grids)
    # find the neighbors
    n = noverlaps(grids)
    # rearrange orientations
    tile = grids[findfirst(==(2), n)]  # a corner
    tiles = Dict(t.id => t for t in grids)
    fix_and_fit!(tiles, tile.id)
    # make image
    img = image(tiles)
    # scan for sea monster and get solution
    return scan_sea_monsters(img)
end

end  # module
