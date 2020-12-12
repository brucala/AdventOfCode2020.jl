module test_day12

using Test
using AdventOfCode2020.Day12
using AdventOfCode2020: read_input

nday = 12

data = read_input(nday)

test =
"""
F10
N3
F7
R90
F11
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 25
    @test solve2(test) == 286
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 441
    @test solve2(data) == 40014
end

end  # module
