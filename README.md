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
│   1 │    1 │  35.134 μs │  45.31 KiB │
│   1 │    2 │ 163.652 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.268 ms │ 855.30 KiB │
│   2 │    2 │   1.023 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  52.574 μs │  63.97 KiB │
│   3 │    2 │ 111.148 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.399 ms │   1.15 MiB │
│   4 │    2 │   2.758 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 806.436 μs │ 700.89 KiB │
│   5 │    2 │ 858.540 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 570.923 μs │ 726.98 KiB │
│   6 │    2 │   1.817 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.189 ms │   3.43 MiB │
│   7 │    2 │   3.022 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 486.817 μs │ 395.48 KiB │
│   8 │    2 │   2.366 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 358.226 μs │ 537.77 KiB │
│   9 │    2 │ 359.024 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  12.964 μs │  21.81 KiB │
│  10 │    2 │  41.438 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  27.514 ms │ 144.19 KiB │
│  11 │    2 │  37.307 ms │ 144.19 KiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │ 207.297 μs │ 220.16 KiB │
│  12 │    2 │ 203.804 μs │ 216.97 KiB │
├─────┼──────┼────────────┼────────────┤
│  13 │    1 │   8.402 μs │  15.67 KiB │
│  13 │    2 │  29.884 μs │  15.36 KiB │
├─────┼──────┼────────────┼────────────┤
│  14 │    1 │ 418.544 μs │ 476.92 KiB │
│  14 │    2 │  37.960 ms │  32.09 MiB │
├─────┼──────┼────────────┼────────────┤
│  15 │    1 │  51.200 μs │  24.63 KiB │
│  15 │    2 │    2.455 s │ 269.17 MiB │
├─────┼──────┼────────────┼────────────┤
│  16 │    1 │   1.130 ms │ 662.52 KiB │
│  16 │    2 │   1.640 ms │   1.36 MiB │
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
