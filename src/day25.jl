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
Base.iterate(p::Powers, state=(1, 1)) = (pow = state[2] * p.number % MOD; state[1] > p.count ? nothing : (pow, (state[1]+1, pow)))
Base.keys(p::Powers) = 1:length(p)
last(p) = first(Iterators.drop(p, length(p)-1))
#= Alternative to last: define indexing and lastindex
Base.lastindex(p::Powers) = length(p)
function Base.getindex(p::Powers, i::Int)
    for (n,pow) in enumerate(p)
        n == i && return pow
    end
end
=#

transform(subject_number, loop_size) = last(Powers(subject_number, loop_size))
find_loopsize(subject_number, pubkey) = findfirst(==(pubkey), Powers(subject_number))

function solve1(x)
    card_pubkey, door_pubkey = parse_input(x)
    card_loop_size = find_loopsize(7, card_pubkey)
    encryption_key = transform(door_pubkey, card_loop_size)
end

# Alternative solution
function transform_alt(subject_number, loop_size=MOD; find_size=-1)
    i = value = 1
    while i < loop_size && value != find_size
        value = (value * subject_number) % MOD
        i += 1
    end
    return value == find_size ? i : value
end
find_loopsize_alt(subject_number, pubkey) = transform_alt(subject_number; find_size=pubkey)

end  # module
