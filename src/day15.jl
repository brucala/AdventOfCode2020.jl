module Day15

export solve1, solve2

mutable struct Game
    t::Int
    n::Int
    played::Dict{Int,Int}
end
Game(x::AbstractString) = Game(parse.(Int, split(x, ',')))
function Game(x::Vector{Int})
    t = length(x)
    n = pop!(x)
    played = Dict(n => t for (t, n) in enumerate(x))
    Game(t, n, played)
end

function next!(g::Game)
    t, n = g.t, g.n
    g.n = t - get(g.played, n, t)
    g.t += 1
    g.played[n] = t
    return g.n
end

function solve1(x, n=2020)
    g = Game(x)
    for t in g.t+1:n
        next!(g)
    end
    return g.n
end

function solve2(x)
    solve1(x, 30_000_000)
end

end  # module
