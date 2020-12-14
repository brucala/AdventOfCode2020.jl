module Day14

export solve1, solve2

struct Mask
    mask0::Int
    mask1::Int
end

#part 1
Mask(s::AbstractString) = Mask(xto(s, '1'), xto(s, '0'))
xto(s, b) = map(x->x=='X' ? b : x, s) |> toint
toint(s) = parse(Int, s, base=2)
mask(x::Int, m::Mask) = (x & m.mask0) | m.mask1

# part 2
addresses(x, m) = toint.(replaceX(mask2(x, m)))
function mask2(x, m)
    s = string(x, base=2, pad=36) |> collect
    return join(vm == 'X' ? vm : vm == '1' ? '1' : vs for (vs, vm) in zip(s, m))
end
function replaceX(s::AbstractString)
    'X' ∉ s && return (s, )
    s0 = replace(s, 'X'=>'0', count=1)
    s1 = replace(s, 'X'=>'1', count=1)
    return (replaceX(s0)..., replaceX(s1)...)
end

function getline(x)
    k, v = split(x, " = ")
    k == "mask" && return :mask, v
    i = k[5:end-1]
    return parse.(Int, (i, v))
end

function solve1(x)
    m::Mask = Mask(0, 0)
    mem = Dict{Int, Int}()
    for line = readlines(IOBuffer(x))
        k, v = getline(line)
        if k == :mask
            m = Mask(v)
            continue
        end
        mem[k] = mask(v, m)
    end
    return sum(values(mem))
end

function solve2(x)
    m = ""
    mem = Dict{Int, Int}()
    for line = readlines(IOBuffer(x))
        k, v = getline(line)
        if k == :mask
            m = v
            continue
        end
        for i in addresses(k, m)
            mem[i] = v
        end
    end
    return sum(values(mem))
end

end  # module
