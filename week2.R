#title           :week2.R
#description     :This is a practice file from week 2 lessons.
#author		       :Hizkia Febianto
#date            :20170612


###CONTROL STRUCTURES: IF-ELSE###
x <- 2
#structure 1
if(x>3){
  y <- 10
} else{
  y <- 0
}

#structure 2
y <- if(x>3){10}else{0}


###CONTROL STRUCTURES: FOR-LOOPS###
for(i in 1:10){
  print(i)
}

x <- c("a","b","c","d")
for(i in 1:4) print(x[i])
for(i in seq_along(x)) print(x[i])
for(letters in x) print(letters)

x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    print(x[i,j])
  }
}

###CONTROL STRUCTURES: WHILE LOOPS###
count <- 0
while (count < 10){
  print(count)
  count <- count + 1
}


###CONTROL STRUCTURES: REPEAT###
count <- 0
repeat{
  if (count > 10) {
    break
  }
  else{
    print(count)
    count <- count + 1
  }
}

###CONTROL STRUCTURES: NEXT###
#next is used to skip an iteration
for(i in 1:25){
  if(i<=20){
    next   #skip the first 20 iterations
  }
  print(i)
}


###FUNCTIONS###
#exercise 1
add2 <- function(x,y){
  x+y
}
add2(5,3)

#exercise 2: acceoting a vector and returning values in the vector which are higher than n
above <- function(x,n){
  use <- x > n
  x[use]
}
x <- 1:20
above(x,10)

#exercise 3: setting a default value to n
above <- function(x,n=10){
  use <- x > n
  x[use]
}
x <- 1:20
above(x)

#exercise 4: take a matrix/data frame and calculate the mean of each column
columnmean <- function(y){
  m <- c()
  for(i in seq_len(ncol(y))){
    m <- append(m, mean(y[,i]))
  }
  m
}
columnmean(airquality)

#exercise 5: let's removeNA
columnmean <- function(y, removeNA = TRUE){
  m <- c()
  for(i in seq_len(ncol(y))){
    m <- append(m, mean(y[,i], na.rm = removeNA))
  }
  m
}
columnmean(airquality)

#The "..." argument indicates a variable number of arguments that are usually
#passed on to other functions
myplot <- function(x,y,type="1",...){
  plot(x,y,type = type, ...)
}
#The "..." argument is also necessary when the number of arguments passed to the function
#cannot be known in advance
args(paste)
#function (..., sep = " ", collapse = NULL) 
#Any argument that appears after the "..." argument must be named explicitly


###DATES AND TIMES###
#Dates are represented by the Date class
#Times are represented by the POSIXct or the POSIXlt class
x <- as.Date("2017-06-11")
x <- Sys.time() #Already in POSIXct format

#POSIXlt format
p1 <- as.POSIXlt(x)
names(unclass(p1))
#[1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"   "isdst"  "zone"   "gmtoff"

#POSIXct format
p2 <- as.POSIXct(x)
unclass(x)
#1465672409

#strptime function
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
#We tell strptime the format of date&time item
#Calculating time difference
x[1]-x[2]

