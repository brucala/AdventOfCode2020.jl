module Day23
include("utils.jl")
using .Utils

export solve1, solve2

minus1(n, N) = (N+n-2) % N + 1
plus1(n, N) = n % N + 1

mutable struct Cup
    label::Int
    next::Cup
    Cup(n, c) = new(n, c)
    Cup(n) = (x = new(n); x.next = x)
end
label(c::Cup) = c.label

Base.IteratorSize(::Cup) = Base.IsInfinite()
Base.iterate(cup::Cup, state=cup) = (state, state.next)
Base.show(io::IO, c::Cup) = print(io, join(label.(Iterators.take(c, 9)), " -> "), "...")

function arrange_cups(x::Vector{Int}, N)
    n = length(x)
    last_cup = Cup(x[end])
    cups = Vector{Cup}(undef, max(n, N))
    cups[x[end]] = last_cup
    for i in n-1:-1:1
        cups[x[i]] = Cup(x[i], cups[x[i+1]])
    end
    first_cup = cups[x[1]]
    last_cup.next = first_cup

    N ≤ n && return cups

    cups[N] = Cup(N, first_cup)
    for i in N-1:-1:n+1
        cups[i] = Cup(i, cups[i+1])
    end
    last_cup.next = cups[n+1]
    return cups
end

function move!(cups::Vector{Cup}, cup::Cup)
    N = length(cups)
    current_label = label(cup)
    tomove = collect(Iterators.take(cup.next, 3))
    tomove_labels = label.(tomove)
    destination = minus1(current_label, N)
    while destination ∈ tomove_labels
        destination = minus1(destination, N)
    end
    cup.next = tomove[end].next
    tomove[end].next = cups[destination].next
    cups[destination].next = tomove[1]
    return cup.next
end

sol1(cups::Vector{Cup}) = label.(Iterators.take(cups[1].next, 8)) |> join |> toint
sol2(cups::Vector{Cup}) = prod(label.(Iterators.take(cups[1].next, 2)))

function parse_input(x)
    collect(x) .|> toint
end


function solve(x, nmoves, ncups, fsol)
    labels = parse_input(x)
    cups = arrange_cups(labels, ncups)
    cup = cups[labels[1]]
    for i in 1:nmoves
        cup = move!(cups, cup)
    end
    #return cups
    return fsol(cups)
end

solve1(x, nmoves=100) = solve(x, nmoves, 0, sol1)
solve2(x) = solve(x, 10_000_000, 1_000_000, sol2)

end  # module
