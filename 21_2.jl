function solve()
    input = map(readlines("21.in")) do l
        m, op = split(l, ": ")
        m => op
    end |> Dict
    mem = Dict{String, Union{Missing, Int}}()
    mem["humn"] = missing

    function rec(m)
        haskey(mem, m) && return mem[m]
        try
            mem[m] = parse(Int, input[m])
        catch
            ma, op, mb = split(input[m], " ")
            mem[m] = if op == "+"
                rec(ma) + rec(mb)
            elseif op == "-"
                rec(ma) - rec(mb)
            elseif op == "*"
                rec(ma) * rec(mb)
            elseif op == "/"
                rec(ma) ÷ rec(mb)
            end
        end
        return mem[m]
    end

    function rec2(m, r)
        m == "humn" && return r
        ma, op, mb = split(input[m], " ")
        ra = mem[ma]; rb = mem[mb]
        @assert ismissing(ra) ⊻ ismissing(rb)
        if ismissing(ra)
            if op == "+"
                rec2(ma, r - rb)
            elseif op == "-"
                rec2(ma, r + rb)
            elseif op == "*"
                rec2(ma, r ÷ rb)
            elseif op == "/"
                rec2(ma, r * rb)
            end
        elseif ismissing(rb)
            if op == "+"
                rec2(mb, r - ra)
            elseif op == "-"
                rec2(mb, ra - r)
            elseif op == "*"
                rec2(mb, r ÷ ra)
            elseif op == "/"
                rec2(mb, ra ÷ r)
            end
        end
    end

    m1, _, m2 = split(input["root"], " ")
    r1 = rec(m1); r2 = rec(m2)
    if ismissing(r1)
        rec2(m1, r2)
    else
        rec2(m2, r1)
    end
end

solve() |> println
