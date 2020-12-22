module Day9
include("utils.jl")
using .Utils

export solve1, solve2

function valid_xmas(preamble, x)
    n = length(preamble)
    half = x ÷ 2

    iseven(x) && count(==(half), x) >=2 && return true

    # the array version seems 3x faster
    #preamble_set = Set(preamble)
    preamble = copy(preamble)
    while length(preamble) > 1
        y = x - pop!(preamble)
        y ∈ preamble && return true
    end
    return false
end

function find_weakness(data, x)
    j = 2
    s = sum(data[1:2])
    for i in 1:length(data)
        s == x && return extrema(data[i:j]) |> sum
        while s < x
            j += 1
            s += data[j]
            s == x && return data[i] + data[j]
        end
        s -= data[i]
    end
    return "weakness not found"
end

function solve1(x::Vector{Int}, n=25)
    for i in (n+1):length(x)
        !valid_xmas(x[i-n:i-1], x[i]) && return x[i]
    end
    return "solution not found"
end

solve1(x, n=25) = solve1(read_ints(x), n)

function solve2(x, n=25)
    data = read_ints(x)
    invalid = solve1(data, n)
    return find_weakness(data, invalid)
end

end  # module
