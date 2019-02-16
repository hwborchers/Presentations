library(V8)
js <- v8()

js$eval("
function rwalk(N, M) {
    var result = new Array(N)
    var a = 0, steps
    for (var i = 0; i < N; i++) {
        steps = 2
        if (Math.random() >= 0.5) {a = 1} else {a = -1}
        if (Math.random() >= 0.5) {++a} else {--a}
        while (a != 0) {
            steps += 2
            if (Math.random() >= 0.5) {++a} else {--a}
            if (Math.random() >= 0.5) {++a} else {--a}
            if (steps >= M) break
        }
        result[i] = steps
    }
    return result
}")

system.time(
    js$eval("
        var no_steps_JS
        no_steps_JS = rwalk(1000000, 20000)
        undefined")
)

no_steps_JS <- js$get("no_steps_JS")
no_steps_JS

no_s <- rle(sort(no_steps_JS))
stps <- no_s$values
prob <- no_s$length / 1000000  # M
ind <- min(which(cumsum(prob) >= 0.99))
stps[ind]
