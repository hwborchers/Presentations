# Linear and multiplicative random number generators
# http://www.aaronschlegel.com/series/random-number-generation/

require(pracma)

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

randLcg <- function(n=1) {
  rng <- vector(mode = "numeric", length = n)
  m <- 2 ** 32
  a <- 1103515245  # NR: 1664525
  c <- 12345       # NR: 1013904223
  # Set the seed using the current system time in microseconds
  d <- as.numeric(Sys.time()) * 1000
  for (i in 1:n) {
    d <- (a * d + c) %% m
    rng[i] <- d / m
  }
  return(rng)
}

randLcg2 <- function(n=1) {
  rng <- vector(mode = "numeric", length = n)
  a1 <- 40014
  m1 <- 2147483563
  a2 <- 40692
  m2 <- 2147483399

  # Seed the two MCGs
  y1 <- randLehmer()    # random integer in [1, m1-1]
  y2 <- randLehmer()    # random integer in [1, m2-1]

  for (i in 1:n) {
    y1 <- a1 * y1 %% m1
    y2 <- a2 * y2 %% m2
    x <- (y1 - y2) %% (m1 - 1)
    if (x > 0) {
      rng[i] <- x / m1
    }
    else if (x < 0) {
      rng[i] <- (x / m1) + 1
    }
    else if (x == 0) {
      rng[i] <- (m1 - 1) / m1
    }
  }
  return(rng)
}



