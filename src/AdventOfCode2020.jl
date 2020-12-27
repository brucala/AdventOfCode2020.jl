module AdventOfCode2020

solved_days = 1:25

for day = solved_days
    include("day$day.jl")
end

include("utils.jl")
import .Utils: read_input

export solved_days, read_input

end # module
