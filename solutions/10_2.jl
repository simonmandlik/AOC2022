function solve()
    X = 1; c = 0
    function draw()
        print(abs(X-c) < 2 ? '#' : '.')
        c += 1
        if mod(c, 40) == 0
            c = 0
            println()
        end
    end
    foreach(readlines("10.in")) do l
        if l == "noop"
            draw()
        else
            draw()
            draw()
            X += parse(Int, l[6:end])
        end
    end
end

solve()
