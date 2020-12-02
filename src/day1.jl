module Day1

export solve1, solve2

to_int(x::String) = parse.(Int, split(x))

function solve1(x)
    x = to_int(x)
    n = length(x)
    for a = x[1:n-1]
        for b = x[2:n]
            if a + b == 2020
                println("$a x $b = $(a*b)")
                return a * b
            end
        end
    end
    return 0
end

function solve2(x)
    x = to_int(x)
    n = length(x)
    for a = x[1:n-2]
        for b = x[2:n-1]
            if a + b >= 2020
                continue
            end
            for c = x[3:n]
                if a + b +c == 2020
                    println("$a x $b x $c = $(a*b*c)")
                    return a * b * c
                end
            end
        end
    end
    return 0
end


end  # module
