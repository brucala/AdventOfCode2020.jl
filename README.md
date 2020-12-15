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
│   1 │    1 │  37.262 μs │  45.31 KiB │
│   1 │    2 │ 158.293 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.270 ms │ 855.30 KiB │
│   2 │    2 │   1.025 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  51.522 μs │  63.97 KiB │
│   3 │    2 │ 108.222 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.538 ms │   1.15 MiB │
│   4 │    2 │   3.018 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 804.611 μs │ 700.89 KiB │
│   5 │    2 │ 857.036 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 575.080 μs │ 726.98 KiB │
│   6 │    2 │   1.863 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.463 ms │   3.43 MiB │
│   7 │    2 │   3.159 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 481.155 μs │ 395.48 KiB │
│   8 │    2 │   2.358 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 338.056 μs │ 537.77 KiB │
│   9 │    2 │ 339.530 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.134 μs │  21.81 KiB │
│  10 │    2 │  42.947 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  24.678 ms │ 144.19 KiB │
│  11 │    2 │  37.069 ms │ 144.19 KiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │ 210.723 μs │ 220.16 KiB │
│  12 │    2 │ 205.710 μs │ 216.97 KiB │
├─────┼──────┼────────────┼────────────┤
│  13 │    1 │   8.491 μs │  15.67 KiB │
│  13 │    2 │  30.076 μs │  15.36 KiB │
├─────┼──────┼────────────┼────────────┤
│  14 │    1 │ 423.142 μs │ 476.92 KiB │
│  14 │    2 │  39.988 ms │  32.09 MiB │
├─────┼──────┼────────────┼────────────┤
│  15 │    1 │  44.442 μs │  24.53 KiB │
│  15 │    2 │    2.455 s │ 269.17 MiB │
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
