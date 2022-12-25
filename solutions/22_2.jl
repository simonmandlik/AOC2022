function solve()
    ls = readlines("22.in")
    M = 50
    A = fill(' ', 6, M, M)
    A[1, :, :] = reduce(hcat, map(l -> collect(l[51:100]), ls[1:50])) |> permutedims
    A[2, :, :] = reduce(hcat, map(l -> collect(l[101:150]), ls[1:50])) |> permutedims
    A[3, :, :] = reduce(hcat, map(l -> collect(l[51:100]), ls[51:100])) |> permutedims
    A[4, :, :] = reduce(hcat, map(l -> collect(l[1:50]), ls[101:150])) |> permutedims
    A[5, :, :] = reduce(hcat, map(l -> collect(l[51:100]), ls[101:150])) |> permutedims
    A[6, :, :] = reduce(hcat, map(l -> collect(l[1:50]), ls[151:200])) |> permutedims

    DMAP = Dict('>' => 0, 'v' => 1, '<' => 2, '^' => 3)
    T = Dict{Tuple{Int, Int}, Tuple{Int, Int, Function}}()
    T[(1, DMAP['>'])] = (2, DMAP['>'], (i, j) -> (i, 1))
    T[(1, DMAP['v'])] = (3, DMAP['v'], (i, j) -> (1, j))
    T[(1, DMAP['<'])] = (4, DMAP['>'], (i, j) -> (M - i + 1, 1))
    T[(1, DMAP['^'])] = (6, DMAP['>'], (i, j) -> (j, 1))
    T[(2, DMAP['>'])] = (5, DMAP['<'], (i, j) -> (M - i + 1, M))
    T[(2, DMAP['v'])] = (3, DMAP['<'], (i, j) -> (j, M))
    T[(2, DMAP['<'])] = (1, DMAP['<'], (i, j) -> (i, M))
    T[(2, DMAP['^'])] = (6, DMAP['^'], (i, j) -> (M, j))
    T[(3, DMAP['>'])] = (2, DMAP['^'], (i, j) -> (M, i))
    T[(3, DMAP['v'])] = (5, DMAP['v'], (i, j) -> (1, j))
    T[(3, DMAP['<'])] = (4, DMAP['v'], (i, j) -> (1, i))
    T[(3, DMAP['^'])] = (1, DMAP['^'], (i, j) -> (M, j))
    T[(4, DMAP['>'])] = (5, DMAP['>'], (i, j) -> (i, 1))
    T[(4, DMAP['v'])] = (6, DMAP['v'], (i, j) -> (1, j))
    T[(4, DMAP['<'])] = (1, DMAP['>'], (i, j) -> (M - i + 1, 1))
    T[(4, DMAP['^'])] = (3, DMAP['>'], (i, j) -> (j, 1))
    T[(5, DMAP['>'])] = (2, DMAP['<'], (i, j) -> (M - i + 1, M))
    T[(5, DMAP['v'])] = (6, DMAP['<'], (i, j) -> (j, M))
    T[(5, DMAP['<'])] = (4, DMAP['<'], (i, j) -> (i, M))
    T[(5, DMAP['^'])] = (3, DMAP['^'], (i, j) -> (M, j))
    T[(6, DMAP['>'])] = (5, DMAP['^'], (i, j) -> (M, i))
    T[(6, DMAP['v'])] = (2, DMAP['v'], (i, j) -> (1, j))
    T[(6, DMAP['<'])] = (1, DMAP['v'], (i, j) -> (1, i))
    T[(6, DMAP['^'])] = (4, DMAP['^'], (i, j) -> (M, j))

    for ((f, d), (nf, nd, c)) in T
        @assert T[(nf, mod(nd-2, 4))][1:2] == (f, mod(d-2, 4))
        for k in 1:M
            i = d == DMAP['^'] ? 1 : (d == DMAP['v'] ? M : k)
            j = d == DMAP['<'] ? 1 : (d == DMAP['>'] ? M : k)
            @assert T[(nf, mod(nd-2, 4))][3](c(i, j)...) == (i, j)
        end
    end

    I = ls[end]
    f, i, j, d = 1, 1, 1, 0
    ii = 1
    while ii ≤ length(I)
        jj = ii
        while jj ≤ length(I) && I[jj] ∉ ['L', 'R']
            jj += 1
        end
        s = parse(Int, I[ii:jj-1])
        while s > 0
            di = d == 1 ? 1 : (d == 3 ? -1 : 0)
            dj = d == 0 ? 1 : (d == 2 ? -1 : 0)
            if !(1 ≤ i + di ≤ M && 1 ≤ j + dj ≤ M)
                nf, nd, c = T[(f, d)]
                ni, nj = c(i, j)
                if A[nf, ni, nj] == '#'
                    break
                else
                    f, i, j, d = nf, ni, nj, nd
                    s -= 1
                end
            elseif A[f, i + di, j + dj] == '#'
                break
            elseif A[f, i + di, j + dj] == '.'
                i, j = i + di, j + dj
                s -= 1
            end
        end

        if jj <= length(I)
            d = mod(d + (I[jj] == 'R' ? 1 : -1), 4)
        end
        ii = jj + 1
    end

    if f ∈ 4:5
        i += 2M
    elseif f == 3
        i += M
    elseif f == 6
        i += 3M
    end

    if f ∈ [1, 3, 5]
        j += M
    elseif f == 6
        j += 2M
    end

    return 1000 * i + 4 * j + d
end

solve() |> println
