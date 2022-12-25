using DataStructures: Deque

ls = readlines("5.in")
i = findfirst(l -> l[1:2] == " 1", ls)
n = length(split(ls[i]))
ss = [filter(!isspace, getindex.(ls[1:i-1], 2 + (j-1)*4)) for j in 1:n]
ss = map(ss) do s
    d = Deque{Char}()
    foreach(x -> push!(d, x), s)
    d
end
foreach(ls[i+2:end]) do l
    n, i, j = parse.(Int, (split(l)[[2, 4, 6]]))
    for _ in 1:n
        pushfirst!(ss[j], popfirst!(ss[i]))
    end
end
join(first.(ss))

