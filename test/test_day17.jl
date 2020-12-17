module test_day17

using Test
using AdventOfCode2020.Day17
using AdventOfCode2020: read_input

nday = 17

data = read_input(nday)

test =
"""
.#.
..#
###"""

@testset "Day$nday tests" begin
    @test solve1(test) == 112
    @test solve2(test) == 848
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 322
    @test solve2(data) == 2000
end

end  # module
