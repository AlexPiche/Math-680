RFG <- function(i){
  print(i)
  p <- 10
  r <- rexp(n = 1, rate = 0.5)
  pl <- min(floor(1.5 + r), p)

  x <- rnorm(p)

  d <- (runif(pl, min = 0.1, max = 2.0))^2
  if(length(d) == 1) d <- as.matrix(d)
  Dl <- diag(d)
  Ul <- bootSVD::genQ(n = pl)
  Vl <- Ul %*% Dl %*% t(Ul)


  gl <- function(zl){
    mul <- rnorm(pl)
    exp(-0.5 * t(zl - mul) %*% Vl %*% (zl - mul))
  }

  al <- runif(20, min = -1, max = 1)

  xx <- rep(0, 20)
  
  for(i in 1:20){
    Wl <- sample(x = 1:p)
    zl <- x[Wl[1:pl]]
    xx[i] <- gl(zl)
  }
  
  f <- t(al) %*% xx
  y <- f + rnorm(1)

  toRet <- data.frame(y, t(x))
  toRet
}

kk[] <- parallel::mclapply(1:100, RFG)
kk <- as.data.frame(do.call(rbind, kk))
