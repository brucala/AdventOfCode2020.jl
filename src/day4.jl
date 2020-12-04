module Day4

export solve1
export solve2

const required_fields = (:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid)
const eye_colors = ("amb", "blu", "brn", "gry", "grn", "hzl", "oth")

function solve(x, f::Function)
    lines = split(x, "\n\n") .|> String
    nvalid = 0
    for passport in lines
        nvalid += f(passport)
    end
    return nvalid
end

solve1(x) = solve(x, isvalid_passport)
solve2(x) = solve(x, isvalid_passport2)

# part 1
extract_passport(x::AbstractString) = Dict(Symbol(k)=>v for (k,v) in split.(split(x), ":"))

isvalid_passport(x::AbstractString) = extract_passport(x) |> isvalid_passport
isvalid_passport(x::Dict) = setdiff(required_fields, keys(x)) |> isempty

# part 2

isnumeric(x::String) = collect(x) .|> isdigit |> all
ishex(x::String) = collect(x) .|> isxdigit |> all

struct Height
    height::String
    unit::String
end
Height(x::String) = Height(x[1:end-2], x[end-1:end])
isheight(h::Height) = isnumeric(h.height) && h.unit in ("in", "cm")
function isvalid(h::Height)
    !isheight(h) && return false
    height = parse(Int, h.height)
    return h.unit == "cm" ? 150 <= height <= 193 : 59 <= height <= 76
end

abstract type PassportField end
struct Byr <: PassportField value::String end
struct Iyr <: PassportField value::String end
struct Eyr <: PassportField value::String end
struct Hgt <: PassportField value::String end
struct Hcl <: PassportField value::String end
struct Ecl <: PassportField value::String end
struct Pid <: PassportField value::String end
struct Cid <: PassportField value::String end

struct Passport
    byr::Byr
    iyr::Iyr
    eyr::Eyr
    hgt::Hgt
    hcl::Hcl
    ecl::Ecl
    pid::Pid
    cid::Cid
end
Passport(;byr="", iyr="", eyr="", hgt="", hcl="", ecl="", pid="", cid="", args...) = Passport(
    Byr(byr), Iyr(iyr), Eyr(eyr), Hgt(hgt), Hcl(hcl), Ecl(ecl), Pid(pid), Cid(cid)
)
Passport(x::Dict) = Passport(;x...)
Passport(x::AbstractString) = Passport(extract_passport(x))

isvalid(f::PassportField) = isvalid(f, f.value)
isvalid(::Byr, x) = length(x) == 4 && isnumeric(x) && 1920 <= parse(Int, x) <= 2002
isvalid(::Iyr, x) = length(x) == 4 && isnumeric(x) && 2010 <= parse(Int, x) <= 2020
isvalid(::Eyr, x) = length(x) == 4 && isnumeric(x) && 2020 <= parse(Int, x) <= 2030
isvalid(::Hgt, x) = isvalid(Height(x))
isvalid(::Hcl, x) = length(x) == 7 && x[1] == '#' && ishex(x[2:end])
isvalid(::Ecl, x) = x in eye_colors
isvalid(::Pid, x) = length(x) == 9 && isnumeric(x)
isvalid(::Cid, x) = true

function isvalid(p::Passport)
    for f in propertynames(p)
        field = getproperty(p, f)
        !isvalid(field) && return false
    end
    return true
end

function isvalid_passport2(x::AbstractString)
    p = extract_passport(x)
    !isvalid_passport(p) && return false
    return isvalid(Passport(p))
end

end  # module
