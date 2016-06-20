#title           :progassign3.R
#description     :This is a script of the programming assignment3
#author		       :Hizkia Febianto
#date            :20170619


###PART 1###
# Setting the working directory
setwd("D:/MBA Journey/2016 - Summer Project/Coursera R Course")

# Loading dataset
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")

# Examining the dataset
str(outcome)
summary(outcome)

# Checking column names
names(outcome)

# Creating a histogram of the 30-day death rates from heart attack 
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

###PART 2###
# This function reads the data file and returns a character vector with the name of the hospital
# that has the best 30-day mortaliity rate for the specified outcome and state.
best <- function(state,outcome){
  ## read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
  
  ## check that state and outcome are valid
  states <- unique(df$State)
  cond <- c("heart attack","heart failure","pneumonia","Heart Attack","Heart Failure","Pneumonia")
  if(!(state %in% states)){
    stop("Invalid State!")
  } else if(!(outcome %in% cond)){
    stop("Invalid Outcome!")
  }
  
  result <- c()
  
  ## Return hospital name in that state with lowest 30-day death rate
  if(outcome == "heart attack" | outcome == "Heart Attack"){
    state.df <- df[df$State==state,]
    min.val <- state.df[which.min(state.df[,11]),11]
    all.min <- which(state.df[,11]==min.val)
    result <- state.df[all.min,"Hospital.Name"]
  } else if(outcome == "heart failure" | outcome == "Heart Failure"){
    state.df <- df[df$State==state,]
    min.val <- state.df[which.min(state.df[,17]),17]
    all.min <- which(state.df[,17]==min.val)
    result <- state.df[all.min,"Hospital.Name"]
  } else{
    state.df <- df[df$State==state,]
    min.val <- state.df[which.min(state.df[,23]),23]
    all.min <- which(state.df[,23]==min.val)
    result <- state.df[all.min,"Hospital.Name"]
  }
  
  result
}

# Test function
best("MD","pneumonia")


###PART 3###
# This function reads the data file and returns a character vector with the name
# of the hospital that has the ranking specified by the num argument
rankhospital <- function(state, outcome, num='best'){
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
  
  ## Check that state and outcome are valid
  states <- unique(df$State)
  cond <- c("heart attack","heart failure","pneumonia","Heart Attack","Heart Failure","Pneumonia")
  if(!(state %in% states)){
    stop("Invalid State!")
  } else if(!(outcome %in% cond)){
    stop("Invalid Outcome!")
  }
  
  result <- c(NA)
  
  ## Return hospital name in that state with the given rank 30-day death rate
  if(outcome == "heart attack" | outcome == "Heart Attack"){
    state.df <- df[df$State==state,]
    idx.order <- order(as.numeric(state.df[,11]),state.df$Hospital.Name,na.last = TRUE)
    ordered <- state.df[idx.order,11]
  } else if(outcome == "heart failure" | outcome == "Heart Failure"){
    state.df <- df[df$State==state,]
    idx.order <- order(as.numeric(state.df[,17]),state.df$Hospital.Name,na.last = TRUE)
    ordered <- state.df[idx.order,17]
  } else{
    state.df <- df[df$State==state,]
    idx.order <- order(as.numeric(state.df[,23]),state.df$Hospital.Name,na.last = TRUE)
    ordered <- state.df[idx.order,23]
  }
  
  
  if(num == "best"){
    result <- state.df[idx.order[1],"Hospital.Name"]
  } else if(num == "worst"){
    result <- state.df[idx.order[length(na.omit(ordered))],"Hospital.Name"]
  } else{
    if(as.numeric(num) > 0 & as.numeric(num) < length(na.omit(ordered))){
      result <- state.df[idx.order[num],"Hospital.Name"]
    }
  }
  
  result
}

# Test function
rankhospital("TX","heart failure",4)


###PART 4###
# This function returns a 2-column data frame containing the hospital in each
# state that has the ranking specified in num
rankall <- function(outcome,num='best'){
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
  
  ## Check that outcome are valid
  cond <- c("heart attack","heart failure","pneumonia","Heart Attack","Heart Failure","Pneumonia")
  if(!(outcome %in% cond)){
    stop("Invalid Outcome!")
  }
  
  ## For each state, find the hospital of the given rank
  statewise <- split(df,df$State)
  
  
  ## Return a data frame with the hospital names and the state name
  hosp.list <- sapply(statewise,function(x){
    rankhospital(x$State[1],outcome,num)
  })
  
  data.frame(hospital = hosp.list, states = names(hosp.list))
  
}

# Test function
rankall("heart attack",20)
rankall("pneumonia","worst")
rankall("heart failure")



