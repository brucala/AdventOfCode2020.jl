# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

> Disclaimer: these solutions are created just as a way to practice and become more familiar
with the awesome Julia language. They are not optimized for efficiency or for code beauty.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┐
│ day │ part │       time │     memory │
├─────┼──────┼────────────┼────────────┤
│   1 │    1 │  37.719 μs │  45.31 KiB │
│   1 │    2 │ 163.394 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.285 ms │ 855.30 KiB │
│   2 │    2 │   1.033 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  53.683 μs │  63.97 KiB │
│   3 │    2 │ 108.608 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.391 ms │   1.15 MiB │
│   4 │    2 │   2.806 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 798.508 μs │ 700.89 KiB │
│   5 │    2 │ 851.281 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 571.528 μs │ 726.98 KiB │
│   6 │    2 │   1.809 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   6.625 ms │   2.95 MiB │
│   7 │    2 │   3.019 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 483.387 μs │ 395.48 KiB │
│   8 │    2 │   2.438 ms │   3.53 MiB │
└─────┴──────┴────────────┴────────────┘

```
