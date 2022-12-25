const Y = 2000000
coords = map(split.(readlines("15.in"), ":")) do (s, b)
    xs, ys = parse.(Int, last.(split.(split(s[11:end], ", "), "=")))
    xb, yb = parse.(Int, last.(split.(split(b[23:end], ", "), "=")))
    (xs, ys), (xb, yb)
end
ints = map(coords) do ((xs, ys), (xb, yb))
    r = abs(xs - xb) + abs(ys - yb) - abs(ys - Y)
    (xs - r):(xs + r)
end
bs = filter(last.(coords)) do (x, y)
    y == Y
end .|> first
setdiff(union(ints...), bs) |> length
