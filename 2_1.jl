function solve()
    input = readlines("2.in")
    s = 0
    for (a, b) in zip(getindex.(input, 1) .- 'A', getindex.(input, 3) .- 'X')
        @show a, b
        s += b + 1
        s += 3 * (a == b)
        s += 6 * ((a + 1) % 3 == b)
    end
    return s
end

print(solve())
