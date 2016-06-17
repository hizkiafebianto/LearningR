#title           :week3.R
#description     :This is a practice file from week 3 lessons.
#author		       :Hizkia Febianto
#date            :20170615


###LOOP FUNCTIONS: LAPPLY###
x <- list(a = 1:5, b=rnorm(10))
lapply(x,mean)
#$a
#[1] 3
#$b
#[1] 0.1229517

#anonymous function
#We want to extract the value in the first column from each matrix
x <- list(a = matrix(1:4,2,2), b = matrix(1:6,3,2))
lapply(x, function(f) f[,1]) #function f is created on the spot

#sapply will try to simplify the result of lapply if possible
#If the result is a list where every element is length 1, then a vector is returned
#If the result is a list where every element is a vector of the same length (>1), a matrix is returned
#if not possible, a list is returned
x <- list(a = 1:5, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
sapply(x,mean)
lapply(x,mean)


###LOOP FUNCTIONS: APPLY###
#apply is used to evaluate a function over the margins of an array
x <- matrix(rnorm(200),20,10)
apply(x,2,mean) 
#margin=2 means operation on columns
#the function above gives us a vector containing mean of each column
apply(x,1,sum) #add each row

x <- array(rnorm(2*2*10),c(2,2,10)) #an array with 3 dimension
apply(x,c(1,2),mean) #find average over the third dimension, preserve dimension #1 and #2


###LOOP FUNCTIONS: MAPPLY###
#applies a function in parallel over a set of argument
mapply(rep,1:4,4:1) #similar results as list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))

noise<-function(n,mean,sd){
  rnorm(n,mean,sd)
}
noise(5,1,2)
mapply(noise,1:5,1:5,2)


###LOOP FUNCTIONS: TAPPLY###
x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)
tapply(x,f,mean)


###LOOP FUNCTIONS: SPLIT###
x <- c(rnorm(10),runif(10),rnorm(9,1))
f <- gl(3,10)
split(x,f)
lapply(split(x,f), mean)

s <- split(airquality,airquality$Month)
split(airquality,as.factor(c(1,1,2,2,3,4,4,4,4)))
lapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")], na.rm = TRUE))


