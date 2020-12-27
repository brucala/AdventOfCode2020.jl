module test_day23

using Test
using AdventOfCode2020.Day23

nday = 23

data = parse_input(nday)

test = "389125467" |> parse_input

@testset "Day$nday tests" begin
    @test solve1(test, 10) == 92658374
    @test solve1(test) == 67384529
    @test solve2(test) == 149245887792
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 24987653
    @test solve2(data) == 442938711161
end

end  # module
