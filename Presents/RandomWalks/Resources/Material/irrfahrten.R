# Irrfahrten und ihre Konsequenzen

## First version

library(dqrng)
dqset.seed(7531)

N <- 10000                    # no. of random walks
rwLength <- numeric(N)        # vector of rw lengths

x <- 0; y <- 0                # starting values
ys <- cs(0)                   # full rw recorded
i <- 1                        # and counting
while (i <= N) {
    k <- max(2, abs(y))       # no. of necessary steps
    rw <- ifelse(dqrunif(k) <= 0.5, -1, 1)
    pos <- y + sum(rw)
    if (pos == 0) {
        rwLength[i] <- x + k
        x <- 0; y <- 0
        ys <- c(0)
        i <- i + 1
    } else {
        x <- x + k
        y <- pos
    }
}


## Second version

library(dqrng)
dqset.seed(7531)

M <- 10^8  # no. of uniform random numbers
m <- dqrunif(M)
rw <- ifelse(m <= 0.5, -1, 1)
Rw <- cumsum(rw)
is <- which(Rw == 0)
M - is[length(is)]

rwLength <- diff(c(0, is))  # length 4723
r <- rle(sort(rwLength))
x <- r$values
y <- cumsum(res$lengths/sum(res$lengths))
plot(x[1:260], y[1:260], type='l', col="darkblue")
abline(h=0.975); grid()

## plot the rw no. k = 5
k <- 511
i1 <- sum(rwLength[1:(k-1)]); i2 <- i1 + rwLength[k]
plot(Rw[i1:i2], type="s", col="darkgray", lwd=1); grid()
