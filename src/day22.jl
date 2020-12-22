module Day22

export solve1, solve2

parse_input(input) = split(input, "\n\n") .|> parse_deck
parse_deck(deck) = split(rstrip(deck), '\n')[2:end] .|> toint
toint(x) = parse(Int, x)

score(deck) = deck .* collect(length(deck):-1:1) |> sum
function combat!(deck1, deck2)
    while true
        round!((deck1, deck2))
        isempty(deck1) && return 2
        isempty(deck2) && return 1
    end
end
function round!(decks)
    cards = popfirst!.(decks)
    #@assert cards[1] != cards[2] # not necessary cause all cards are different
    cards[1] > cards[2] ? append!(decks[1], cards) : append!(decks[2], reverse(cards))
end

const SetOfDecks = Set{Tuple{Vector{Int}, Vector{Int}}}

function recursive_combat!(deck1, deck2)
    seen=SetOfDecks()
    winner = 0
    while !(isempty(deck1) || isempty(deck2))
        (deck1, deck2) ∈ seen && return 1
        push!(seen, deepcopy.((deck1, deck2)))
        winner = recursive_round!((deck1, deck2))
    end
    return winner
end

function recursive_round!(decks)
    cards = popfirst!.(decks)
    left = length.(decks)
    if all(left .≥ cards)
        subdecks = Tuple(deck[1:n] for (deck, n) in zip(decks, cards))  # slice is a copy
        winner = recursive_combat!(subdecks...)
    else
        #@assert cards[1] != cards[2] # not necessary cause all cards are different
        winner = cards[1] > cards[2] ? 1 : 2
    end
    winner == 1 ? append!(decks[1], cards) : append!(decks[2], reverse(cards))
    return winner
end

function solve(x, game!)
    decks = parse_input(x)
    win_deck = decks[game!(decks...)]
    return score(win_deck)
end

solve1(x) = solve(x, combat!)
solve2(x) = solve(x, recursive_combat!)

end  # module
