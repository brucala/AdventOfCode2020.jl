using Markdown

function solutions(sols, data)
    for (i,sol) in enumerate(sols)
        println()
        show(stdout, MIME("text/plain"), md"## Solution $i")
        println()
        exp = Expr(:call, sol, data)
        @time y = eval(exp)
        show(stdout, MIME("text/plain"), md"**solution**: $y")
        println()
    end
end

function solutions(day_module::Module, data)
    solve_methods = [:solve1, :solve2]
    sols = [getfield(day_module, sol) for sol in solve_methods if sol in names(day_module)]

    if isempty(sols)
        if :solve in names(day_module)
            sols = [:solve]
        else
            return "No solve methods found in module $day_module"
        end
    end

    println()
    show(stdout, MIME("text/plain"), md"# Solutions for $day_module:")
    println()
    solutions(sols, data)
end
