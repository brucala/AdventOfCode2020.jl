module test_day21

using Test
using AdventOfCode2020.Day21
using AdventOfCode2020: read_input

nday = 21

data = read_input(nday)

test =
"""
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 5
    @test solve2(test) == "mxmxvkd,sqjhc,fvjkl"
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2211
    @test solve2(data) == "vv,nlxsmb,rnbhjk,bvnkk,ttxvphb,qmkz,trmzkcfg,jpvz"
end

end  # module
