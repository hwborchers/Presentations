# Linear and multiplicative random number generators
randLehmer <- function(n=1, d = as.numeric(Sys.time())) {
    # d must be coprime to m (which is prime)
    rng <- vector(mode = "numeric", length = n)
    m <- 2147483647   # m = 2^31 - 1 
    a <- 48271
    q <- 44488        # q = m/a
    r <- 3399         # r = m mod a
    for (i in 1:n) {
        h <- d / q
        l <- d %% q
        t <- a * l - r * h
        if (t < 0) {
            d <- t + m
        } else if (t > 0) {
            d <- t
        } else {
            d <- m - 1
        }
        rng[i] <- d / m  # as a uniform random number in [0, 1]
    }
    return(rng)
}

# USAGE:
seed <- qrandom::qrandomunif(n = 100, a = 0, b = 1)
knuth <- randTAoCP(seed)
N <- 3000; r <- numeric(N)
for (i in 1:N) r[i] <- knuth()
hist(r)

# library(scatterplot3d)
R <- matrix(r, nrow = 3)
x <- R[1, ]; y <- R[2, ]; z <- R[3, ]
scatterplot3d(x, y, z, pch='.', color="darkblue", cex.symbols=4)

randTAoCP <- function(seed) {
    if (length(seed) != 100)
        stop("'seed' must provide 100 numbers in ]0,1[.")
    local({
        R <- vector(mode = "numeric", length = 2000)
        R[1:100] <- c(seed)
        for (k in 101:2000)
            R[k] <- (R[k-37] + R[k-100]) %% 1
        k <- 2000; i <- 2000 - 37; j <- 2000 - 100
        frand <- function() {
            k <<- (k %% 2000) + 1
            i <<- (i %% 2000) + 1
            j <<- (j %% 2000) + 1
            z <- (R[i] + R[j]) %% 1
            R[k] <<- z
            return(z)
        }
        return(frand)
    })
}
