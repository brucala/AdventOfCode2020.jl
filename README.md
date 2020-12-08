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
│   1 │    1 │  36.010 μs │  45.31 KiB │
│   1 │    2 │ 161.645 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.321 ms │ 855.30 KiB │
│   2 │    2 │   1.043 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  51.877 μs │  63.97 KiB │
│   3 │    2 │ 108.424 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.414 ms │   1.15 MiB │
│   4 │    2 │   2.787 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 802.915 μs │ 700.89 KiB │
│   5 │    2 │ 853.682 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 581.316 μs │ 726.98 KiB │
│   6 │    2 │   1.829 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   6.492 ms │   2.95 MiB │
│   7 │    2 │   3.046 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │  18.026 ms │ 913.13 KiB │
│   8 │    2 │    1.974 s │  58.17 MiB │
└─────┴──────┴────────────┴────────────┘

```
