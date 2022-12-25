using Base.Iterators, DataStructures

const SHAPES = map([
    """
    ####
    """,
    """
    .#.
    ###
    .#.
    """,
    """
    ###
    ..#
    ..#
    """,
    """
    #
    #
    #
    #
    """,
    """
    ##
    ##
    """
]) do m
    '#' .== permutedims(hcat(filter(!isempty, collect.(split(m, '\n')))...))
end

function solve()
    dirs = readlines("17.in") |> only
    A = fill('.', 100000, 9)
    A[1, :] .= '-'
    A[:, 1] .= '|'
    A[:, end] .= '|'
    A[1, 1] = A[1, end] = '+'

    states = Dict{Tuple{Int, Int, Set{Tuple{Int, Int}}},
                Tuple{Int, Int}}()
    l = 1
    L = 0
    si = di = 0
    # G = 2022
    G = 1000000000000
    while si < G
        s = SHAPES[1 + (si % length(SHAPES))]
        x, y = l + 4, 4

        while true
            d = dirs[1 + (di % length(dirs))]; di += 1
            nx, ny = x, y + (d == '<' ? (-1) : 1)
            if all(A[nx:(nx+size(s,1)-1), ny:(ny+size(s,2)-1)][s] .== '.')
                x, y = nx, ny
            end

            nx, ny = x - 1, y
            all(A[nx:(nx+size(s,1)-1), ny:(ny+size(s,2)-1)][s] .== '.') || break
            x, y = nx, ny
        end
        for dx in 1:size(s, 1), dy in 1:size(s, 2)
            if s[dx, dy]
            A[x + dx - 1, y + dy - 1] = '#'
            end
        end
        l = max(l, x + size(s, 1) - 1)

        q = Queue{Tuple{Int, Int}}()
        v = Set{Tuple{Int, Int}}()
        foreach(2:8) do y
            if A[l, y] == '.'
                enqueue!(q, (0, y))
                push!(v, (0, y))
            end
        end
        while !isempty(q)
            x, y = dequeue!(q)
            for (dx, dy) in [(x-1, y), (x, y-1), (x, y+1)]
                if A[l+dx, dy] == '.' && (dx, dy) ∉ v
                    enqueue!(q, (dx, dy))
                    push!(v, (dx, dy))
                end
            end
        end
        k = (si % length(SHAPES), di % length(dirs), v)
        if haskey(states, k)
            osi, ol = states[k]
            rep = (G - si) ÷ (si - osi)
            L += rep * (l - ol)
            si += rep * (si - osi)
        else
            states[k] = (si, l)
        end
        si += 1
    end
    l + L - 1
end

solve() |> println
