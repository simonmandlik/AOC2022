function solve()
    grid = readlines("23.in")
    elves = Set{Tuple{Int, Int}}()
    for (i, l) in enumerate(grid)
        for j in findall('#', l)
            push!(elves, (i, j))
        end
    end

    t = 1
    while true
        elf_move = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
        mv_count = Dict{Tuple{Int, Int}, Int}()
        m = false
        for (i, j) in elves
            n = all(d -> (i-1, j+d) ∉ elves, -1:1)
            s = all(d -> (i+1, j+d) ∉ elves, -1:1)
            w = all(d -> (i+d, j-1) ∉ elves, -1:1)
            e = all(d -> (i+d, j+1) ∉ elves, -1:1)
            dirs = [n, s, w, e]
            mvs = [(i-1, j), (i+1, j), (i, j-1), (i, j+1)]
            mv = (i, j)
            if !all(dirs) && any(dirs)
                for i in 1:4
                    idx = 1 + mod(t + i - 2, 4)
                    if dirs[idx]
                        mv = mvs[idx]
                        m = true
                        break
                    end
                end
            end
            elf_move[(i, j)] = mv
            mv_count[mv] = get(mv_count, mv, 0) + 1
        end
        m || return t
        new_elves = empty(elves)
        for e in elves
            mv = elf_move[e]
            if mv_count[mv] == 1
                push!(new_elves, mv)
            else
                push!(new_elves, e)
            end
        end
        elves = new_elves
        t += 1
    end
end

solve() |> println
