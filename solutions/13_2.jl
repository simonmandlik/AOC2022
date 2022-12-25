ls = eval.(Meta.parse.(filter(!isempty, readlines("13.in"))))
push!(ls, [[2]])
push!(ls, [[6]])

comp(x::Vector, y::Int) = comp(x, [y])
comp(x::Int, y::Vector) = comp([x], y)
comp(x::Int, y::Int) = x < y ? -1 : (x == y ? 0 : 1)
function comp(x::Vector, y::Vector)
    for i in 1:min(length(x), length(y))
        c = comp(x[i], y[i])
        c == 0 || return c
    end
    return length(x) < length(y) ? -1 : (length(x) == length(y) ? 0 : 1)
end
comp(xy) = comp(xy...)

sort!(ls, lt=(x, y) -> comp(x, y) == -1)

findfirst(map(==([[2]]), ls)) * findfirst(map(==([[6]]), ls))

# res = map(comp, Iterators.partition(ls, 2)) .== -1
# sum((1:length(res)) .* res)

