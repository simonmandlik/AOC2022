using DataStructures

function solve()
    A = hcat(collect.(readlines("12.in"))...)
    D = fill(typemax(Int), size(A))
    V = falses(size(A))
    S = Tuple(findfirst(A .== 'S'))
    E = Tuple(findfirst(A .== 'E'))
    A[S...] = 'a'
    A[E...] = 'z'
    D[S...] = 0
    V[S...] = true
    q = Queue{typeof(S)}()
    enqueue!(q, S)

    while !isempty(q)
        x, y = dequeue!(q)
        for (dx, dy) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
            a, b = x + dx, y + dy
            checkbounds(Bool, A, a, b) || continue
            A[a, b] - A[x, y] ≤ 1 || continue
            if (a, b) == E
                return 1 + D[x, y]
            end
            V[a, b] && continue
            V[a, b] = true
            D[a, b] = 1 + D[x, y]
            enqueue!(q, (a, b))
        end
    end
end

solve()

