setwd("C:/Users/futong/Desktop/Coursera/video classes/03 Getting and Cleanning Data/Download")
## quiz1
mydata1 <- read.csv("w3q1.csv")
agricultureLogical <- with(mydata1, mydata1$ACR==3 & mydata1$AGS==6)
which(agricultureLogical)

##quiz2
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="quiz2.jpeg")
quiz2 <- readJPEG("quiz2.jpeg", native=TRUE)
quantile(quiz2, probs = c(0.3, 0.8)) ## -16776939 -10092545 why?
## Please correct me on this code!!

##quiz3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="w3q3GDP.csv")
quiz3 <- read.csv("w3q3GDP.csv", skip=5, nrows=190, stringsAsFactor=F, header=F)
quiz3GDP <- quiz3[,c(1,2,4,5)]
colnames(quiz3GDP) <- c("CountryCode", "Rank","Long Name", "GDP Value")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="quiz3EDU.csv")
quiz3EDU <- read.csv("quiz3EDU.csv", stringsAsFactor=F)
mergedData <- merge(quiz3GDP, quiz3EDU, by.x="CountryCode", by.y="CountryCode")
nrow(mergedData)
library(dplyr)
mergedData <- arrange(mergedData, desc(Rank))
mergedData[13,3]

##quiz4
income <- group_by(mergedData, Income.Group)
summarize(income, Rank=mean(Rank, na.rm=TRUE))

##quiz5
library(Hmisc)
mergedData$Rank <- cut2(mergedData$Rank, g=5)
table(mergedData$Rank, mergedData$Income.Group)
