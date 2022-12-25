using DataStructures

function solve()
    A = hcat(collect.(readlines("12.in"))...)
    D = fill(typemax(Int), size(A))
    V = falses(size(A))
    S = Tuple(findfirst(A .== 'S'))
    E = Tuple(findfirst(A .== 'E'))
    A[S...] = 'a'
    A[E...] = 'z'
    D[E...] = 0
    V[E...] = true
    q = Queue{typeof(E)}()
    enqueue!(q, E)

    while !isempty(q)
        x, y = dequeue!(q)
        for (dx, dy) in [(0, 1), (0, -1), (1, 0), (-1, 0)]
            a, b = x + dx, y + dy
            checkbounds(Bool, A, a, b) || continue
            A[x, y] - A[a, b] ≤ 1 || continue
            if A[a, b] == 'a'
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

