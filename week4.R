#title           :week4.R
#description     :This is a practice file from week 4 lessons.
#author		       :Hizkia Febianto
#date            :20170618


###SIMULATION - GENERATING RANDOM NUMBERS###
# rnorm: generate random Normal variates with a given mean and standard deviation
# dnorm: evaluate the Normal probability density at a point
# pnorm: evaluate the cumulative distribution function for a Normal distribution
# rpois: generate random Poisson variates with a given rate
# example
x <- rnorm(10,20,2) # 10 random numbers from a normal distribution with mean = 20
                    # and standard deviation of 2.
summary(x)

# Setting the random number seed ensures reproducibility
# seed has to be set every time we want to generate random numbers
set.seed(1)
rnorm(5)
set.seed(1)
rnorm(5)

# Generation 10 Poisson random numbers
rpois(10,1)
ppois(2,2) ## cumulative distribution
# The probability of x <= 2 in a Poisson distribution with rate = 2


###SIMULATION - SIMULATING A LINEAR MODEL###
# Suppose we want to simulate from the following linear model
#       y = beta0 + beta1 * x + e
# where e has a normal std distribution with sd = 2
# Assume x ~ N(0,1^2)
set.seed(20)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# What if x is a binary random variable? Binomial distribution
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100,0,2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

# Suppose we want to simulate from a Poisson model where
# Y ~ Poisson(u)
# log(u) = beta0 + beta1 * x
# beta0 = 0.5 and beta1 = 0.3
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)


###SIMULATION - RANDOM SAMPLING###
set.seed(1)
sample(1:10,4)
#[1] 3 4 5 7
sample(letters,5)
#[1] "q" "b" "e" "x" "p"
sample(1:10) #permutation
sample(1:10, replace = TRUE) #sample with replacement
# [1] 2 3 4 1 4 9 4 5 6 5


###R PROFILING###
# Using system.time()
system.time(readLines("http://www.jhsph.edu"))

system.time({
  n<-1000
  r<-numeric(n)
  for(i in 1:n){
    x <- rnorm(n)
    r[i]<- mean(x)
  }}
)

# using Rprof()
# DO NOT use system.time() and Rprof() together!!
