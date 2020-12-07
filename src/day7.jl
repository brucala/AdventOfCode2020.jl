module Day7

export solve1, solve2

function extract_rule(x::AbstractString)
    bag, rules = split(x, "contain")
    bag = extract_bag(bag)
    rules = extract_contents(rules)
    return bag, rules
end

extract_bag(x::AbstractString) = split(strip(x), " bag")[1]
function extract_number_and_bag(x::AbstractString)
    !isdigit(x[1]) && return 0, ""
    return parse(Int, x[1]), extract_bag(x[3:end])
end

function extract_contents(x::AbstractString)
    bags = split(x, ",") .|> strip
    contents = extract_number_and_bag.(bags)
    return Tuple(c[2] for c in contents), Tuple(c[1] for c in contents)
end

contains_bag(rules, bag) = bag in rules[1]
find_containing_bags(bags::Dict, bag::AbstractString) = Set(
    [b for (b, r) in bags if contains_bag(r, bag)]
)

const MY_BAG = "shiny gold"

function read_bagrules(x)
    bags = Dict{AbstractString, Tuple}()
    for line = readlines(IOBuffer(x))
        bag, rules = extract_rule(line)
        bags[bag] = rules
    end
    return bags
end

function howmany(bags, bag)
    rules = bags[bag]
    rules[2] == (0,) && return 0
    return sum(rules[2]) + sum([howmany(bags, rules[1][i]) * rules[2][i] for i in 1:length(rules[1])])
end

function solve1(x)
    bags = read_bagrules(x)
    seen = Set{AbstractString}()
    sol = Set{AbstractString}()
    search = (MY_BAG, )
    while !isempty(search)
        for bag in search
            found = find_containing_bags(bags, bag)
            push!(seen, bag)
            union!(sol, found)
        end
        search = setdiff(sol, seen)
    end
    return sol |> length
end

function solve2(x)
    bags = read_bagrules(x)
    return howmany(bags, MY_BAG)
end

end  # module
