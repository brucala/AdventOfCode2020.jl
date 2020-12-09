module Day9

export solve1, solve2

function valid_xmas(preamble, x)
    n = length(preamble)
    half = x ÷ 2

    iseven(x) && count(==(half), x) >=2 && return true

    preamble_set = Set(preamble)
    while length(preamble_set) > 1
        y = x - pop!(preamble_set)
        y ∈ preamble_set && return true
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

to_int(x) = parse(Int, x)
read_ints(x) = readlines(IOBuffer(x)) .|> to_int

function solve1(x, n=25)
    data = read_ints(x)

    for i in (n+1):length(data)
        !valid_xmas(data[i-n:i-1], data[i]) && return data[i]
    end
    return "solution not found"
end

function solve2(x, n=25)
    data = read_ints(x)
    invalid = solve1(x, n)
    return find_weakness(data, invalid)
end

end  # module
