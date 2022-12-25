ls = readlines("6.in") |> only |> collect
3 + findfirst(allunique.(zip((ls[i:end] for i in 1:4)...)))

