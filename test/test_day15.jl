module test_day15

using Test
using AdventOfCode2020.Day15
using AdventOfCode2020: read_input

nday = 15

data = read_input(nday)

test = "0,3,6"

@testset "Day$nday tests" begin
    @test solve1(test) == 436
    @test solve2(test) == 175594
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 929
    @test solve2(data) == 16671510
end

# AOCplot(data)

end  # module
