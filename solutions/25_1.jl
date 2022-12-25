const ENC = Dict(-2 => '=', -1 => '-', 0 => '0', 1 => '1', 2 => '2')
const DEC = Dict(reverse.(collect(ENC)))

snafu2dec(snafu) = sum(DEC[x] * 5 ^ (i-1) for (i, x) in enumerate(reverse(snafu)))

function dec2snafu(dec)
    snafu = ""
    while dec > 0
        dec, r = divrem(dec, 5)
        if r > 2
            r -= 5
            dec += 1
        end
        snafu *= ENC[r]
    end
    isempty(snafu) ? "0" : reverse(snafu)
end

function solve()
    sum(snafu2dec, readlines("25.in")) |> dec2snafu
end

solve() |> println
