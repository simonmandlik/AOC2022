using DataStructures

function solve()
    input = map(x -> tuple(parse.(Int, x)...), split.(readlines("18.in"), ",")) |> Set
    M = maximum(maximum(input))
    m = minimum(minimum(input))

    res = 0

    q = Queue{Tuple{Int, Int, Int}}()
    v = Set{Tuple{Int, Int, Int}}()
    enqueue!(q, (m - 1, m - 1, m - 1))
    push!(v, (m - 1, m - 1, m - 1))

    while !isempty(q)
        x, y, z = dequeue!(q)
        for (a, b, c) in [
            (x + 1, y, z),
            (x - 1, y, z),
            (x, y + 1, z),
            (x, y - 1, z),
            (x, y, z + 1),
            (x, y, z - 1)
        ]
            if max(a, b, c) > M + 2 || min(a, b, c) < m - 2
                continue
            elseif (a, b, c) ∈ input
                res += 1
            elseif (a, b, c) ∉ v
                push!(v, (a, b, c))
                enqueue!(q, (a, b, c))
            end
        end
    end

    res
end

solve() |> println
