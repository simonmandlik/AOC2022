function solve()
    input = map(readlines("21.in")) do l
        m, op = split(l, ": ")
        m => op
    end |> Dict
    mem = Dict{String, Int}()

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
                rec(ma) / rec(mb)
            end
        end
        return mem[m]
    end

    rec("root")
end

solve() |> println
