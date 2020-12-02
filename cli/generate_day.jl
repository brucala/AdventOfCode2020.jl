using ArgParse, Formatting

const day_template = FormatExpr(
"""
module Day{}

export solve1
#export solve2

function solve1(x)
end
function solve2(x)
end

end  # module
"""
)

const test_template = FormatExpr(
"""
using Test
using AdventOfCode2020
include("utils.jl")

nday = {}

day = getproperty(AdventOfCode2020, Symbol("Day\$nday"))

data = read_input(nday)

test =
\"\"\"
\"\"\"

@testset "Day\$nday" begin
    @test day.solve1(test) == ?
    #@test day.solve2(test) == ?
end

solutions(day, data)

#@time solve1(data)
#@time solve2(data)
"""
)

function generate_files(nday)
    day_file = open("src/day$nday.jl", "w")
    printfmt(day_file, day_template, nday)
    close(day_file)
    println("file $(day_file.name) generated")

    test_file = open("test/test_day$nday.jl", "w")
    printfmt(test_file, test_template, nday)
    close(test_file)
    println("file $(test_file.name) generated")
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "nday"
            help = "day number for files to be generated"
            required = true
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()

    nday = parsed_args["nday"]
    generate_files(nday)
end

main()
