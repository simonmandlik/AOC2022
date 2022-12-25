function solve()
    input = map(x -> parse.(Int, x), split.(readlines("18.in"), ","))
    res = 6 * length(input)
    for i in 1:length(input), j in (i+1):length(input)
        if sum(input[i] .== input[j]) == 2 && abs(sum(input[i]) - sum(input[j])) == 1
            res -= 2
        end
    end

    res
end

solve() |> println
