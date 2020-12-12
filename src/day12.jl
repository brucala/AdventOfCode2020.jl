module Day12

export solve1, solve2

@enum Direction E S W N

Direction(d::Char) = eval(Symbol(d))
Base.:(+)(d::Direction, n::Int) = Direction((Int(d) + n) % 4)

turn(d::Direction, angle::Int) = d + (angle ÷ 90)
turn(d::Direction, angle::Int, right::Bool) = turn(d, right ? angle : 360 - angle)

move(d::Direction, n::Int, pos::Tuple{Int, Int}) = move(Val(d), n, pos...)
move(::Val{E}, n::Int, x::Int, y::Int) = (x + n, y    )
move(::Val{W}, n::Int, x::Int, y::Int) = (x - n, y    )
move(::Val{N}, n::Int, x::Int, y::Int) = (x    , y + n)
move(::Val{S}, n::Int, x::Int, y::Int) = (x    , y - n)

# Part's 1 ship
Base.@kwdef mutable struct Ship
    position::Tuple{Int, Int} = (0, 0)
    direction::Direction = E
end

turn!(s::Ship, angle::Int, right::Bool) = s.direction = turn(s.direction, angle, right)
move!(s::Ship, d::Direction, n::Int) = s.position = move(d, n, s.position)

function step!(s::Ship, ins::Char, n::Int)
    if ins in ('L', 'R')
        turn!(s, n, ins=='R')
    else
        direction = ins == 'F' ? s.direction : Direction(ins)
        move!(s, direction, n)
    end
end

# Part's 2 ship
Base.@kwdef mutable struct Ship2
    position::Tuple{Int, Int} = (0, 0)
    waypoint::Tuple{Int, Int} = (10, 1)
end

forward!(s::Ship2, n::Int) = s.position = s.position .+ n .* s.waypoint
move!(s::Ship2, d::Direction, n::Int) = s.waypoint = move(d, n, s.waypoint)
turn!(s::Ship2, angle::Int, right::Bool) = s.waypoint = turn(s.waypoint, angle, right)

function turn(position::Tuple{Int, Int}, angle::Int, right::Bool)
    x, y = position
    angle == 180 && return -x, -y
    if !right
        angle = angle == 90 ? 270 : 90
    end
    return angle == 90 ? (y, -x) : (-y, x)
end

function get_instructions(x)
    instructions = Vector{Tuple{Char, Int}}()
    for line = readlines(IOBuffer(x))
        ins = (line[1], parse(Int, line[2:end]))
        push!(instructions, ins)
    end
    return instructions
end

function step!(s::Ship2, ins::Char, n::Int)
    if ins in ('L', 'R')
        turn!(s, n, ins=='R')
    elseif ins == 'F'
        forward!(s, n)
    else
        move!(s, Direction(ins), n)
    end
end

function solve(x, part1::Bool)
    instructions = get_instructions(x)
    ship = part1 ? Ship() : Ship2()
    for (ins, n) in instructions
        step!(ship, ins, n)
    end
    return sum(abs.(ship.position))
end

solve1(x) = solve(x, true)
solve2(x) = solve(x, false)

end  # module
