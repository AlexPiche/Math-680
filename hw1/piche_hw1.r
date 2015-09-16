rm(list=ls())


RFG <- function(i, p =10){
  print(i+1)
  r <- rexp(n = 1, rate = 0.5)
  pl <- min(floor(1.5 + r), p)

  x <- rnorm(p)

  d <- (runif(pl, min = 0.1, max = 2.0))^2
  if(length(d) == 1) d <- as.matrix(d)
  Dl <- diag(d)
  Ul <- bootSVD::genQ(n = pl)
  Vl <- Ul %*% Dl %*% t(Ul)


  gl <- function(zl, mul){
    exp(-0.5 * t(zl - mul) %*% Vl %*% (zl - mul))
  }

  # should al be sample at each iterations
  al <- runif(20, min = -1, max = 1)

  glzl <- rep(0, 20)
  
  for(i in 1:20){
    Wl <- sample(x = 1:p)
    zl <- x[Wl[1:pl]]
    mul <- rnorm(pl)
    glzl[i] <- gl(zl, mul)
  }
  
  f <- t(al) %*% glzl
  y <- f + rnorm(1)

  toRet <- data.frame(y, t(x))
  toRet
}

multiRFG <- function(n = 100, p = 10){
  temp <- parallel::mclapply(1:n, RFG, p = p)
  temp <- as.data.frame(do.call(rbind, temp))
  temp
}

xx <- multiRFG()

#system.time(multiRFG())

