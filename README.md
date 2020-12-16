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
│   1 │    1 │  34.144 μs │  45.31 KiB │
│   1 │    2 │ 162.430 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.277 ms │ 855.30 KiB │
│   2 │    2 │   1.031 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  54.396 μs │  63.97 KiB │
│   3 │    2 │ 115.886 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.403 ms │   1.15 MiB │
│   4 │    2 │   2.820 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 803.827 μs │ 700.89 KiB │
│   5 │    2 │ 855.197 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 573.277 μs │ 726.98 KiB │
│   6 │    2 │   1.816 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.222 ms │   3.43 MiB │
│   7 │    2 │   3.009 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 485.750 μs │ 395.48 KiB │
│   8 │    2 │   2.349 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 325.019 μs │ 537.77 KiB │
│   9 │    2 │ 326.935 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.086 μs │  21.81 KiB │
│  10 │    2 │  41.212 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  25.099 ms │ 144.19 KiB │
│  11 │    2 │  37.382 ms │ 144.19 KiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │ 210.515 μs │ 220.16 KiB │
│  12 │    2 │ 205.007 μs │ 216.97 KiB │
├─────┼──────┼────────────┼────────────┤
│  13 │    1 │   8.422 μs │  15.67 KiB │
│  13 │    2 │  30.052 μs │  15.36 KiB │
├─────┼──────┼────────────┼────────────┤
│  14 │    1 │ 421.150 μs │ 476.92 KiB │
│  14 │    2 │  37.963 ms │  32.09 MiB │
├─────┼──────┼────────────┼────────────┤
│  15 │    1 │  14.105 μs │  16.59 KiB │
│  15 │    2 │ 939.051 ms │ 228.88 MiB │
├─────┼──────┼────────────┼────────────┤
│  16 │    1 │   1.129 ms │ 662.52 KiB │
│  16 │    2 │   1.644 ms │   1.36 MiB │
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
