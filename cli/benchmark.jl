using AdventOfCode2020
using BenchmarkTools
using PrettyTables
using ArgParse, Formatting

function available_solvers(day_module::Module)
    solve_methods = [:solve1, :solve2]
    sols = [getfield(day_module, sol) for sol in solve_methods if sol in names(day_module)]
    isempty(sols) && error("No solve method found in module $day_module")
    return sols
end

getpart(sol::Function) = "part$(string(sol)[end])"
getday(day_module::Module) = split(string(day_module), '.')[end] |> String

function benchmark(day_module::Module, data)
    sols = available_solvers(day_module)
    benchmarks = NamedTuple[]
    for sol in sols
        d, p = getday(day_module), getpart(sol)
        b = @benchmark $sol($data) seconds=0.5 samples=1000
        nsamples = length(b.times)
        nsamples <= 200 && @warn "low number of samples ($nsamples) run for benchmarking $d $p"
        push!(benchmarks, (day=d, part=p, benchmark=b))
    end
    return benchmarks
end

const readme_template = FormatExpr(
"""
# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

## Benchmarks

{}
"""
)

function benchmark()
    benchmarks = NamedTuple[]
    for nday in solved_days
        day = getproperty(AdventOfCode2020, Symbol("Day$nday"))
        data = read_input(nday)
        append!(benchmarks, benchmark(day, data))
    end

    # TODO: do something nicer
    # e.g. show benchmark params, nsamples, ...
    h_slow = Highlighter(
        (data,i,j)->j==3 && time(data[i,j]) > 1e6,
        bold = true, foreground = :red
    )
    h_fast = Highlighter(
        (data,i,j)->j==3 && time(data[i,j]) < 1e5,
        bold = true, foreground = :green
    )
    headers = [:day, :part, :benchmark]
    matrix = [collect(b)[i] for b in benchmarks, i in 1:3]
    pretty_table(matrix, headers, highlighters=(h_slow, h_fast))

    h_slow = HTMLHighlighter(
        (data,i,j)->j==3 && time(data[i,j]) > 1e6,
        HTMLDecoration(color = "red", font_weight = "bold")
    )
    h_fast = HTMLHighlighter(
        (data,i,j)->j==3 && time(data[i,j]) < 1e5,
        HTMLDecoration(color = "green", font_weight = "bold")
    )

    pretty_table(String, matrix, headers, highlighters=(h_slow, h_fast), backend=:html)
end

function generate_readme(benchmarks)
    file = open("README.md", "w")
    printfmt(file, readme_template, benchmarks)
    close(file)
    println("file $filename generated")
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--generate-readme"
            help = "use to generate README with benchmarking results"
            action = :store_true
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    generate_flag = parsed_args["generate-readme"]

    benchmarks = benchmark()
    generate_flag && generate_readme(benchmarks)
end

main()
