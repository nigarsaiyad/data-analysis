a <- 4*2
a
b <-6
a+b
a-b
a<- c(3,4,6,9)
rep(1,3)
seq(5,5,7,9,8)
rep("nigar",3)


airquality<- datasets::airquality
airquality(,c(1,2))
View(airquality)
airquality[,-6]
df<- airquality[,-6]
View(df)

## summary of data
summary(airquality)
summary( airquality$Month)

# data visualization

plot(airquality$Wind)

plot(airquality$Wind,airquality$Solar.R) # p means point
# h is histogram,l= line,b= combination of point and line

plot(airquality$Ozone,xlab = "ozone concentration",ylab="no. of instannce",
     main =" ozone level in new york city",col="red")

barplot(airquality$Ozone,xlab = "ozone concentration",ylab="no. of instannce",
        main =" ozone level in new york city",col="red")

hist(airquality$Ozone,col = "pink")

# single boxplot

boxplot(airquality$Wind)
boxplot.stats(airquality$Wind)$out

# multibox plot

boxplot(airquality[,1:4],main="multibox plot")
par(mfrow=c(3,3))


boxplot(airquality$Wind)
sd(airquality$Wind)
skew(airquality)
library( moments)
skewness(airquality$Wind)
 a<- 2
a<- 3+5j
class (a)
a<-3+5i
