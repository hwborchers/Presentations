library(JuliaCall)
julia_setup()

julia_command("rwalk = function(N, M)
    result = zeros(Int, N)
    for i in 1:N
        steps = 2
        rand() >= 0.5 ?  a = 1 : a = -1
        rand() >= 0.5 ? a += 1 : a -= 1
        while a != 0
            steps += 2
            rand() >= 0.5 ? a += 1 : a -= 1
            rand() >= 0.5 ? a += 1 : a -= 1
            if steps >= M
                break
            end
        end
        result[i] = steps
    end
    return result
end; ")

julia_command("rw = rwalk(10, 10);")
system.time(julia_eval("nosteps = rwalk(1000000, 10000)"))
no_steps <- julia_eval("nosteps")

no_s <- rle(sort(no_steps))
stps <- no_s$values
prob <- no_s$length / 1000000  # M
ind <- min(which(cumsum(prob) >= 0.99))
stps[ind]
