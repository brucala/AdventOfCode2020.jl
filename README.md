# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

> Disclaimer: these solutions are created just as a way to practice and become more familiar
with the awesome Julia language. They are not optimized for efficiency or for code beauty.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌──────┬───────┬───────────────────┐
│  day │  part │         benchmark │
├──────┼───────┼───────────────────┤
│ Day1 │ part1 │  Trial(35.440 μs) │
│ Day1 │ part2 │ Trial(163.738 μs) │
│ Day2 │ part1 │   Trial(1.308 ms) │
│ Day2 │ part2 │   Trial(1.062 ms) │
│ Day3 │ part1 │  Trial(52.230 μs) │
│ Day3 │ part2 │ Trial(108.462 μs) │
│ Day4 │ part1 │   Trial(1.399 ms) │
│ Day4 │ part2 │   Trial(2.872 ms) │
│ Day5 │ part1 │ Trial(797.508 μs) │
│ Day5 │ part2 │ Trial(846.653 μs) │
│ Day6 │ part1 │ Trial(570.773 μs) │
│ Day6 │ part2 │   Trial(1.807 ms) │
│ Day7 │ part1 │  Trial(17.430 ms) │
│ Day7 │ part2 │   Trial(3.003 ms) │
└──────┴───────┴───────────────────┘

```
