module Day15

# using Plots

export solve1, solve2, AOCplot

mutable struct Game
    t::Int
    n::Int
    played::Vector{Int32}
    tracking::Bool
    ntmax::Vector{Tuple{Int, Int}}
end
Game(x::AbstractString, N, tracking=false) = Game(parse.(Int, split(x, ',')), N, tracking)
function Game(x::Vector{Int}, N, tracking)
    ntmax = tracking ? [reverse(findmax(x))] : Tuple{Int, Int}[]
    t = length(x)
    n = pop!(x)
    played = zeros(Int32, N)
    for (i,v) in enumerate(x)
        @inbounds played[v+1] = i
    end
    Game(t, n, played, tracking, ntmax)
end

function next!(g::Game)
    t, n = g.t, g.n
    @inbounds g.n = g.played[n+1] == 0 ? 0 : t - g.played[n+1]
    g.t += 1
    @inbounds g.played[n+1] = t
    g.tracking && trackmax!(g)
    return g.n
end

function trackmax!(g::Game)
    lastmax = g.ntmax[end][2]
    if g.n > lastmax
        push!(g.ntmax, (g.t, g.n))
    end
end

function solve(x, n, tracking)
    g = Game(x, n, tracking)
    for _ in g.t+1:n
        next!(g)
    end
    return g
end

solve1(x, tracking=false) = solve(x, 2020, tracking).n
solve2(x, tracking=false) = solve(x, 30_000_000, tracking).n

function AOCplot(data)
    g = solve(data, 30_000_000, true)
    t = [x[1] for x in g.ntmax]
    y = [x[2] for x in g.ntmax]
    kwargs = (title="AOC Day 15", xlabel="time step", ylabel="maximum spoken", legend=false)
    plot(t, y; kwargs...)
    savefig("viz/day15.png")
end

end  # module
