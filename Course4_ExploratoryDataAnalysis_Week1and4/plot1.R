##read data
HPC <- read.table("household_power_consumption.txt", header=T, sep=";", stringsAsFactors = F)

##subset data from the dates 2007-02-01 and 2007-02-02
HPC$datetime <- paste(HPC$Date, HPC$Time)
library(lubridate)
HPC$datetime <- dmy_hms(HPC$datetime)
HPC$Date <- dmy(HPC$Date)
HPCsub <- HPC[(HPC$Date >='2007-02-01' & HPC$Date < '2007-02-03'), ]
HPCsub [, 3:9] <- sapply(HPCsub[, 3:9], as.numeric)

## plot1
png(file='plot1.png', width = 480, height = 480, units = "px")
with(HPCsub, hist(Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)'))
dev.off()
