const M = 4000000

function solve()
    coords = map(split.(readlines("15.in"), ":")) do (s, b)
        xs, ys = parse.(Int, last.(split.(split(s[11:end], ", "), "=")))
        xb, yb = parse.(Int, last.(split.(split(b[23:end], ", "), "=")))
        (xs, ys), (xb, yb)
    end
    sX = zeros(Int, length(coords))
    eX = zeros(Int, length(coords))
    for Y in 0:M
        foreach(eachindex(coords)) do i
            (xs, ys), (xb, yb) = coords[i]
            r = abs(xs - xb) + abs(ys - yb) - abs(ys - Y)
            sX[i] = xs - r
            eX[i] = xs + r
        end
        X = 0
        idcs = sortperm(sX)
        for i in idcs
            if sX[i] ≤ X
                X = max(X, eX[i] + 1)
                X ≤ M || break
            end
        end
        if X ≤ M
            return M * X + Y
            break
        end
    end
end

println(solve())
