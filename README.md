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
│   1 │    1 │  33.921 μs │  45.31 KiB │
│   1 │    2 │ 163.981 μs │   1.02 MiB │
├─────┼──────┼────────────┼────────────┤
│   2 │    1 │   1.269 ms │ 855.30 KiB │
│   2 │    2 │   1.025 ms │ 855.30 KiB │
├─────┼──────┼────────────┼────────────┤
│   3 │    1 │  53.453 μs │  63.97 KiB │
│   3 │    2 │ 108.149 μs │  64.25 KiB │
├─────┼──────┼────────────┼────────────┤
│   4 │    1 │   1.396 ms │   1.15 MiB │
│   4 │    2 │   2.800 ms │   1.83 MiB │
├─────┼──────┼────────────┼────────────┤
│   5 │    1 │ 805.882 μs │ 700.89 KiB │
│   5 │    2 │ 853.686 μs │ 770.46 KiB │
├─────┼──────┼────────────┼────────────┤
│   6 │    1 │ 573.185 μs │ 726.98 KiB │
│   6 │    2 │   1.811 ms │   1.61 MiB │
├─────┼──────┼────────────┼────────────┤
│   7 │    1 │   4.204 ms │   3.43 MiB │
│   7 │    2 │   2.986 ms │   2.03 MiB │
├─────┼──────┼────────────┼────────────┤
│   8 │    1 │ 482.044 μs │ 395.48 KiB │
│   8 │    2 │   2.347 ms │   3.53 MiB │
├─────┼──────┼────────────┼────────────┤
│   9 │    1 │ 331.544 μs │ 537.77 KiB │
│   9 │    2 │ 327.495 μs │ 538.08 KiB │
├─────┼──────┼────────────┼────────────┤
│  10 │    1 │  13.091 μs │  21.81 KiB │
│  10 │    2 │  41.253 μs │  42.00 KiB │
├─────┼──────┼────────────┼────────────┤
│  11 │    1 │  24.688 ms │ 144.19 KiB │
│  11 │    2 │  37.615 ms │ 144.19 KiB │
├─────┼──────┼────────────┼────────────┤
│  12 │    1 │ 207.040 μs │ 220.16 KiB │
│  12 │    2 │ 201.793 μs │ 216.97 KiB │
├─────┼──────┼────────────┼────────────┤
│  13 │    1 │   8.410 μs │  15.67 KiB │
│  13 │    2 │  31.717 μs │  15.36 KiB │
├─────┼──────┼────────────┼────────────┤
│  14 │    1 │ 418.547 μs │ 476.92 KiB │
│  14 │    2 │  38.331 ms │  32.09 MiB │
├─────┼──────┼────────────┼────────────┤
│  15 │    1 │  14.026 μs │  16.59 KiB │
│  15 │    2 │ 894.426 ms │ 228.88 MiB │
├─────┼──────┼────────────┼────────────┤
│  16 │    1 │   1.185 ms │ 819.77 KiB │
│  16 │    2 │   1.322 ms │   1.27 MiB │
├─────┼──────┼────────────┼────────────┤
│  17 │    1 │   1.761 ms │ 311.86 KiB │
│  17 │    2 │  55.382 ms │   2.70 MiB │
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
