module Day24
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

const DIR = Dict(:e => (0, 2), :se => (1, 1), :sw => (1, -1), :w => (0, -2), :nw => (-1, -1), :ne => (-1, 1))

const ADJACENT = values(DIR)

function parse_input(x)
    lines = readlines(IOBuffer(x))
    return parse_line.(lines)
end
function parse_line(line)
    dirs = Vector{Symbol}()
    i = 1
    while i ≤ length(line)
        nchars = line[i] ∈ ('e', 'w') ? 1 : 2
        push!(dirs, Symbol(line[i:i+nchars-1]))
        i += nchars
    end
    return dirs
end

get_pos(dirs::Vector{Symbol}) = reduce((x, y) -> x .+ y, (DIR[d] for d in dirs))

function get_black_tiles(data)
    tile_flips = Dict{Tuple{Int, Int}, Bool}()
    for pos in get_pos.(data)
        tile_flips[pos] = ~get(tile_flips, pos, false)
    end
    return Set([pos for (pos, flips) in tile_flips if flips])
end

neighbors(pos) = (pos .+ dir for dir in ADJACENT)
nblack_neighbors(black_tiles, pos) = count(npos ∈ black_tiles for npos in neighbors(pos))
white_to_black(black_tiles, pos) = nblack_neighbors(black_tiles, pos) == 2
remains_black(nblack) = 0 < nblack < 3

function apply_rules(black_tiles)
    new_blacks = Set{Tuple{Int, Int}}()
    for pos in black_tiles
        nblack = 0
        for npos in neighbors(pos)
            if npos ∈ black_tiles
                nblack += 1
            else  # is white tile
                white_to_black(black_tiles, npos) && push!(new_blacks, npos)
            end
        end
        remains_black(nblack) && push!(new_blacks, pos)
    end
    return new_blacks
end


solve1(x) = get_black_tiles(x) |> length

function solve2(x)
    black_tiles = get_black_tiles(x)
    for _ in 1:100
        black_tiles = apply_rules(black_tiles)
    end
    return length(black_tiles)
end

end  # module
