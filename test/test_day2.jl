using Test
using AdventOfCode2020
include("utils.jl")

nday = 2

day = getproperty(AdventOfCode2020, Symbol("Day$nday"))

data = read_input(nday)

test =
"""
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

@testset "Day$nday" begin
    @test day.solve1(test) == 2
    @test day.solve2(test) == 1
end

solutions(day, data)

#@time solve1(data)
#@time solve2(data)
