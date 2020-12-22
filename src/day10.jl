module Day10
include("utils.jl")
using .Utils

export solve1, solve2

function solve1(x)
    data = read_ints(x)
    push!(data, 0)
    sort!(data)
    count1, count3 = 0, 1
    for i in 2:length(data)
        Δ = data[i] - data[i-1]
        if Δ == 1
            count1 += 1
        elseif Δ == 3
            count3 += 1
        end
    end
    return count1*count3
end

function howmany!(d, n)
    if n == 0
        return 1
    elseif !haskey(d, n) || n<0
        return 0
    elseif d[n] == 0
        d[n] = sum(howmany!(d, n-i) for i=1:3)
    end
    return d[n]
end

function solve2(x)
    data = read_ints(x)
    d = Dict(i=>0 for i in data)
    return howmany!(d, maximum(data))
end

end  # module
