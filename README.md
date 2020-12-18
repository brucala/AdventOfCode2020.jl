# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

> Disclaimer: these solutions are created just as a way to practice and become more familiar
with the awesome Julia language. They are not optimized for efficiency or for code beauty.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    1 │  34.576 μs │  45.31 KiB │    217 │
│   1 │    2 │ 163.506 μs │   1.02 MiB │    781 │
├─────┼──────┼────────────┼────────────┼────────┤
│   2 │    1 │   1.278 ms │ 855.30 KiB │  12028 │
│   2 │    2 │   1.029 ms │ 855.30 KiB │  12028 │
├─────┼──────┼────────────┼────────────┼────────┤
│   3 │    1 │  52.198 μs │  63.97 KiB │    980 │
│   3 │    2 │ 115.989 μs │  64.25 KiB │    982 │
├─────┼──────┼────────────┼────────────┼────────┤
│   4 │    1 │   1.462 ms │   1.15 MiB │  13565 │
│   4 │    2 │   2.795 ms │   1.83 MiB │  24773 │
├─────┼──────┼────────────┼────────────┼────────┤
│   5 │    1 │ 803.216 μs │ 700.89 KiB │  12276 │
│   5 │    2 │ 850.661 μs │ 770.46 KiB │  12305 │
├─────┼──────┼────────────┼────────────┼────────┤
│   6 │    1 │ 569.874 μs │ 726.98 KiB │   6023 │
│   6 │    2 │   1.827 ms │   1.61 MiB │  18785 │
├─────┼──────┼────────────┼────────────┼────────┤
│   7 │    1 │   4.393 ms │   3.43 MiB │  46796 │
│   7 │    2 │   3.062 ms │   2.03 MiB │  29537 │
├─────┼──────┼────────────┼────────────┼────────┤
│   8 │    1 │ 485.182 μs │ 395.48 KiB │   6575 │
│   8 │    2 │   2.427 ms │   3.53 MiB │  28938 │
├─────┼──────┼────────────┼────────────┼────────┤
│   9 │    1 │ 322.973 μs │ 537.77 KiB │   4227 │
│   9 │    2 │ 326.692 μs │ 538.08 KiB │   4229 │
├─────┼──────┼────────────┼────────────┼────────┤
│  10 │    1 │  13.044 μs │  21.81 KiB │    308 │
│  10 │    2 │  41.464 μs │  42.00 KiB │    696 │
├─────┼──────┼────────────┼────────────┼────────┤
│  11 │    1 │  25.118 ms │ 144.19 KiB │    474 │
│  11 │    2 │  37.431 ms │ 144.19 KiB │    474 │
├─────┼──────┼────────────┼────────────┼────────┤
│  12 │    1 │ 206.947 μs │ 220.16 KiB │   3684 │
│  12 │    2 │ 201.143 μs │ 216.97 KiB │   3479 │
├─────┼──────┼────────────┼────────────┼────────┤
│  13 │    1 │   8.538 μs │  15.67 KiB │    162 │
│  13 │    2 │  30.704 μs │  15.36 KiB │    160 │
├─────┼──────┼────────────┼────────────┼────────┤
│  14 │    1 │ 420.460 μs │ 476.92 KiB │   6687 │
│  14 │    2 │  37.595 ms │  32.09 MiB │ 812635 │
├─────┼──────┼────────────┼────────────┼────────┤
│  15 │    1 │  14.184 μs │  16.59 KiB │      7 │
│  15 │    2 │ 884.353 ms │ 228.88 MiB │      8 │
├─────┼──────┼────────────┼────────────┼────────┤
│  16 │    1 │ 824.883 μs │ 567.34 KiB │   2921 │
│  16 │    2 │   1.324 ms │   1.27 MiB │   5427 │
├─────┼──────┼────────────┼────────────┼────────┤
│  17 │    1 │   1.772 ms │ 310.77 KiB │   4500 │
│  17 │    2 │  54.857 ms │   2.70 MiB │  32084 │
├─────┼──────┼────────────┼────────────┼────────┤
│  18 │    1 │   1.978 ms │ 641.61 KiB │  13334 │
│  18 │    2 │   2.031 ms │ 694.20 KiB │  14424 │
└─────┴──────┴────────────┴────────────┴────────┘

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
