module Day13
include("utils.jl")
using .Utils

export solve1, solve2

function parse_data(x)
    tmin, line = readlines(IOBuffer(x))
    tmin = toint(tmin)
    buses = [(toint(bus), i-1) for (i, bus) in enumerate(split(line, ",")) if bus != "x"]
    return tmin, buses
end

closest_time(tmin, bus) = cld(tmin, bus) * bus

function solve1(x)
    tmin, buses = parse_data(x)
    bids = [b[1] for b in buses]
    ctime, ibus = closest_time.(tmin, bids) |> findmin
    return bids[ibus] * (ctime -tmin)
end

function solve2(x)
    _, buses = parse_data(x)

    bus = popat!(buses, 1)
    multiplier = bus[1]

    t=0
    while true
        t += multiplier
        for b in length(buses):-1:1
            bid, Δ = buses[b]
            if (t+Δ) % bid == 0
                multiplier *= bid
                popat!(buses, b)
                isempty(buses) && return t
            end
        end
    end
end

end  # module
