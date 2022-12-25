function solve()
    input = readlines("1.in")
    push!(input, "")
    m = []
    s = 0
    for l in input
        if isempty(l)
            push!(m, s)
            s = 0
        else
            s += parse(Int, l)
        end
    end
    sort!(m; rev=true)
    return sum(m[1:3])
end

print(solve())
