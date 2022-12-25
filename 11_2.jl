input = readlines("11.in")
items = map(xs -> parse.(BigInt, xs), split.([x[19:end] for x in input[2:7:end]], ","))
ops = [eval(Meta.parse("old -> " * x[20:end])) for x in input[3:7:end]]
divs = parse.(Int, [x[22:end] for x in input[4:7:end]])
as = parse.(Int, [x[29:end] for x in input[5:7:end]]) .+ 1
bs = parse.(Int, [x[30:end] for x in input[6:7:end]]) .+ 1
ct = zeros(Int, length(items))
v = lcm(divs...)

for _ in 1:10000
    for m in 1:length(items)
        while length(items[m]) > 0
            i = popfirst!(items[m])
            ct[m] += 1
            i = ops[m](i)
            i = mod(i, v)
            n = mod(i, divs[m]) == 0 ? as[m] : bs[m]
            push!(items[n], i)
        end
    end
end

prod(sort(ct)[end-1:end])
