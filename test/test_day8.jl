module test_day8

using Test
using AdventOfCode2020.Day8
using AdventOfCode2020: read_input

nday = 8

data = read_input(nday)

test =
"""
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 5
    @test solve2(test) == 8
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1475
    @test solve2(data) == 1270
end

end  # module
