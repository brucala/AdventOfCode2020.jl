module test_day3

using Test
using AdventOfCode2020.Day3
using AdventOfCode2020: read_input

nday = 3

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

@testset "Day$nday tests" begin
    @test solve1(test) == 7
    @test solve2(test) == 336
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 151
    @test solve2(data) == 7540141059
end

end  # module
