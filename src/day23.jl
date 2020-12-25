module Day23
include("utils.jl")
using .Utils

export solve1, solve2

minus1(n, N) = n > 1 ? n - 1 : N
plus1(n, N) = n < N ? n + 1 : 1

function parse_input(x)
    collect(x) .|> toint
end

function arrange_cups(labels)
    N = length(labels)
    # index is the cup label, value is the label of the next cup
    cups = Vector{Int32}(undef, N)
    for i in 1:N
        cups[labels[i]] = labels[plus1(i, N)]
    end
    return cups
end
function arrange_cups(labels, ncups)
    N = length(labels)
    cups = arrange_cups(labels)

    ncups ≤ N && return cups

    cups[labels[end]] = N + 1
    for i in N+1:ncups
        push!(cups, i + 1)
    end
    cups[ncups] = labels[1]

    return cups
end

function move!(cups, current)
    N = length(cups)
    pick1 = cups[current]
    pick2 = cups[pick1]
    pick3 = cups[pick2]
    destination = minus1(current, N)
    while destination ∈ (pick1, pick2, pick3)
        destination = minus1(destination, N)
    end
    cups[current] = cups[pick3]
    cups[pick3] = cups[destination]
    cups[destination] = pick1
    return cups[current]
end

function sol1(cups)
    cup, sol = 1, ""
    for _ in 1:8
        cup = cups[cup]
        sol *= string(cup)
    end
    return toint(sol)
end

sol2(cups) = Int64(cups[1]) * cups[cups[1]]

function solve(x, nmoves, ncups, fsol)
    labels = parse_input(x)
    cups = arrange_cups(labels, ncups)
    current = labels[1]
    for i in 1:nmoves
        current = move!(cups, current)
    end
    return fsol(cups)
end

solve1(x, nmoves=100) = solve(x, nmoves, 0, sol1)
solve2(x) = solve(x, 10_000_000, 1_000_000, sol2)

############################
# My first solution below
# nice to learn self-referencial types in Julia, however I couldn't make it sub-second
# from @profview apparently getproperty was taking an unfair share of time
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

function arrange_cups_alt(x::Vector{Int}, N)
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
    # way faster than Iterators.take
    pick1 = cup.next
    pick2 = pick1.next
    pick3 = pick2.next
    tomove_labels = pick1.label, pick2.label, pick3.label
    destination = minus1(current_label, N)
    while destination ∈ tomove_labels
        destination = minus1(destination, N)
    end
    cup_next = pick3.next
    cup.next = cup_next
    pick3.next = cups[destination].next
    cups[destination].next = pick1
    return cup_next
end

sol1(cups::Vector{Cup}) = label.(Iterators.take(cups[1].next, 8)) |> join |> toint
sol2(cups::Vector{Cup}) = cups[1].next.label * cups[1].next.next.label

function solve_alt(x, nmoves, ncups, fsol)
    labels = parse_input(x)
    cups = arrange_cups_alt(labels, ncups)
    current = cups[labels[1]]
    for i in 1:nmoves
        current = move!(cups, current)
    end
    return fsol(cups)
end

solve1_alt(x, nmoves=100) = solve_alt(x, nmoves, 0, sol1)
solve2_alt(x) = solve_alt(x, 10_000_000, 1_000_000, sol2)

end  # module
