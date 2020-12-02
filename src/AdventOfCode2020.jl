module AdventOfCode2020

export solved_days, generate_files

solved_days = 1:2

for day = solved_days
    include("day$day.jl")
end

include("generate_day.jl")

end # module
