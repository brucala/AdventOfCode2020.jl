module Day18

export solve1, solve2

function extract(x, i=1)
    elements = []
    for _ in 1:50
        c = x[i]
        i += 1
        c == ' ' && continue
        if c == '('
            i, v = extract(x, i)
            push!(elements, v)
        elseif c == ')'
            return i, elements
        else
            v = isnumeric(c) ? parse(Int, c) : Symbol(c)
            push!(elements, v)
        end
        i > length(x) && return i, elements
    end
end

result(x::AbstractString, isadvanced) = result(extract(x)[2], isadvanced)
result(x::Int, args) = x
function result(x, isadvanced)
    prev = result(x[1], isadvanced)
    @inbounds for i in 2:2:length(x)
        operator = x[i]
        isadvanced && operator === :* && return eval(operator)(prev, result(view(x, i+1:length(x)), isadvanced))
        prev = eval(operator)(prev, result(x[i+1], isadvanced))
    end
    return prev
end

function solve(x, isadvanced)
    sum(result(line, isadvanced) for line in readlines(IOBuffer(x)))
end

solve1(x) = solve(x, false)
solve2(x) = solve(x, true)

end  # module
