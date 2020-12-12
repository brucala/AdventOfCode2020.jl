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
│   1 │    1 │  38.165 μs │  45.31 KiB │
│   1 │    2 │ 163.165 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.270 ms │ 855.30 KiB │
│   2 │    2 │   1.023 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  51.955 μs │  63.97 KiB │
│   3 │    2 │ 107.474 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.384 ms │   1.15 MiB │
│   4 │    2 │   2.772 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 803.501 μs │ 700.89 KiB │
│   5 │    2 │ 849.706 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 572.585 μs │ 726.98 KiB │
│   6 │    2 │   1.807 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.330 ms │   3.43 MiB │
│   7 │    2 │   3.002 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 481.817 μs │ 395.48 KiB │
│   8 │    2 │   2.391 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 321.646 μs │ 537.77 KiB │
│   9 │    2 │ 322.934 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.101 μs │  21.81 KiB │
│  10 │    2 │  41.772 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  27.523 ms │   2.89 MiB │
│  11 │    2 │ 159.709 ms │ 226.79 MiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │   2.620 ms │ 229.36 KiB │
│  12 │    2 │   1.788 ms │ 222.97 KiB │
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
