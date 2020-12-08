using AdventOfCode2020
using BenchmarkTools
using PrettyTables
using ArgParse, Formatting

const readme_template = FormatExpr(
"""
# Advent of Code 2020

Solutions to [Advent of Code 2020 edition](https://adventofcode.com/2020) in Julia.

> Disclaimer: these solutions are created just as a way to practice and become more familiar
with the awesome Julia language. They are not optimized for efficiency or for code beauty.

## Benchmarks

To run the benchmarks:

    \$ julia cli/benchmark.jl

{}
"""
)

function available_solvers(day_module::Module)
    solve_methods = [:solve1, :solve2]
    sols = [getfield(day_module, sol) for sol in solve_methods if sol in names(day_module)]
    isempty(sols) && error("No solve method found in module $day_module")
    return sols
end

getpart(sol::Function) = "part$(string(sol)[end])"
getday(day_module::Module) = split(string(day_module), '.')[end] |> String

getN(s::String) = parse(Int, match(r"\d+$", s).match)

struct AOCBenchmark
    day::Int
    part::Int
    benchmark::BenchmarkTools.Trial
end
AOCBenchmark(d::String, p::String, b::BenchmarkTools.Trial) = AOCBenchmark(getN(d), getN(p), b)

day(b::AOCBenchmark) = b.day
part(b::AOCBenchmark) = b.part
btime(b::AOCBenchmark) = time(b.benchmark)
bmemory(b::AOCBenchmark) = memory(b.benchmark)

function benchmark(day_module::Module, data)
    sols = available_solvers(day_module)
    benchmarks = AOCBenchmark[]
    for sol in sols
        d, p = getday(day_module), getpart(sol)
        b = @benchmark $sol($data) seconds=0.5 samples=1000
        nsamples = length(b.times)
        nsamples <= 100 && @warn "low number of samples ($nsamples) run for benchmarking $d $p"
        push!(benchmarks, AOCBenchmark(d, p, b))
    end
    return benchmarks
end

function benchmark()
    benchmarks = AOCBenchmark[]
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
    headers = [:day, :part, :time, :memory]
    matrix = Union{Int, Float64}[day.(benchmarks) part.(benchmarks) btime.(benchmarks) bmemory.(benchmarks)]
    h = highlighters(html_format)
    f = (v,i,j) -> j == 3 ? BenchmarkTools.prettytime(v) : j==4 ? BenchmarkTools.prettymemory(v) : v
    backend = html_format ? :html : :text
    hlines = 2:2:length(benchmarks) |> collect

    common_kwargs = (crop=:none, formatters=f, body_hlines=hlines)

    # print in screen in text format
    pretty_table(matrix, headers; highlighters=highlighters(false), common_kwargs...)

    return pretty_table(String, matrix, headers; highlighters=h, common_kwargs...)
end

function highlighters(html_format=false, very_slow=5e8, slow=5e6, fast=2e5)
    very_slow_f = (data,i,j)->j==3 && data[i,j] > very_slow
    slow_f = (data,i,j)->j==3 && slow < data[i,j] < very_slow
    fast_f = (data,i,j)->j==3 && data[i,j] < fast

    if html_format
        h_very_slow = HTMLHighlighter(very_slow_f, HTMLDecoration(color = "red", font_weight = "bold"))
        h_slow = HTMLHighlighter(slow_f, HTMLDecoration(color = "yellow", font_weight = "bold"))
        h_fast = HTMLHighlighter(fast_f, HTMLDecoration(color = "green", font_weight = "bold"))
        return h_very_solw, h_slow, h_fast
    end
    h_very_slow = Highlighter(very_slow_f, bold = true, foreground = :red)
    h_slow = Highlighter(slow_f, bold = true, foreground = :yellow)
    h_fast = Highlighter(fast_f, bold = true, foreground = :green)
    return h_very_slow, h_slow, h_fast
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
