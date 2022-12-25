using Base.Iterators

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
    dirs = cycle(readlines("17.in") |> only)
    A = fill('.', 10000, 9)
    A[1, :] .= '-'
    A[:, 1] .= '|'
    A[:, end] .= '|'
    A[1, 1] = A[1, end] = '+'

    l = 1
    for s in take(cycle(SHAPES), 2022)
        x, y = l + 4, 4
        while true
            dir, dirs = Iterators.peel(dirs)
            nx, ny = x, y + (dir == '<' ? (-1) : 1)
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
    end
    l - 1
end

solve() |> println
