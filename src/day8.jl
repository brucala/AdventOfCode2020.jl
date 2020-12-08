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
    seen::Set{Int} = Set{Int}()
end
function Game(program::AbstractString)
    instructions = Instruction[]
    for ins = readlines(IOBuffer(program))
        push!(instructions, Instruction(ins))
    end
    Game(;instructions=instructions)
end
increase!(g::Game; Δi=1, Δacc=0) = g.i, g.accumulator = g.i+Δi, g.accumulator+Δacc

nins(g::Game) = length(g.instructions)
instruction(g::Game) = g.instructions[g.i]

already_seen(g::Game) = g.i in g.seen
finished(g::Game) = g.i == nins(g) + 1

function state(g::Game)
    already_seen(g) && return :infinite_loop
    finished(g) && return :terminated
    1<= g.i <= nins(g) && return :running
    return :error
end

acc!(g::Game, arg::Int) = increase!(g; Δacc=arg)
nop!(g::Game, arg::Int) = increase!(g)
jmp!(g::Game, arg::Int) = increase!(g; Δi=arg)
const f_ins! = Dict(:acc=>acc!, :nop=>nop!, :jmp=>jmp!)

function run_instruction!(g::Game)
    push!(g.seen, g.i)
    ins = instruction(g)
    f_ins![ins.operation](g, ins.argument)
end

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
        while state(game) == :running
            run_instruction!(game)
        end
        state(game) == :terminated && return game.accumulator
    end
    return "no terminated games"
end

end  # module
