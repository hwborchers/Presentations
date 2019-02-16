
myRand <- function(seed = as.numeric(Sys.time())) {
    local({
        R <- vector(mode = "numeric", length = 2000)
        R[1:100] <- randLehmer(100, seed)
        for (k in 101:2000)
            R[k] <- mod(R[k-37] + R[k-100], 1.0)
        k <- 2000; i <- 2000 - 37; j <- 2000 - 100
        frand <- function() {
            k <<- (k %% 2000) + 1
            i <<- (i %% 2000) + 1
            j <<- (j %% 2000) + 1
            z <- mod(R[i] + R[j], 1.0)
            R[k] <<- z
            return(z)
        }
        return(frand)
    })
}

zuza <- myRand(5689)
N = 10
x = numeric(N)
for (i in 1:N) 
    x[i] = zuza()
hist(x)
