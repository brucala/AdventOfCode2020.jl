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
│   1 │    1 │  37.650 μs │  45.31 KiB │
│   1 │    2 │ 164.164 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.277 ms │ 855.30 KiB │
│   2 │    2 │   1.034 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  52.472 μs │  63.97 KiB │
│   3 │    2 │ 108.283 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.402 ms │   1.15 MiB │
│   4 │    2 │   2.765 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 799.411 μs │ 700.89 KiB │
│   5 │    2 │ 851.192 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 570.209 μs │ 726.98 KiB │
│   6 │    2 │   1.813 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.244 ms │   3.43 MiB │
│   7 │    2 │   3.058 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 481.157 μs │ 395.48 KiB │
│   8 │    2 │   2.392 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 321.462 μs │ 537.77 KiB │
│   9 │    2 │ 328.265 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.194 μs │  21.81 KiB │
│  10 │    2 │  40.991 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  26.496 ms │ 144.19 KiB │
│  11 │    2 │  37.700 ms │ 144.19 KiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │ 207.304 μs │ 220.16 KiB │
│  12 │    2 │ 203.874 μs │ 216.97 KiB │
├─────┼──────┼────────────┼────────────┤
│  13 │    1 │   9.077 μs │  15.67 KiB │
│  13 │    2 │  29.748 μs │  15.36 KiB │
├─────┼──────┼────────────┼────────────┤
│  14 │    1 │ 415.138 μs │ 476.92 KiB │
│  14 │    2 │ 290.003 ms │  50.39 MiB │
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
