setwd("C:/Users/futong/Desktop/Coursera/video classes/04 Exploratory Data Analysis/Project/PMProject")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Plot1
ysum <- with(NEI, tapply(Emissions, year, sum, na.rm=T)) #sum PM2.5 for each year
year <- unique(NEI$year) 
dysum <- data.frame(year, total.Emissions=ysum) #convert "ysum" to dataframe
png(file='plot1.png')
barplot(names.arg=dysum$year, height=dysum$total.Emissions, ylab="Amount of Total PM2.5 Emission (tons)", xlab="Year", main="Total PM2.5 Emission in Different Years")
dev.off()

##Plot2
baltimore <- subset(NEI, fips == "24510") #subset data for Baltimore city
bsum <- with(baltimore, tapply(Emissions, year, sum, na.rm=T)) 
year <- unique(NEI$year)
dbsum <- data.frame(year, total.Emissions=bsum)
png(file='plot2.png')
barplot(names.arg=dbsum$year, height=dbsum$total.Emissions, ylab="Amount of Total PM2.5 Emission (tons)", xlab="Year", main="Total PM2.5 Emission in Baltimore City")
dev.off()

##Plot3
library(ggplot2)
library(dplyr)
gbaltimore <- group_by(baltimore, year, type) %>% summarise(total.Emissions=sum(Emissions)) # group baltimore data by year and type, then sum PM2.5 value
gbaltimore$year <- factor(gbaltimore$year, levels=c('1999', '2002', '2005', '2008'))
png(file='plot3.png')
ggplot(gbaltimore, aes(year, total.Emissions)) + geom_bar(stat="identity") + facet_grid(.~type) + 
        labs (title="Emissions per Type in Baltimore City") + labs(y="Amount of Total PM2.5 Emission (tons)") + 
        theme(plot.title = element_text(hjust = 0.5))
dev.off()

##Plot4
NEISCC <- merge(NEI, SCC, by="SCC") # merge NEI and SCC by "scc"
coalPM <- NEISCC[grepl("coal", NEISCC$Short.Name, ignore.case=TRUE),] # subset coal-related data set from NEISCC
coalsum <- with(coalPM, tapply(Emissions, year, sum, na.rm=T))
year <- unique(NEISCC$year)
dycoalPM<- data.frame(year, total.Emissions=coalsum)
dycoalPM$year <- factor(dycoalPM$year, levels=c('1999', '2002', '2005', '2008'))
png(file='plot4.png')
ggplot(dycoalPM, aes(year, total.Emissions)) + geom_line(aes(group=1), color="red") + geom_point(size=3) + 
        labs(title="Total PM2.5 Emission from Coal Combustion-related Source per Year") + 
        labs(y="Amount of Total PM2.5 Emission (tons)") + 
        theme(plot.title = element_text(hjust = 0.5))
dev.off()

##Plot5
baltimoreMV <- subset(NEISCC, fips == "24510" & type=="ON-ROAD") #subset data emissions from motor vehicle sources in Baltimore
baltimoreMVsum <- with(baltimoreMV, tapply(Emissions, year, sum, na.rm=T))
year <- sort(unique(baltimoreMV$year))
dbaltimoreMVsum <- data.frame(year, total.Emissions=baltimoreMVsum)
dbaltimoreMVsum$year <- factor(dbaltimoreMVsum$year, levels=c('1999', '2002', '2005', '2008'))
png(file='plot5.png')
ggplot(dbaltimoreMVsum, aes(year, total.Emissions)) + geom_bar(stat="identity", fill="light gray", color="dark blue", width=.7) +
        labs(title="Amount of Total PM2.5 Emissions from motor vehicle sources in Baltimore City") + 
        labs(y="Amount of Total PM2.5 Emission (tons)") + 
        theme(plot.title = element_text(hjust = 0.5))
dev.off()


##Plot6
LAMV <- subset(NEISCC, fips == "06037" & type=="ON-ROAD")
LAMVsum <- with(LAMV, tapply(Emissions, year, sum, na.rm=T))
year <- unique(LAMV$year)
dLAMVsum <- data.frame(year, total.Emissions=LAMVsum)
dLAMVsum$City <- paste(rep('LA', 4))

baltimoreMV <- subset(NEISCC, fips == "24510" & type=="ON-ROAD")
baltimoreMVsum <- with(baltimoreMV, tapply(Emissions, year, sum, na.rm=T))
dbaltimoreMVsum <- data.frame(year, total.Emissions=baltimoreMVsum)
dbaltimoreMVsum$City <- paste(rep('Baltimore', 4))

LA.Baltimore <-rbind(dbaltimoreMVsum, dLAMVsum) ## merge LA data set and Baltimore data set
LA.Baltimore$year <- factor(LA.Baltimore$year, levels=c('1999', '2002', '2005', '2008'))

png(file='plot6.png')
ggplot(LA.Baltimore, aes(year, total.Emissions)) + geom_bar(stat="identity", fill="light blue", width=.7) +
       facet_grid(.~City) + labs(title="Amount of Total PM2.5 Emissions from Motor Vehicle Sourcess") + 
        labs(y="Amount of Total PM2.5 Emission (tons)") + ylim(0, 5000) +
        theme(plot.title = element_text(hjust = 0.5))
dev.off()


