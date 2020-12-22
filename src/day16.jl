module Day16
include("utils.jl")
using .Utils

export solve1, solve2

struct Rule
    name::String
    rules::Vector{UnitRange{Int}}
end
function Rule(x::AbstractString)
    name, rules = split(x, ":")
    rules = split(rules, " or ")
    rules = getrange.(rules)
    Rule(name, rules)
end
function getrange(x)
    a, b = parse.(Int, split(x, '-'))
    return a:b
end

isvalid_field(rule::Rule, field::Int) = any(r -> field ∈ r, rule.rules)
isvalid_field(rules::Vector{Rule}, field::Int) = any(r -> isvalid_field(r, field), rules)
isvalid_ticket(rules::Vector{Rule}, fields::Vector{Int}) = all(f -> isvalid_field(rules, f), fields)
isvalid_rule(rule::Rule, fields::Vector{Int}) = all(f -> isvalid_field(rule, f), fields)
isvalid_matrix(rules::Vector{Rule}, tickets::Matrix{Int}) = [Day16.isvalid_rule(r, tickets[:,f]) for r in rules, f in 1:size(tickets)[2]]

function extract_notes(x)
    rules, tickets = Rule[], Vector{Vector{Int}}(undef, 0)
    isrule = true
    for line in readlines(IOBuffer(x))
        isrule = isrule && !occursin("ticket", line)
        isempty(line) && continue
        if isrule
            push!(rules, Rule(line))
        elseif isdigit(line[1])
            push!(tickets, extract_ticket(line))
        end
    end
    return rules, tickets[1], tickets[2:end]
end

# this is slower
# function extract_notes(x)
#     rules, yours, nearby = split(x, "\n\n") .|> splitlines
#     rules = Rule.(rules)
#     yours = extract_ticket(yours[2])
#     nearby = extract_ticket.(nearby[2:end])
#     return rules, yours, nearby
# end
extract_ticket(x) = split(x, ',') .|> toint

function extract_fields(field_names, indices, matrix, i, j)
    fname = popat!(field_names, j)
    index = popat!(indices, i)
    fields = extract_fields(field_names, indices, sliceout(matrix, j, i))
    fields[fname] = index
    return fields
end
function extract_fields(field_names, indices, matrix)
    N = length(field_names)
    N == 1 && return Dict(field_names[1] => indices[1])
    for i in 1:N
        if sum(matrix[:, i]) == 1
            j = findfirst(matrix[:, i])
            return extract_fields(field_names, indices, matrix, i, j)
        elseif sum(matrix[i, :]) == 1
            j = findfirst(matrix[i, :])
            return extract_fields(field_names, indices, matrix, j, i)
        end
    end
    @error "extraction failed"
end

function sliceout(matrix, i, j)
    n, m = size(matrix)
    x, y = trues(n), trues(m)
    x[i] = false
    y[j] = false
    @view matrix[x, y]
end

function solve1(x)
    rules, _, tickets = extract_notes(x)
    error_rate = 0
    for t in tickets
        for field in t
            error_rate += !isvalid_field(rules, field) && field
        end
    end
    return error_rate
end

function solve2(x)
    rules, ticket, tickets = extract_notes(x)
    nfields = length(rules)
    field_names = [rule.name for rule in rules]

    # filter out invalid tickets
    filter!(ticket -> isvalid_ticket(rules, ticket), tickets)

    # transform into matrix
    tickets = [tickets[t][f] for t in 1:length(tickets), f in 1:nfields]

    # matrix of valid rules (rows) x fields (columns)
    matrix = isvalid_matrix(rules, tickets)

    # field to position
    fields = extract_fields(field_names, collect(1:nfields), matrix)

    # my ticket fields
    my_ticket = Dict(f => ticket[i] for (f,i) in fields)

    # solution
    sol = prod(startswith(f, "departure") ? v : 1 for (f,v) in my_ticket)

    return sol, my_ticket
end

end  # module
