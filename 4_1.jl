count(split.(readlines("4.in"), ",")) do (a, b)
    ra = UnitRange(parse.(Int, split(a, "-"))...)
    rb = UnitRange(parse.(Int, split(b, "-"))...)
    ra ⊆ rb || rb ⊆ ra
end

