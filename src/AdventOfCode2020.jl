module AdventOfCode2020

export solved_days, read_input

solved_days = 1:6

for day = solved_days
    include("day$day.jl")
end

function read_input(nday)
    file = "input$nday.txt"
    paths = ["data/" "../data/"]
    for filepath in joinpath.(paths, file)
        if isfile(filepath)
            return readchomp(filepath) |> String
        end
    end
    error("input $file not found in $paths")
end

end # module
