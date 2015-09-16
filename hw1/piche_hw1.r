rm(list=ls())


multiRFG <- function(p = 10, n = 100){
	print("hello world")
  x <- matrix(rnorm(p*n), nrow = n, byrow = T)


  gl <- function(zl, mul, Vl){
    exp(-0.5 * t(zl - mul) %*% Vl %*% (zl - mul))
  }

  pl <- rep(0, 20)
  Wl <- matrix(0, nrow = p, ncol = 20)
  mul <- matrix(0, nrow = p, ncol = 20)

  Vl <- list()
  
  for(i in 1:20){
    r <- rexp(n = 1, rate = 0.5)
    pl[i] <- min(floor(1.5 + r), p)
    Wl[, i] <- sample(x = 1:p)
    mul[, i] <- rnorm(p)

    d <- (runif(pl[i], min = 0.1, max = 2.0))^2
    if(length(d) == 1) d <- as.matrix(d)
    Dl <- diag(d)
    Ul <- bootSVD::genQ(n = pl[i])
    Vl[[i]] <- Ul %*% Dl %*% t(Ul)
  }

  al <- runif(20, min = -1, max = 1)
  RFG <- function(x){
    zl <- matrix(0, nrow = 10, ncol = 20)
    glzl <- rep(0, 20)
    for(i in 1:20){
      print(x[i])
      print(Wl[1:pl[i]])
      zl <- x[Wl[1:pl[i]]]
      glzl[i] <- gl(zl, mul[1:pl[i], i], Vl[[i]])
    }
    f <- al %*% glzl
    f
  }

  y <- rep(0, 100)
  for(i in 1:100){
    y[i] <- RFG(x[i,]) + rnorm(1)
  }

  toRet <- data.frame(y, x)
  toRet
}

myRFG <- multiRFG()
summary(myRFG)
