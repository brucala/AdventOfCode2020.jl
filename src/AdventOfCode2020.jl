module AdventOfCode2020

export solved_days

solved_days = 1:2

for day = solved_days
    include("day$day.jl")
end

end # module
