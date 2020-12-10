module test_day10

using Test
using AdventOfCode2020.Day10
using AdventOfCode2020: read_input

nday = 10

data = read_input(nday)

test =
"""
16
10
15
5
1
11
7
19
6
12
4
"""

test2 =
"""
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""


@testset "Day$nday tests" begin
    @test solve1(test) == 7*5
    @test solve1(test2) == 22*10
    @test solve2(test) == 8
    @test solve2(test2) == 19208
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 2059
    @test solve2(data) == 86812553324672
end

end  # module
