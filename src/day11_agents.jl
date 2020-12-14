using Agents, AgentsPlots

const TEST = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

function get_grid(test=false)
    if test
        grid = split(TEST) .|> collect
    else
        grid = readlines("data/input11.txt") .|> collect
    end
    hcat(grid...)
end


mutable struct Seat <: AbstractAgent
    id::Int
    pos::Tuple{Int,Int}
    occupied::Bool
end

function build_model(layout; nmax::Int = 4)
    n, m = size(layout)
    space = GridSpace((n, m), moore = true)
    properties = Dict(:nmax => nmax)
    model = ABM(Seat, space; properties = properties)
    for r in 1:n
        for c in 1:m
            layout[r, c] == '.' && continue
            agid = Agents.coord2vertex((r,c), model)
            add_agent_pos!(Seat(agid, (r, c), false), model)
        end
    end
    return model
end

function model_step!(model, f_nocc=nocc_neighbors)
    new_status = Dict{Int, Bool}()
    for (agid, ag) in model.agents
        nocc = f_nocc(ag, model)
        if !ag.occupied && nocc == 0
            new_status[agid] = true
        elseif ag.occupied && nocc ≥ model.nmax
            new_status[agid] = false
        end
    end
    for (agid, status) in new_status
        model.agents[agid].occupied = status
    end
    return isempty(new_status)
end

function nocc_neighbors(ag, model)
    nocc = 0
    # this code is 5x slower :(
    # for agid in space_neighbors(ag, model)
    #     nocc += model.agents[agid].occupied
    # end
    agpos = ag.pos
    for d in DIRS
        pos = agpos .+ d
        isvalid_index(pos..., model.space.dimensions...) || continue
        agid = Agents.coord2vertex(pos, model)
        haskey(model.agents, agid) || continue
        nocc += model.agents[agid].occupied
    end
    return nocc
end

const DIRS = [(i,j) for i=-1:1, j=-1:1 if (i,j)!=(0,0)]

function nocc_neighbors2(ag, model)
    nocc = 0
    for d in DIRS
        nocc += occ_dir(ag, model, d)
    end
    return nocc
end

function occ_dir(ag, model, direction)
    pos = ag.pos
    depth = 0
    while depth < 100
        depth += 1
        pos = pos .+ direction
        isvalid_index(pos..., model.space.dimensions...) || return 0
        agid = Agents.coord2vertex(pos, model)
        haskey(model.agents, agid) || continue
        return model.agents[agid].occupied ? 1 : 0
    end
    return 0
end

isvalid_index(i, j, n, m) = 1 <= i <= n && 1<= j <= m


ac(x) = x.occupied ? :orange : :white
am(x) = x.occupied ? :circle : :square

function solve(part1=true; test=false, do_anim=false)
    f_nocc = part1 ? nocc_neighbors : nocc_neighbors2
    nmax = part1 ? 4 : 5
    layout = get_grid(test)
    model = build_model(layout, nmax=nmax)
    if do_anim
        anim = @animate for i in 0:100
            stop = model_step!(model, f_nocc) && break
            kwargs = (showaxis = false, aspect_ratio = 1, size = (850, 850))
            p1 = plotabm(model; ac = ac, as = 3, am = :square, kwargs...)
            title!(p1, "step $(i)")
            stop && break
        end
        gif(anim, "viz/day11_part$(part1 ? 1 : 2).gif", fps = 10)
    else
        while true
            model_step!(model, f_nocc) && break
        end
    end
    return sum(seat.occupied for seat in values(model.agents))
end

solve1(;test=false, do_anim=false) = solve(test=test, do_anim=do_anim)
solve2(;test=false, do_anim=false) = solve(false, test=test, do_anim=do_anim)
