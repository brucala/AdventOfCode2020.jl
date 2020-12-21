module Day21

export solve1, solve2

function parse_line(x)
    ingredients, allergenes = split(x, " (contains ")
    allergenes = rstrip(allergenes, ')')
    return symbolset(split(ingredients)), symbolset(split(allergenes, ", "))
end
symbolset(x) = Symbol.(x) |> Set

function update!(candidates, found_ingredients, candidate, ingredients)
    haskey(candidates, candidate) && length(candidates[candidate]) == 1 && return
    setdiff!(ingredients, found_ingredients)
    candidates[candidate] = haskey(candidates, candidate) ?
                            candidates[candidate] ∩ ingredients :
                            ingredients
    check_found!(candidates, found_ingredients, candidate)
    return
end

function check_found!(candidates, found_ingredients, candidate)
    if length(candidates[candidate]) == 1
        found_ingredient = candidates[candidate] |> first
        found_ingredient ∈ found_ingredients && return
        push!(found_ingredients, found_ingredient)
        for c in keys(candidates)
            (c == candidate || found_ingredient ∉ candidates[c]) && continue
            pop!(candidates[c], found_ingredient)
            check_found!(candidates, found_ingredients, c)
        end
    end
end

# just for convenience
const Allergen = Symbol
const Ingredient = Symbol

function solve(x)
    ningredients = Dict{Ingredient, Int}()
    found_ingredients = Set{Ingredient}()
    candidates = Dict{Allergen, Set{Ingredient}}()

    for line = readlines(IOBuffer(x))
        ingredients, allergenes = parse_line(line)
        for ing in ingredients
            ningredients[ing] = get!(ningredients, ing, 0) + 1
        end
        for candidate in allergenes
            update!(candidates, found_ingredients, candidate, ingredients)
        end
    end

    return ningredients, found_ingredients, candidates
end

function solve1(x)
    ningredients, found_ingredients, _ = solve(x)
    return sum(n for (ing, n) in ningredients if ing ∉ found_ingredients)
end
function solve2(x)
    _, _, candidates = solve(x)
    candidates = sort(collect(candidates), by=x->x[1])
    return join([string(first(ing)) for (_, ing) in candidates], ',')
end

end  # module
