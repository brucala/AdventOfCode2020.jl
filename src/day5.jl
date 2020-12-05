module Day5

export solve1, solve2

function extract_row(x::AbstractString)
    row = x[1:7]
    row = map(x-> x == 'B' ? 1 : 0, collect(row)) |> join
    return parse(Int, row, base=2)
end
function extract_column(x::AbstractString)
    col = x[8:end]
    col = map(x-> x == 'R' ? 1 : 0, collect(col)) |> join
    return parse(Int, col, base=2)
end

extractID(x::AbstractString) = extractID(extract_row(x), extract_column(x))
extractID(row, column) = row * 8 + column

function solve1(x)
    maxid = 0
    for line = readlines(IOBuffer(x))
        maxid = max(maxid, extractID(line))
    end
    return maxid
end

function solve2(x)
    ids = Int[]
    for line = readlines(IOBuffer(x))
        push!(ids, extractID(line))
    end
    minid, maxid = extrema(ids)
    return setdiff(minid:maxid, ids)
end

end  # module
