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
    card1, card2 = popfirst!.((decks))
    @assert card1 != card2
    card1 > card2 ? push!(decks[1], card1, card2) : push!(decks[2], card2, card1)
end

const SetOfDecks = Set{Tuple{Vector{Int}, Vector{Int}}}

function recursive_combat!(deck1, deck2)
    #println("*** new game")
    seen=SetOfDecks()
    #@show seen
    #while true
    for i in 1:1000
        #(deck1, deck2) ∈ seen && println("=== game seen ", (deck1, deck2))
        #(deck1, deck2) ∈ seen && println("=== score: ", score(deck1))
        (deck1, deck2) ∈ seen && return 1
        push!(seen, deepcopy.((deck1, deck2)))
        #println("+ round $i")
        #@show deck1, deck2
        player1_wins = recursive_round!((deck1, deck2))
        #@show player1_wins, deck1, deck2
        #(isempty(deck1) || isempty(deck2)) && println("--- game end: ", deck1, " ", deck2)
        isempty(deck1) && return 2
        isempty(deck2) && return 1
    end
end

function recursive_round!(decks)
    cards = popfirst!.(decks)
    left = length.(decks)
    card1, card2 = cards
    if all(left .≥ cards)
        subdecks = deepcopy.(deck[1:n] for (deck, n) in zip(decks, cards))  # slice is a copy
        #println("entering sub-game")
        #@show decks
        #@show subdecks
        player1_wins = recursive_combat!(subdecks...) == 1
        #@show decks
        #println("player 1 wins subgame? ", player1_wins)
    else
        @assert cards[1] != cards[2]
        player1_wins = cards[1] > cards[2]
    end
    player1_wins ? push!(decks[1], card1, card2) : push!(decks[2], card2, card1)
    return player1_wins
end

function solve(x, game)
    decks = parse_input(x)
    win_deck = decks[game(decks...)]
    @show win_deck
    @assert length(win_deck) == length(Set(win_deck))
    @assert Set(win_deck) == Set([decks[1]; decks[2]])
    return score(win_deck)
end

solve1(x) = solve(x, combat!)
solve2(x) = solve(x, recursive_combat!)

end  # module
