using Test
using AdventOfCode2020
include("utils.jl")

nday = 1

day = getproperty(AdventOfCode2020, Symbol("Day$nday"))

data = read_input(nday)

test = """
1721
979
366
299
675
1456"""


@testset "Day$nday" begin
    @test day.solve1(test) == 514579
    @test day.solve2(test) == 241861950
end

solutions(day, data)

#@time solve1(data)
#@time solve2(data)
