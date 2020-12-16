module test_day16

using Test
using AdventOfCode2020.Day16
using AdventOfCode2020: read_input

nday = 16

data = read_input(nday)

test =
"""
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
"""

test2 =
"""
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 71
    @test solve2(test2)[2] == Dict("class" => 12, "row" => 11, "seat" => 13)
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 18227
    @test solve2(data)[1] == 2355350878831
end

end  # module
