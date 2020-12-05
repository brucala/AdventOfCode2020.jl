using Test
using AdventOfCode2020.Day5
using AdventOfCode2020: read_input

nday = 5

data = read_input(nday)

test =
"""
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
"""

@testset "Day$nday tests" begin
    @test Day5.extractID.(split(test)) == [357, 567, 119, 820]
    @test solve1(test) == 820
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 930
    @test solve2(data) == [515]
end
