module test_day1

using Test
using AdventOfCode2020.Day1
using AdventOfCode2020: read_input

nday = 1

data = read_input(nday)

test = """
1721
979
366
299
675
1456"""


@testset "Day$nday" begin
    @test solve1(test) == 514579
    @test solve2(test) == 241861950
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 440979
    @test solve2(data) == 82498112
end

end  # module
