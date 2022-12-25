function solve()
    ls = readlines("16.in")
    nodes = Dict(reverse.(enumerate([l[7:8] for l in ls])))
    n = length(nodes)
    rates = [parse(Int, first(split(l, ';'))[24:end]) for l in ls]
    adj = [map(i -> nodes[strip(i, [','])], split(l)[10:end]) for l in ls]

    D = fill(typemax(Int) ÷ 3, n, n)
    for i in 1:n
        foreach(j -> D[i, j] = D[j, i] = 1, adj[i])
        D[i, i] = 0
    end
    for k in 1:n, i in 1:n, j in 1:n
        D[i, j] = min(D[i, j], D[i, k] + D[k, j])
    end

    best = 0

    vis = falses(length(rates))
    vis[nodes["AA"]] = true
    function solve1(i, D, rates, res, rem)
        if !vis[i]
            vis[i] = true
            rem -= 1
            res += rem * rates[i]
        end
        best = max(best, res)
        for j in 1:length(rates)
            i != j || continue
            rates[j] > 0 || continue
            !vis[j] || continue
            rem ≥ D[i, j] + 1 || continue
            solve1(j, D, rates, res, rem - D[i, j])
        end
        vis[i] = false
    end

    solve1(nodes["AA"], D, rates, 0, 30)

    vis[nodes["AA"]] = true
    function solve2(i, D, rates, res, rem, et)
        if !vis[i]
            vis[i] = true
            rem -= 1
            res += rem * rates[i]
            if !et
                solve2(nodes["AA"], D, rates, res, 26, true)
            end
        end
        best = max(best, res)
        for j in 1:length(rates)
            i != j || continue
            rates[j] > 0 || continue
            !vis[j] || continue
            rem ≥ D[i, j] + 1 || continue
            solve2(j, D, rates, res, rem - D[i, j], et)
        end
        if i != nodes["AA"]
            vis[i] = false
        end
    end

    solve2(nodes["AA"], D, rates, 0, 26, false)

    best
end

println(solve())
