function solve()
    input = map(readlines("19.in")) do l
        m = match(r"Blueprint (?<id>\d+): Each ore robot costs (?<ore1>\d+) ore. Each clay robot costs (?<ore2>\d+) ore. Each obsidian robot costs (?<ore3>\d+) ore and (?<clay3>\d+) clay. Each geode robot costs (?<ore4>\d+) ore and (?<obs4>\d+) obsidian.", l)
        m = parse.(Int, m)
        ( (m[2], 0, 0, 0), (m[3], 0, 0, 0), (m[4], m[5], 0, 0), (m[6], 0, m[7], 0) )
    end

    function dfs(t, fac, rs, mats, best)
        t_rem = 25 - t
        mats[end] + t_rem * rs[end] + (t_rem - 1) * t_rem ÷ 2 > best || return best
        best = max(best, mats[end] + t_rem * rs[end])
        if t_rem > 1
            for i in 4:-1:1
                t_needed = maximum(1:4) do j
                    n = fac[i][j] - mats[j]
                    n ≤ 0 && return 0
                    rs[j] == 0 && return 10000
                    cld(n, rs[j])
                end
                if t_needed + 1 < t_rem
                    mats .+= (t_needed + 1) .* rs
                    mats .-= fac[i]
                    rs[i] += 1
                    best = max(best, dfs(t + t_needed + 1, fac, rs, mats, best))
                    rs[i] -= 1
                    mats .+= fac[i]
                    mats .-= (t_needed + 1) .* rs
                end
            end
        end
        return best
    end

    sum(enumerate(input)) do (i, fac)
        i * dfs(1, fac, [1, 0, 0, 0], [0, 0, 0, 0], -1)
    end
end

solve() |> println
