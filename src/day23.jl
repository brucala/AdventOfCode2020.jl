module Day23
include("utils.jl")
using .Utils

export solve1, solve2

popfirstN!(x, n) = Tuple(popfirst!(x) for i in 1:n)

minus1(n, N) = (N+n-2) % N + 1
plus1(n, N) = n % N + 1

function move!(x, N)
    current, next = popfirst!(x), popfirstN!(x, 3)
    destination = minus1(current, N)
    while destination ∈ next
        destination = minus1(destination, N)
    end
    idestination = plus1(find(x, destination), N)
    splice!(x, idestination:idestination-1, next)
    push!(x, current)
end

function parse_input(x)
    collect(x) .|> toint
end

function sol(x)
    i = find(x, 1)
    return join([x[i+1:end]; x[1:i-1]]) |> toint
end

function sol2(x)
    i = find(x, 1)
    return x[i+1] * x[i+2]
end

function solve1(x, n=100)
    cups = parse_input(x)
    N = length(cups)
    for i in 1:n
        move!(cups, N)
    end
    return sol(cups)
end

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

sol(cups::Vector{Cup}) = label.(Iterators.take(cups[1].next, 8)) |> join |> toint
sol2(cups::Vector{Cup}) = prod(label.(Iterators.take(cups[1].next, 2)))

function solve2(x, nmoves=10_000_000, ncups=1_000_000)
    labels = parse_input(x)
    cups = arrange_cups(labels, ncups)
    cup = cups[labels[1]]
    for i in 1:nmoves
        cup = move!(cups, cup)
    end
    #return cups
    return sol2(cups)
end

end  # module
