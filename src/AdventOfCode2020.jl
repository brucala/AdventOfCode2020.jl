module AdventOfCode2020

export solved_days, read_input

solved_days = 1:25

for day = solved_days
    include("day$day.jl")
end

function read_input(file::AbstractString)
    paths = ["data/" "../data/"]
    for filepath in joinpath.(paths, file)
        if isfile(filepath)
            return readchomp(filepath) |> String
        end
    end
    error("input $file not found in $paths")
end
read_input(nday::Int) = read_input("input$nday.txt")

end # module
