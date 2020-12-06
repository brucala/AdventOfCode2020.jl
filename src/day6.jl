module Day6

export solve1, solve2

function solve1(x)
    groups = split(x, "\n\n")
    setdiff.(Set.(groups), '\n') .|> length |> sum
end

function solve2(x)
    groups = split(x, "\n\n")
    [intersect(Set.(split(g))...) for g in groups] .|> length |> sum
end

end  # module
