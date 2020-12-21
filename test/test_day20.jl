module test_day20

using Test
using AdventOfCode2020.Day20
using AdventOfCode2020: read_input

nday = 20

data = read_input(nday)
test = read_input("test_day$nday.txt")

@testset "Day$nday minimum overlap checks" begin
    @test Day20.check(test)
    @test Day20.check(data)
end

@testset "Day$nday tests" begin
    @test solve1(test) == 20899048083289
    @test solve2(test) == 273
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 84116744709593
    @test solve2(data) == 1957
end

end  # module
