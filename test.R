stateData <- read.csv("D:/MBA Journey/2016 - Summer Project/Learning R/Udacity Course/lesson2/stateData.csv", stringsAsFactors = F)
summary(stateData)
str(stateData)
names(stateData)

library(ggplot2)
reddit <- read.csv("D:/MBA Journey/2016 - Summer Project/Learning R/Udacity Course/lesson2/reddit.csv")
str(reddit)
qplot(data = reddit, x = age.range)
reddit$age.range <- factor(reddit$age.range, levels = c("Under 18","18-24","25-34","35-44","45-54","55-64","65 or above","NA"), ordered = T)
head(reddit$age.range, 10)


sadadlllll