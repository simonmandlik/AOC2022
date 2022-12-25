ls = readlines("5.in")
i = findfirst(l -> l[1:2] == " 1", ls)
n = length(split(ls[i]))
ss = [filter(!isspace, getindex.(ls[1:i-1], 2 + (j-1)*4)) for j in 1:n]
foreach(ls[i+2:end]) do l
    n, i, j = parse.(Int, (split(l)[[2, 4, 6]]))
    ss[j] = vcat(ss[i][1:n], ss[j])
    deleteat!(ss[i], 1:n)
end
join(first.(ss))

