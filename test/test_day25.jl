module test_day25

using Test
using AdventOfCode2020.Day25

nday = 25

data = parse_input(nday)

test = parse_input(
"""
5764801
17807724
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == 14897079
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 18433997
end

end  # module
