function solve()
    A = enumerate(parse.(Int, readlines("20.in"))) |> collect
    for I in eachindex(A)
        i = findfirst(first.(A) .== I)
        j = 1 + mod(i + A[i][2] - 1, length(A) - 1)
        insert!(A, j, popat!(A, i))
    end
    j = findfirst(last.(A) .== 0)
    sum(i -> A[1 + mod(1000 * i + j - 1, length(A))][2], 1:3)
end

solve() |> println
