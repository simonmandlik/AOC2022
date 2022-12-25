input = readlines("1.in")

function solve()
    m = 0
    s = 0
    for l in input
        if isempty(l)
            m = max(m, s)
            s = 0
        else
            s += parse(Int, l)
        end
    end
    return m
end

print(solve())
