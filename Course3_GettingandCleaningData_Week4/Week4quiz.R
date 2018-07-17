##coursera-Getting and Cleaning Data-week4 quize
##quiz1
##Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?
quiz1 <- read.csv("week4quiz1.csv", stringsAsFactors=F)
trsplit(names(quiz1),"wgtp")[123]

##quiz2
quiz3 <- read.csv("week4quiz2.csv", skip=5, nrows=190, stringsAsFactor=F, header=F)
quiz3GDP <- quiz3[,c(1,2,4,5)]
colnames(quiz3GDP) <- c("CountryCode", "Rank","countryNames", "GDPValue")
mean(as.numeric(gsub(",","",quiz2GDP$GDPValue)))

##quiz3
quiz3 <- quiz2GDP[,c(1,2,4,5)]
colnames(quiz3) <- c("CountryCode", "Rank","countryNames", "GDPValue")
grep("^United",quiz3$countryNames, value=TRUE) 
##[1] "United States"        "United Kingdom"       "United Arab Emirates"
grep("United$",quiz3$countryNames, value=TRUE)
## character(0)

##quiz4
quiz4EDU <- read.csv("week4quiz4.csv", stringsAsFactor=F)
mergeData <- merge(quiz3, quiz4EDU, by.x="CountryCode", by.y="CountryCode")
length(grep("[Ff]iscal year end(.*)+Jun", mergeData$Special.Notes))

##quiz5
library(lubridate)
table(sampleTimes<ymd(20130101) & sampleTimes>ymd(20111231))
        ##FALSE  TRUE 
        ##32273   250 
table(sampleTimes<ymd(20130101) & sampleTimes>ymd(20111231)& wday(sampleTimes)==2)
        ##FALSE  TRUE 
        ##2476    47 