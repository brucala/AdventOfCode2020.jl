module Day3

export solve1
export solve2

istree(line::String, i::Int) = line[i*3 % length(line) + 1] == '#'

function istree2(line::String, i::Int, strategy::Tuple{Int, Int})
    r, d = strategy
    i % d != 0 && return false
    pos = (i * r ÷  d) % length(line) + 1
    #println("$i $r $d $pos $line")
    return line[pos] == '#'
end

function solve1(x)
    ntrees = 0
    for (i, line) = readlines(IOBuffer(x)) |> enumerate
        ntrees += istree(line, i-1)
    end
    return ntrees
end

function solve2(x)
    strategies = [(1,1), (3,1), (5,1), (7,1), (1,2)]
    ntrees = zeros(Int, size(strategies))
    for (i, line) = readlines(IOBuffer(x)) |> enumerate
        ntrees .+= istree2.(line, i-1, strategies)
    end
    return prod(ntrees)
end

end  # module
