module Day1

export solve1, solve2

to_int(x::String) = parse.(Int, split(x))

function solve1(x)
    x = to_int(x)
    n = length(x)
    for a = x[1:n-1]
        for b = x[2:n]
            a + b == 2020 && return a * b
        end
    end
    return 0
end

function solve2(x)
    x = to_int(x)
    n = length(x)
    for a = x[1:n-2]
        for b = x[2:n-1]
            a + b >= 2020 && continue
            for c = x[3:n]
                a + b +c == 2020 && return a * b * c
            end
        end
    end
    return 0
end


end  # module
