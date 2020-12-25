module Day25
include("utils.jl")
using .Utils

export solve1

parse_input(x) = read_ints(x)

const MOD = 20201227

# Nice solution that to learn the use of the iterator interface
struct Powers
    number::Int
    count::Int
end
Powers(number) = Powers(number, MOD)
Base.length(p::Powers) = p.count
# faster iteration than using powermod -> faster find_loopsize
Base.iterate(p::Powers, state=(1, 1)) = (pow = state[2] * p.number % MOD; state[1] > p.count ? nothing : (pow, (state[1]+1, pow)))
Base.keys(p::Powers) = 1:length(p)
Base.lastindex(p::Powers) = length(p)
Base.getindex(p::Powers, i::Int) = powermod(p.number, i, MOD)
#= Alternative to lastindex and getinde: does the full iteration
last(p) = first(Iterators.drop(p, length(p)-1))
=#

transform(subject_number, loop_size) = last(Powers(subject_number, loop_size))
find_loopsize(subject_number, pubkey) = findfirst(==(pubkey), Powers(subject_number))

function solve1(x)
    card_pubkey, door_pubkey = parse_input(x)
    card_loop_size = find_loopsize(7, card_pubkey)
    encryption_key = transform(door_pubkey, card_loop_size)
end

# Alternative solution (few ms faster)
transform_alt(subject_number, loop_size=MOD) = powermod(subject_number, loop_size, MOD)
function find_loopsize_alt(subject_number, find_size)
    value = 1
    for i in 1:MOD
        value = (value * subject_number) % MOD
        value == find_size && return i
    end
end

function solve1_alt(x)
    card_pubkey, door_pubkey = parse_input(x)
    card_loop_size = find_loopsize_alt(7, card_pubkey)
    encryption_key = transform_alt(door_pubkey, card_loop_size)
end

end  # module
