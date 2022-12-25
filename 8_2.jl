function solve(forest)
    n, m = size(forest)
    res = ones(Int, n, m)
    for i in 1:n, j in 1:m
        k = j + 1; x = forest[i, j]
        while(k <= m && forest[i, k] < x) k += 1 end
        k = min(k, m)
        res[i, j] *= k - j

        k = j - 1; x = forest[i, j]
        while(k > 0 && forest[i, k] < x) k -= 1 end
        k = max(k, 1)
        res[i, j] *= j - k

        k = i + 1; x = forest[i, j]
        while(k <= n && forest[k, j] < x) k += 1 end
        k = min(k, n)
        res[i, j] *= k - i

        k = i - 1; x = forest[i, j]
        while(k > 0 && forest[k, j] < x) k -= 1 end
        k = max(k, 1)
        res[i, j] *= i - k
    end
    maximum(res[2:end-1, 2:end-1])
end

hcat(map(l -> parse.(Int, l), collect.(readlines("8.in")))...) |> solve
