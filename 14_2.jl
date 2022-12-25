input = map(split.(readlines("14.in"), "->")) do l
    map(x -> tuple(parse.(Int, x)...), (split.(strip.(l), ",")))
end

minx = minimum(first.(vcat(input...)))
minx = min(500, minx)
miny = minimum(last.(vcat(input...)))
miny = min(0, miny)

maxx = maximum(first.(vcat(input...)))
maxx = max(500, maxx)
maxy = maximum(last.(vcat(input...)))
maxy = max(0, maxy)

A = fill('.', 1000, maxy - miny + 3)
A[:, end] .= '#'

for p in input, ((x1, y1), (x2, y2)) in zip(p, p[2:end])
    fromx = min(x1, x2) - minx + 501
    fromy = min(y1, y2) - miny + 1
    tox = max(x1, x2) - minx + 501
    toy = max(y1, y2) - miny + 1
    A[fromx:tox, fromy:toy] .= '#'
end

startx = 500 - minx + 501
starty = 0 - miny + 1
for i in 1:length(A)
    A[startx, starty] == '.' || (println(i-1); break)
    x, y = nx, ny = startx, starty
    while true
        if ny+1 <= size(A, 2)
            if A[nx, ny+1] == '.'
                ny += 1
                continue
            end
        else
            nx = ny = -1
            break
        end
        if nx-1 >= 1 && ny+1 <= size(A, 2)
            if A[nx-1, ny+1] == '.'
                nx -= 1
                ny += 1
                continue
            end
        else
            nx = ny = -1
            break
        end
        if nx+1 <= size(A, 1) && ny+1 <= size(A, 2)
            if A[nx+1, ny+1] == '.'
                nx += 1
                ny += 1
                continue
            end
        else
            nx = ny = -1
            break
        end
        A[nx, ny] = 'o'
        break
    end
    if nx == ny == -1
        println(i-1)
        break
    else
    end
end

# prod.(eachrow(permutedims(A)))
