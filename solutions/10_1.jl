function solve()
    X = c = 1
    res = 0
    foreach(readlines("10.in")) do l
        if l == "noop"
            if mod(c-20, 40) == 0
                res += c * X
            end
            c += 1
        else
            if mod(c-20, 40) == 0
                res += c * X
            end
            c += 1
            if mod(c-20, 40) == 0
                res += c * X
            end
            c += 1
            X += parse(Int, l[6:end])
        end
    end
    res
end

solve()
