module test_day13

using Test
using AdventOfCode2020.Day13
using AdventOfCode2020: read_input

nday = 13

data = read_input(nday)

test =
"""
939
7,13,x,x,59,x,31,19
"""

other_tests = ["1\n17,x,13,19", "1\n67,7,59,61", "1\n67,x,7,59,61", "1\n67,7,x,59,61", "1\n1789,37,47,1889"]
expected = [3417, 754018, 779210, 1261476, 1202161486]

@testset "Day$nday tests" begin
    @test solve1(test) == 5 * 59
    @test solve2(test) == 1068781
    @test solve2.(other_tests) == expected
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 3966
    @test solve2(data) == 800177252346225
end

end  # module
