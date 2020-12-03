using Test
using AdventOfCode2020.Day2
using AdventOfCode2020: read_input

nday = 2

data = read_input(nday)

test =
"""
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 2
    @test solve2(test) == 1
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 628
    @test solve2(data) == 705
end
