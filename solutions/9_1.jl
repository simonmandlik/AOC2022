function solve()
    res = Set{Tuple{Int, Int}}([(0, 0)])
    xh = yh = xt = yt = 0
    dx(d) = d == "R" ? 1 : (d == "L" ? -1 : 0)
    dy(d) = d == "U" ? 1 : (d == "D" ? -1 : 0)
    for i in readlines("9.in")
        d, n = split(i); n = parse(Int, n)
        for _ in 1:n
            xh += dx(d); yh += dy(d)
            if abs(xh-xt) + abs(yh-yt) > 2
                xt += sign(xh - xt); yt += sign(yh - yt)
            elseif abs(xh-xt) > 1
                xt += sign(xh - xt)
            elseif abs(yh-yt) > 1
                yt += sign(yh - yt)
            end
            push!(res, (xt, yt))
        end
    end
    length(res)
end

solve()
