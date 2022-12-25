function tree()
    T = t = [0, [], Dict()]
    p = "/"
    foreach(readlines("7.in")) do c
        if startswith(c, "\$ cd")
            if c[end] == '/'
                t = T
            elseif c[end-1:end] == ".."
                p = dirname(p)
                t = T
                foreach(p -> t = t[3][p], splitpath(p)[2:end])
            else
                p = joinpath(p, c[6:end])
                t = t[3][c[6:end]]
            end
        elseif startswith(c, "dir")
            t[3][c[5:end]] = [0, [], Dict()]
        elseif !startswith(c, "\$ ls")
            s, fname = split(c)
            s = parse(Int, s)
            push!(t[2], (s, fname))
        end
    end
    return T
end

sizes!(t) = t[1] = sum(first.(t[2]); init=0) + sum(sizes!, values(t[3]); init=0)
solve(t) = t[1] * (t[1] <= 100000) + sum(solve, values(t[3]); init=0)

T = tree()
sizes!(T)
solve(T)
