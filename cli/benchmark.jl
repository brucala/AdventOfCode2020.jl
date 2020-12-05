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
    return benchmarks
end

function benchmark_table(benchmarks, html_format=false)
    # TODO: do something nicer
    # e.g. show benchmark params, nsamples, ...
    headers = [:day, :part, :benchmark]
    matrix = [collect(b)[i] for b in benchmarks, i in 1:3]
    h_slow, h_fast = highlighters(html_format)
    backend = html_format ? :html : :text

    # print in screen in text format
    pretty_table(matrix, headers, highlighters=highlighters(false))

    return pretty_table(String, matrix, headers, highlighters=(h_slow, h_fast), backend=backend)
end

function highlighters(html_format=false, slow=1e6, fast=1e5)
    slow_f = (data,i,j)->j==3 && time(data[i,j]) > slow
    fast_f = (data,i,j)->j==3 && time(data[i,j]) < fast

    if html_format
        h_slow = HTMLHighlighter(slow_f, HTMLDecoration(color = "red", font_weight = "bold"))
        h_fast = HTMLHighlighter(fast_f, HTMLDecoration(color = "green", font_weight = "bold"))
        return h_slow, h_fast
    end
    h_slow = Highlighter(slow_f, bold = true, foreground = :red)
    h_fast = Highlighter(fast_f, bold = true, foreground = :green)
    return h_slow, h_fast
end

function generate_readme(table, html_format=false)
    filename = "README.md"
    file = open(filename, "w")
    if !html_format
        table = "```\n$table\n```"
    end
    printfmt(file, readme_template, table)
    close(file)
    println("file $filename generated")
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--generate-readme", "-g"
            help = "use to generate README with benchmarking results"
            action = :store_true
        "--format", "-f"
            help = "table format for generated README (available: text/html)"
            arg_type = String
            range_tester = x -> x ∈ ("text", "html")
            default = "text"
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    generate_flag = parsed_args["generate-readme"]
    html_format = parsed_args["format"] == "html"

    benchmarks = benchmark()
    table = benchmark_table(benchmarks, html_format)
    generate_flag && generate_readme(table)
end

main()
