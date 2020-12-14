module test_day14

using Test
using AdventOfCode2020.Day14
using AdventOfCode2020: read_input

nday = 14

data = read_input(nday)

test =
"""
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""

test2 =
"""
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 165
    @test solve2(test2) == 208
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 4886706177792
    @test solve2(data) == 3348493585827
end

end  # module
