#title           :week1.R
#description     :This is a practice file from week 1 lessons.
#author		       :Hizkia Febianto
#date            :20170609


###Entering Input###
x<-1
print(x)
msg <- "Hello"
msg
#Printing a sequence
x <- 1:20 # a sequence of numbers from 1 to 20
x #Output: [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

###DATA TYPES: VECTORS AND LISTS###
x <- c(0.5,0.6)
x
#Output: [1] 0.5 0.6
x <- vector("logical",10)
x
# [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

#Coercion
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

#Lists
x <- list(1,"a",TRUE,1+4i)
x

###DATA TYPES: MATRICES###
m <- matrix(data = 1:20,nrow = 4,ncol = 5)
m
#Matrices are constructed column-wise
#Output:
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    5    9   13   17
#[2,]    2    6   10   14   18
#[3,]    3    7   11   15   19
#[4,]    4    8   12   16   20
dim(m)

#Transforming a vector into a matrix
m<-1:10
m
#[1]  1  2  3  4  5  6  7  8  9 10
dim(m)<-c(2,5)
m
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    3    5    7    9
#[2,]    2    4    6    8   10

#Creating a matrix with cbind() and rbind()
x <- c(1,2,3)
y <- c("a","b","c")
cbind(x,y)
#      x   y  
#[1,] "1" "a"
#[2,] "2" "b"
#[3,] "3" "c"
rbind(x,y)

###DATA TYPES: FACTORS###
x<-factor(c("yes","yes","no","yes","no"))
x
table(x)
unclass(x)

###DATA TYPES: MISSING VALUES###
x<-c(1,2,NaN,NA,4)
is.na(x)
is.nan(x)

###DATA TYPES: DATA FRAMES###
x<-data.frame(foo=1:4, bar=c(T,T,F,F))
x

###NAMES ATTRIBUTE###
#Vectors
x<-1:3
names(x)<-c("foo","bar","woof")
x
# foo  bar woof 
#  1    2    3 

#Lists
x<-list(a=1,b=2,c=3)
x

#Matrices
x<-matrix(data = 1:6,nrow = 2,ncol = 3)
dimnames(x) <- list(c("a","b"),c("x","y","z"))
x

###TEXTUAL DATA FORMAT###
#dput() can only be used in a single R object
y <- data.frame(a=c(1,2,5), b=c(2,3,4))
dput(y)
#structure(list(a = c(1, 2, 5), b = c(2, 3, 4)), .Names = c("a", 
#"b"), row.names = c(NA, -3L), class = "data.frame")
dput(y,file="y.R")
new.y <- dget("y.R")
new.y
#dump() is used for storing multiple R objects
x <- "foo"
y <- data.frame(a=c(1,2,5), b=c(2,3,4))
dump(c("x","y"), file = "data.R")
rm(x,y)
source("data.R")

###cONNECTIONS###
con<-url("http://www.wakastudio.com","r")
head(readLines(con),50)
close(con)

###SUBSETTING###
#Basic
x<-c("a","b","c","c","d","e")
x[1]
#[1] "a"
x[1:4]
#[1] "a" "b" "c" "c"
x[x>"a"]
#[1] "b" "c" "c" "d" "e"
u <- x>"a"
u
#[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
x[c(T,F,T,T)]
#[1] "a" "c" "c" "d"

#Subsetting Lists
x <- list(foo=1:4, alp = c("a","d"), rum = "Hello")
x[1]
#$foo
#[1] 1 2 3 4
x$alp
#[1] "a" "d"
x["alp"]
#$alp
#[1] "a" "d"
x[["alp"]]
#[1] "a" "d"
x[c(1,3)]
#$foo
#[1] 1 2 3 4
#$rum
#[1] "Hello"

x <- list(a=list(2,3,4), b=c("a","b","c"))
x[[1]][[1]]
x[[c(2,3)]]
#[1] "c"
x[c(2,3)]
#$b
#[1] "a" "b" "c"
#$<NA>
#  NULL

#Subsetting a matrix
x <- matrix(data=1:20,ncol = 4, nrow = 5)
x[1,2]
#[1] 6
x[2,]
#[1]  2  7 12 17
#Retaining the dimension when subsetting
x[2,,drop=FALSE]
#The output will be a 1x4 matrix
#     [,1] [,2] [,3] [,4]
#[1,]    2    7   12   17

###REMOVING NA VALUES###
x <- c(1,2,NA,4,NA,NA)
bad <- is.na(x)
x[!bad]
#[1] 1 2 4

airquality[1:6,]
good <- complete.cases(airquality)
airquality[good,][1:6,]

###VECTORIZED OPERATIONS###
#Vectors
x <- 1:3
y <- 5:7
x+y
#[1]  6  8 10
x/y

#Matrices
x<-matrix(1:4,2,2)
y<-matrix(rep(10,4),2,2)
x*y   ##elementwise multiplication
#     [,1] [,2]
#[1,]   10   30
#[2,]   20   40
x %*% y  ##true matrix multiplicatition
#     [,1] [,2]
#[1,]   40   40
#[2,]   60   60


###HOMEWORK###
x<- 1:4
y<- 2:3
class(x+y)

data
data <- read.csv("hw1_data.csv")
data[47,"Ozone"]
bad <- is.na(data["Ozone"])
sum(bad)
summary(data[!bad,])

summary(data[data$Ozone>31 & data$Temp > 90,])

summary(data[data$Month == 6,])

summary(data[data$Month == 5,])
