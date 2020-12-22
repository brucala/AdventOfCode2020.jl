module Day19
include("utils.jl")
using .Utils

export solve1, solve2

iscomposed(x) = '|' in x
fullymatched(x) = !occursin(r"\d+", x)

function parse_data(x)
    rules, messages = split(x, "\n\n") .|> splitlines
    return parse_rules(rules), messages
end

function parse_rules(rules)
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

matches(rule::String, message) = occursin.(Regex("^$rule\$"), message)
matches(rules::Vector{String}, message) = any(r->matches(r, message), rules)

# special rule 0 for part 2:
# infinite loops are:
# 8: 42 | 42 8          -> at least one 42
# 11: 42 31 | 42 11 31  -> at least a 42 followed by the same number of 31
# 0: 8 11
# for 0 that means n (>1) 42 followed by m (<n) 31
# i don't know how to constrain n and m in the same regex, so will construct several cases
special_rule(rules, n) = "$(rules[42]){$(n+1),}$(rules[31]){1,$n}"

function solve(x, update=false)
    rules, messages = parse_data(x)
    nmax = 4   # for part 2: a bit of brute force... there must be a smarter way
    rule0 = update ? [special_rule(rules, i) for i in 1:nmax] : rules[0]
    nmatches = 0
    for message in messages
        nmatches += matches(rule0, message)
    end
    return nmatches
end

solve1(x) = solve(x)
solve2(x) = solve(x, true)

end  # module
