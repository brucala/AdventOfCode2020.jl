using Markdown
using BenchmarkTools

function available_solvers(day_module::Module)
    solve_methods = [:solve1, :solve2]
    sols = [getfield(day_module, sol) for sol in solve_methods if sol in names(day_module)]
    isempty(sols) && error("No solve method found in module $day_module")
    return sols
end

getpart(sol::Function) = "part$(string(sol)[end])"
getday(day_module::Module) = split(string(day_module), '.')[end]

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

function solutions(sols, data)
    for (i,sol) in enumerate(sols)
        println()
        show(stdout, MIME("text/plain"), md"## Solution $i")
        println()
        @time y = sol(data)
        show(stdout, MIME("text/plain"), md"**solution**: $y")
        println()
    end
end

function solutions(day_module::Module, data)
    sols = available_solvers(day_module)
    println()
    show(stdout, MIME("text/plain"), md"# Solutions for $day_module:")
    println()
    solutions(sols, data)
end
