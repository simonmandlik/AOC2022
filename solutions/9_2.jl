function solve()
    res = Set{Tuple{Int, Int}}([(0, 0)])
    X = zeros(Int, 10); Y = zeros(Int, 10)
    dx(d) = d == "R" ? 1 : (d == "L" ? -1 : 0)
    dy(d) = d == "U" ? 1 : (d == "D" ? -1 : 0)
    for i in readlines("9.in")
        d, n = split(i); n = parse(Int, n)
        for _ in 1:n
            X[1] += dx(d); Y[1] += dy(d)
            for i in 1:9
                if abs(X[i]-X[i+1]) + abs(Y[i]-Y[i+1]) > 2
                    X[i+1] += sign(X[i]-X[i+1]); Y[i+1] += sign(Y[i]-Y[i+1])
                elseif abs(X[i]-X[i+1]) > 1
                    X[i+1] += sign(X[i]-X[i+1])
                elseif abs(Y[i]-Y[i+1]) > 1
                    Y[i+1] += sign(Y[i]-Y[i+1])
                end
            end
            push!(res, (X[end], Y[end]))
        end
    end
    length(res)
end

solve()
