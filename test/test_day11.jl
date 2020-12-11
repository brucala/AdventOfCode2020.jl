module test_day11

using Test
using AdventOfCode2020.Day11
using AdventOfCode2020: read_input

nday = 11

data = read_input(nday)

test =
"""
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 37
    @test solve2(test) == 26
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2183
    @test solve2(data) == 1990
end

end  # module
