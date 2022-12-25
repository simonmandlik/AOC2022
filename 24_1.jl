function check(x, y, d, t, storms, X, Y) 
    (mod(x - t, X), y, 'v') ∉ storms &&
    (mod(x + t, X), y, '^') ∉ storms &&
    (x, mod(y - t, Y), '>') ∉ storms &&
    (x, mod(y + t, Y), '<') ∉ storms
end

function solve()
    input = readlines("24.in")
    X = length(input) - 2
    Y = length(input[1]) - 2

    storms = Set{Tuple{Int, Int, Char}}()
    for (x, l) in enumerate(input), (y, ch) in enumerate(l)
        if ch ∉ ['.', '#']
            push!(storms, (x-2, y-2, ch))
        end
    end

    q1 = [(-1, 0)] |> Set
    for t in Iterators.countfrom(1)
        q2 = empty(q1)
        for (x, y) in q1
            for (nx, ny, d) in [(x, y, ' '),
                                (x-1, y, '^'), (x+1, y, 'v'),
                                (x, y-1, '<'), (x, y+1, '>')]
                (nx, ny) == (X, Y-1) && return t
                (nx, ny) == (-1, 0) || 0 ≤ nx < X || continue
                 0 ≤ ny < Y || continue
                check(nx, ny, d, t, storms, X, Y) || continue
                push!(q2, (nx, ny))
            end
        end
        q1 = q2
    end
end

solve() |> println
