using AdventOfCode2020
using BenchmarkTools
using PrettyTables, DataFrames

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

function main()
    benchmarks = NamedTuple[]
    for nday in solved_days
        day = getproperty(AdventOfCode2020, Symbol("Day$nday"))
        data = read_input(nday)
        append!(benchmarks, benchmark(day, data))
    end

    h_slow = h1 = Highlighter(
        (data,i,j)->j==3 && time(data[i,j]) > 1e6,
        bold = true, foreground = :red
    )
    h_fast = h1 = Highlighter(
        (data,i,j)->j==3 && time(data[i,j]) < 1e5,
        bold = true, foreground = :green
    )

    # TODO: do something nicer
    # e.g. show benchmark params, nsamples, ...
    pretty_table(DataFrame(benchmarks), highlighters=(h_slow, h_fast))
end

main()
