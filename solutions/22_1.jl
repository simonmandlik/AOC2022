function solve()
    ls = readlines("22.in")
    i = findfirst(isempty, ls)
    M = maximum(length, ls[1:i-1])
    A = reduce(hcat, map(l -> collect(l * (" " ^ (M - length(l)))), ls[1:i-1])) |> permutedims

    I = ls[end]
    i, j, d = 1, findfirst(A[1, :] .== '.'), 0
    ii = 1
    while ii ≤ length(I)
        jj = ii
        while jj ≤ length(I) && I[jj] ∉ ['L', 'R']
            jj += 1
        end
        s = parse(Int, I[ii:jj-1])
        di = d == 1 ? 1 : (d == 3 ? -1 : 0)
        dj = d == 0 ? 1 : (d == 2 ? -1 : 0)
        while s > 0
            if !(1 ≤ i + di ≤ size(A, 1) && 1 ≤ j + dj ≤ size(A, 2)) || A[i + di, j + dj] == ' '
                ni = 1 + mod(i + di - 1, size(A, 1))
                nj = 1 + mod(j + dj - 1, size(A, 2))
                while A[ni, nj] == ' '
                    ni = 1 + mod(ni + di - 1, size(A, 1))
                    nj = 1 + mod(nj + dj - 1, size(A, 2))
                end
                if A[ni, nj] == '#'
                    break
                else
                    i, j = ni, nj
                    s -= 1
                end
            elseif A[i + di, j + dj] == '#'
                break
            elseif A[i + di, j + dj] == '.'
                i, j = i + di, j + dj
                s -= 1
            end
        end

        if jj <= length(I)
            d = mod(d + (I[jj] == 'R' ? 1 : -1), 4)
        end
        ii = jj + 1
    end
    return 1000 * i + 4 * j + d
end

solve() |> println
