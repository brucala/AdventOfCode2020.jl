using Test
using AdventOfCode2020.Day6
using AdventOfCode2020: read_input

nday = 6

data = read_input(nday)

test =
"""
abc

a
b
c

ab
ac

a
a
a
a

b
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 11
    @test solve2(test) == 6
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 6686
    @test solve2(data) == 3476
end
