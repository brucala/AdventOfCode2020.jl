using Test
using AdventOfCode2020

@testset "AdventOfCode2020 tests" begin
     for day in solved_days
        @testset "Day $day" begin include("test_day$day.jl") end
     end
end
