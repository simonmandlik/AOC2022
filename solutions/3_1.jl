sum(readlines("3.in")) do l
    ch = only(intersect(l[1:length(l)÷2], l[1+length(l)÷2:end]))
    isuppercase(ch) ? ch - '&' : ch - '`'
end

