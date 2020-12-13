module Day13

export solve1, solve2

function parse_data(x)
    tmin, line = readlines(IOBuffer(x))
    tmin = parse(Int, tmin)
    line = [(parse(Int, bus), i-1) for (i, bus) in enumerate(split(line, ",")) if bus != "x"]
    buses  = [x[1] for x in line]
    ibuses = [x[2] for x in line]
    return tmin, buses, ibuses
end

closest_time(tmin, bus) = cld(tmin, bus) * bus

function solve1(x)
    tmin, bids, _ = parse_data(x)
    ctime, ibus = closest_time.(tmin, bids) |> findmin
    return bids[ibus] * (ctime -tmin)
end

function solve2(x)
    _, bids, Δts = parse_data(x)

    maxbid, imax = findmax(bids)
    tmax = Δts[imax]

    @show maxbid, imax, tmax

    multiplier = bids[1]
    for i in 1:1_000_000_0000
        # if i == 152683
        #     @show i, multiplier, i*multiplier
        #     @show [((i*multiplier + ibuses[x]), ibuses[x], bids[x]) for x in 2:length(bids)]
        #     @show [((i*multiplier + ibuses[x]) % bids[x]) for x in 2:length(bids)]
        # end
        if all(((i*maxbid + (Δts[j]-tmax)) % bids[j]) == 0 for j in 1:length(bids) if j!=imax)
            return i*maxbid - tmax
        end
    end
end

end  # module
