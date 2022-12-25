function solve()
    input = readlines("2.in")
    s = 0
    for (a, x) in zip(getindex.(input, 1) .- 'A', getindex.(input, 3))
        if x == 'X'
            b = mod(a - 1, 3)
        elseif x == 'Z'
            b = mod(a + 1, 3)
        else
            b = a
        end
        @show a, b, x
        s += b + 1
        s += 3 * (x == 'Y')
        s += 6 * (x == 'Z')
    end
    return s
end

print(solve())
