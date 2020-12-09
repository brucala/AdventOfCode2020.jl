module test_day7

using Test
using AdventOfCode2020.Day7
using AdventOfCode2020: read_input

nday = 7

data = read_input(nday)

test =
"""
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

test2 =
"""
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
"""

@testset "Day$nday tests" begin
    @test solve1(test) == 4
    @test solve2(test) == 32
    @test solve2(test2) == 126
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 259
    @test solve2(data) == 45018
end

end  # module
