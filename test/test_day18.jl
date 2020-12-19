module test_day18

using Test
using AdventOfCode2020.Day18
using AdventOfCode2020: read_input

nday = 18

data = read_input(nday)

tests = [
("1 + 2 * 3 + 4 * 5 + 6", 71, 231)
("1 + (2 * 3) + (4 * (5 + 6))", 51, 51)
("2 * 3 + (4 * 5)", 26, 46)
("5 + (8 * 3 + 9 + 3 * 4 * 3)", 437, 1445)
("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", 12240, 669060)
("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2", 13632, 23340)
]

@testset "Day$nday tests" begin
    @testset for (x, y, z) in tests
        @test solve1(x) == y
        @test solve2(x) == z
        @test solve1_alt(x) == y
        @test solve2_alt(x) == z
    end
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 14208061823964
    @test solve2(data) == 320536571743074
    @test solve1_alt(data) == 14208061823964
    @test solve2_alt(data) == 320536571743074
end

end  # module
