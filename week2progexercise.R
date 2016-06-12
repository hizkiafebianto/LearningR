

pollutantmean <- function(directory, pollutant, id=1:332){
  #'directory' is a character vector of length 1 indicating the location of the CSV files
  
  #'pollutant' is a character vector of length 1 indicating the name of the pollutant for
  #which we will calculate the mean; either "sulfate" or "nitrate"
  
  #'id' is an integer vector indicating the monitor ID numbers to be used
  
  #Return the mean of the pollutant across all monitors list in the 'id' vector (ignoring
  #NA values)
  #NOTE: Do not round the result
  
  #Check directory and create a list of files
  sumValue <- 0
  n <- 0
  if(dir.exists(directory)){
    files <- list.files(directory)
  }
  
  #iterate through files based on IDs
  for(i in id){
    path <- paste(directory,"/",files[i], sep = "")
    tempDF <- read.csv(file.path(path),colClasses = c("Date","numeric","numeric","integer"))
    sumValue <- sumValue + sum(tempDF[pollutant], na.rm = T)
    n <- n + nrow(tempDF[which(!is.na(tempDF[pollutant])),])
  }
  
  #return
  sumValue/n
}

pollutantmean("specdata","nitrate",23)


complete <- function(directory,id=1:332){
  #'directory' is a character vector of length 1 indicating the location of the CSV files
 
  #'id' is an integer vector indicating the monitor ID numbers to be used
  
  #Return a data frame of the form:
  #id nobs
  # 1  117
  # 2 1041
  # ...
  #where 'id' is the monitor ID number and 'nobs' is the number of complete cases
  
  #Check directory and create a list of files
  n <- 0
  df <- data.frame()
  if(dir.exists(directory)){
    files <- list.files(directory)
  }
  
  #iterate through files based on IDs
  for(i in id){
    path <- paste(directory,"/",files[i], sep = "")
    tempDF <- read.csv(file.path(path),colClasses = c("Date","numeric","numeric","integer"))
    n <- sum(complete.cases(tempDF))
    df <- rbind(df,c(i,n))
  }
  
  #return
  names(df) <- c("id","nobs")
  df
}

complete("specdata",30:25)

corr <- function(directory, threshold = 0){
  #'directory' is a character vector of length 1 indicating the location of the CSV files
  
  #'threshold' is a numeric vector of length 1 indicating the number of completely observed
  #observations (on all variables) required to compute the correlation between nitrate and
  #sulfate; the default is 0
  
  #Return a numeric vector of correlations
  #NOTE: Do not round the result !
  
  #Check directory and create a list of files
  n <- 0
  correl <- c()
  if(dir.exists(directory)){
    files <- list.files(directory)
  }
  
  #iterate through files based on IDs
  for(i in seq_len(length(files))){
    if(complete(directory,i)["nobs"]>threshold){
      path <- paste(directory,"/",files[i], sep = "")
      tempDF <- read.csv(file.path(path),colClasses = c("Date","numeric","numeric","integer"))
      tempDF <- tempDF[which(complete.cases(tempDF)),]
      correl <- append(correl, cor(tempDF["nitrate"],tempDF["sulfate"]))
    }
  }
  
  #return
  correl
}

cr <- corr("specdata",1000)
cr <- sort(cr)
n <- length(cr)
print(c(n,round(cr,4)))

set.seed(197)
out <- c(n,round(cr[sample(n,5)],4))
out

cc <- complete("specdata",332:1)
use <- sample(332,10)
print(cc[use,"nobs"])
