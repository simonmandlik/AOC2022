sum(Iterators.partition(readlines("3.in"), 3)) do ls
    ch = only(intersect(ls...))
    ch - (isuppercase(ch) ? '&' : '`')
end

