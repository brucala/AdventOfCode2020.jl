module Day19

export solve1, solve2

splitlines(x) = split(x, '\n')


function update_rules!(rules)
    rules[8] = "42 | 42 8"
    rules[11] = "42 31 | 42 11 31"
end

function parse_data(x, with_update)
    rules, messages = split(x, "\n\n") .|> splitlines
    return parse_rules(rules, with_update), messages
end

function parse_rules(rules, with_update)
    matched_rules = Dict{Int, String}()
    unmatched_rules = Dict{Int, String}()
    for rule in rules
        n, r = split(rule, ": ")
        n = toint(n)
        if startswith(r, "\"")
            matched_rules[n] = r[2:2]
            continue
        end
        unmatched_rules[n] = r
    end
    with_update && update_rules!(unmatched_rules)
    return match_rules(matched_rules, unmatched_rules)
end

function match_rules(matched_rules, unmatched_rules)
    nunmatched = length(unmatched_rules)
    for i in 1:100
        for irule in keys(unmatched_rules)
            r = unmatched_rules[irule]
            newrule = match_rule(matched_rules, r)
            if fullymatched(newrule)
                newrule = iscomposed(newrule) ? stripspaces("($newrule)") : newrule
                push!(matched_rules, irule => newrule)
                pop!(unmatched_rules, irule)
            else
                unmatched_rules[irule] = newrule
            end
        end
        isempty(unmatched_rules) && break
        length(unmatched_rules) == nunmatched && break
        nunmatched = length(unmatched_rules)
    end
    return matched_rules
end

function match_rule(matched_rules, rule)
    for (n, r) in matched_rules
        rmatch = Regex("^$n\$|^$n | $n | $n\$")
        rule = replace(rule, rmatch => " $r ")
    end
    return rule
end

iscomposed(x) = '|' in x

fullymatched(x) = !occursin(r"\d+", x)

get_ints(s) = getindex.(s, findall(r"\d+", s)) .|> toint

toint(x) = parse(Int, x)

stripspaces(x) = replace(x, " " => "")

matches(rule::String, message) = occursin.(Regex("^$rule\$"), message)

function solve1(x)
    rules, messages = parse_data(x, false)
    rule0 = rules[0]
    return matches.(rule0, messages) |> sum
end

# infinite loops are:
# 8: 42 | 42 8          -> at least one 42
# 11: 42 31 | 42 11 31  -> at least a 42 followed by the same number of 31
# 0: 8 11
# that means n (>1) 42 followed by m (<n) 31
# i don't know how to constrain n and n+1, so will construct several cases
special_rule(rules, n) = "$(rules[42]){$(n+1),}$(rules[31]){1,$n}"

matches(rules::Vector{String}, message) = any(r->matches(r, message), rules)

function solve2(x)
    rules, messages = parse_data(x, true)
    nmax = 4   # a bit of brute force... there must be a smarter way
    rule0 = [special_rule(rules, i) for i in 1:nmax]
    nmatches = 0
    for message in messages
        nmatches += matches(rule0, message)
    end
    return nmatches
end

end  # module
