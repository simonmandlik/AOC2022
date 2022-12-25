function visible(a)
    r, m = falses(length(a)), -1
    for (i, x) in a |> enumerate
        r[i] = x > m
        m = max(x, m)
    end
    return r
end

function solve(forest)
    res = falses(size(forest))
    for i in 1:size(forest, 1)
        res[i, :] .|= visible(forest[i, :])
        res[i, end:-1:1] .|= visible(reverse(forest[i, :]))
    end
    for j in 1:size(forest, 2)
        res[:, j] .|= visible(forest[:, j])
        res[end:-1:1, j] .|= visible(reverse(forest[:, j]))
    end
    count(res)
end

hcat(map(l -> parse.(Int, l), collect.(readlines("8.in")))...) |> solve
