using Test
using AdventOfCode2020
include("utils.jl")

nday = 3

day = getproperty(AdventOfCode2020, Symbol("Day$nday"))

data = read_input(nday)

test =
"""
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

@testset "Day$nday" begin
    @test day.solve1(test) == 7
    @test day.solve2(test) == 336
end

solutions(day, data)

#@time solve1(data)
#@time solve2(data)
