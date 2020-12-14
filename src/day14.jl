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

tobits(x) = string(x, base=2, pad=36)
mask(x::Int, m::AbstractString) = mask(tobits(x), m) |> toint
mask(x::AbstractString, m::AbstractString) = join(mi=='1' ? '1' : mi=='0' ? '0' : xi for (xi, mi) in zip(x, m))

# part 2
function addresses(x::Int, m::AbstractString, floating_bits)
    x = x | xto(m, '1')
    return addresses(x, floating_bits)
end
function addresses(x::Int, floating_bits::Vector{Int})
    isempty(floating_bits) && return (x, )
    bit = floating_bits[1]
    x1, x0 = x | bit, x & ~bit
    return (addresses(x1, floating_bits[2:end])..., addresses(x0, floating_bits[2:end])...)
end

function getline(x)
    k, v = split(x, " = ")
    k == "mask" && return :mask, v
    i = k[5:end-1]
    return parse.(Int, (i, v))
end

function solve1(x)
    m::Mask = Mask(0, 0)
    #m = 0
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
    floating_bits = Int[]
    mem = Dict{Int, Int}()
    for line = readlines(IOBuffer(x))
        k, v = getline(line)
        if k == :mask
            m = v
            floating_bits = [2^(i-1) for i in findall(==('X'), reverse(m))]
            continue
        end
        for i in addresses(k, m, floating_bits)
            mem[i] = v
        end
    end
    return sum(values(mem))
end

end  # module
