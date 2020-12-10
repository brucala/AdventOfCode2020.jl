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
│   1 │    1 │  35.788 μs │  45.31 KiB │
│   1 │    2 │ 156.792 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.275 ms │ 855.30 KiB │
│   2 │    2 │   1.021 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  51.771 μs │  63.97 KiB │
│   3 │    2 │ 108.174 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.391 ms │   1.15 MiB │
│   4 │    2 │   2.749 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 803.913 μs │ 700.89 KiB │
│   5 │    2 │ 852.364 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 572.455 μs │ 726.98 KiB │
│   6 │    2 │   1.818 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   6.506 ms │   2.95 MiB │
│   7 │    2 │   2.990 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 485.089 μs │ 395.48 KiB │
│   8 │    2 │   2.347 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 326.084 μs │ 537.77 KiB │
│   9 │    2 │ 327.076 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.147 μs │  21.81 KiB │
│  10 │    2 │  41.019 μs │  42.00 KiB │
└─────┴──────┴────────────┴────────────┘

```

## Other CLI tools

To generate (src and test) templates for a given day:
```
$ julia cli/generate_day.jl -h
usage: generate_day.jl [-h] nday

positional arguments:
  nday        day number for files to be generated

optional arguments:
  -h, --help  show this help message and exit
```

To download the input data of a given day:
```
$ julia cli/get_input.jl -h
usage: get_input.jl [-d DAY] [-h]

optional arguments:
  -d, --day DAY  day number for the input to be downloaded. If not
                 given take today's input (type: Int64)
  -h, --help     show this help message and exit
```
