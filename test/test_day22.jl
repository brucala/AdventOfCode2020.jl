module test_day22

using Test
using AdventOfCode2020.Day22

nday = 22

data = parse_input(nday)

test = parse_input(
"""
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 306
    @test solve2(test) == 291
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 33694
    @test solve2(data) == 31835
end

end  # module
