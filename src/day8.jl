module Day8

export solve1, solve2

struct Instruction
    operation::Symbol
    argument::Int
end
Instruction(ins::AbstractString) = Instruction(split(ins)...)
Instruction(op::AbstractString, arg::AbstractString) = Instruction(Symbol(op), parse(Int, arg))


Base.@kwdef mutable struct Game
    instructions::Vector{Instruction}
    i::Int = 1
    accumulator::Int = 0
    seen::Vector{Int} = Int[]
end
function Game(program::AbstractString)
    instructions = Instruction[]
    for ins = readlines(IOBuffer(program))
        push!(instructions, Instruction(ins))
    end
    Game(;instructions=instructions)
end

nins(g::Game) = length(g.instructions)
instruction(g::Game) = g.instructions[g.i]

already_seen(g::Game) = g.i in g.seen
finished(g::Game) = g.i == nins(g) + 1

function check_state(g::Game)
    already_seen(g) && return :infinite_loop
    finished(g) && return :terminated
    1<= g.i <= nins(g) && return :running
    return :error
end

function run_instruction!(g::Game)
    push!(g.seen, g.i)
    ins = instruction(g)
    @eval $(ins.operation)($g, $ins.argument)
end

function acc(g::Game, arg)
    g.accumulator += arg
    g.i += 1
end
nop(g::Game, arg) = g.i += 1
jmp(g::Game, arg) = g.i += arg

function solve1(x)
    game = Game(x)
    while !already_seen(game)
        run_instruction!(game)
    end
    return game.accumulator
end

function change_games(g::Game)
    games = Game[]
    return (swap(g,i) for i in 1:nins(g) if g.instructions[i].operation != :acc)
end

function swap(g::Game, i)
    instructions = copy(g.instructions)
    ins = instructions[i]
    op_map = Dict(:nop=>:jmp, :jmp=>:nop)
    new_op = op_map[ins.operation]
    new_ins = Instruction(new_op, ins.argument)
    instructions[i] = new_ins
    return Game(;instructions=instructions)
end

function solve2(x)
    games = change_games(Game(x))
    for (i, game) in enumerate(games)
        while check_state(game) == :running
            run_instruction!(game)
        end
        check_state(game) == :terminated && return game.accumulator
    end
    return "no terminated games"
end

end  # module
