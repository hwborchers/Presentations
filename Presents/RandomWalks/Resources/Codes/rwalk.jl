rwalk = function(N, M)
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
end


