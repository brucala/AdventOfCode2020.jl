module Day25
include("utils.jl")
using .Utils

export solve1

parse_input(x) = read_ints(x)

function transform(subject_number, loop_size=20201227; find_size=-1)
    i = value = 1
    while i < loop_size && value != find_size
        value = (value * subject_number) % 20201227
        i += 1
    end
    return value == find_size ? i : value
end

function solve1(x)
    card_pubkey, door_pubkey = parse_input(x)
    card_loop_size = transform(7; find_size=card_pubkey)
    encryption_key = transform(door_pubkey, card_loop_size)
end

end  # module
