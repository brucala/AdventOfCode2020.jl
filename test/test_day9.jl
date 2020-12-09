using Test
using AdventOfCode2020.Day9
using AdventOfCode2020: read_input

nday = 9

data = read_input(nday)

test =
"""
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

@testset "Day$nday tests" begin
    @test solve1(test, 5) == 127
    @test solve2(test, 5) == 62
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 756008079
    @test solve2(data) == 93727241
end
