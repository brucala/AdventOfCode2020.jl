module Utils

export read_ints, toint, splitlines, stripspaces, getgrid, find

"Reads each line assuming they are integers."
read_ints(x::AbstractString) = readlines(IOBuffer(x)) .|> toint

toint(s::Union{AbstractString, Char}) = parse(Int, s)

splitlines(s::AbstractString) = split(s, '\n')

stripspaces(s::AbstractString) = replace(s, " " => "")

getgrid(s::AbstractString, fmap=identity) = getgrid(splitlines(rstrip(s, '\n')), fmap)
function getgrid(lines::Vector{T}, fmap=identity) where T <: AbstractString
    n, m = length(lines), length(first(lines))
    grid = map(fmap, Iterators.flatten(lines))
    return reshape(grid, (m,n)) |> permutedims  # so it's well oriented
end

"""
    find(collection, element)

Finds index of first occurence of element `a` in collection `A`.
"""
find(A, a) = findfirst(==(a), A)

end
