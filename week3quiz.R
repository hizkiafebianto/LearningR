#title           :week3quiz.R
#description     :This is a quiz file from week 3 lessons.
#author		       :Hizkia Febianto
#date            :20170616


###QUESTION 1###
data(iris)
?iris
summary(iris)
tapply(iris$Sepal.Length,iris$Species,mean)

###QUESTION 2###
apply(iris[,1:4],2,mean)

###QUESTION 3###
data("mtcars")
tapply(mtcars$mpg,mtcars$cyl,mean)
with(mtcars,tapply(mpg,cyl,mean))
sapply(split(mtcars$mpg,mtcars$cyl),mean)

###QUESTION 4###
#What is the absolute difference between the average HP of 4-cyl cars
#and the average horsepower of 8-cyl cars
m <- sapply(split(mtcars$hp,mtcars$cyl), mean)
m[["8"]]-m[["4"]]

###QUESTION 5###
#If you run debug(ls), what happens when you run the ls function?
debug(ls)
ls()
