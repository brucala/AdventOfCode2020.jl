module Day2

export solve1
export solve2


function parse_password(x::String)
    range, letter, password = split(x)
    l, h = parse.(Int, split(range, '-'))
    letter = letter[1:1]
    return (l, h), letter, password
end

struct Password
    range::Tuple{Int, Int}
    letter::String
    password::String
end
Password(x::String) = Password(parse_password(x)...)

function isvalid(pass::Password)
    n = count(pass.letter, pass.password)
    return n ∈ UnitRange(pass.range...)
end

function isvalid2(pass::Password)
    check(pass::Password, i) = pass.password[pass.range[i]] == pass.letter[1]
    return check(pass, 1) ⊻ check(pass, 2)
end

function solve(x, f)
    passwords = Password[]
    for pass = readlines(IOBuffer(x))
        push!(passwords, Password(pass))
    end
    return sum(f.(passwords))
end

solve1(x) = solve(x, isvalid)

solve2(x) = solve(x, isvalid2)

end  # module
