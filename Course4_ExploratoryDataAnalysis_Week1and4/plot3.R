##read data
HPC <- read.table("household_power_consumption.txt", header=T, sep=";", stringsAsFactors = F)

##subset data from the dates 2007-02-01 and 2007-02-02
HPC$datetime <- paste(HPC$Date, HPC$Time)
library(lubridate)
HPC$datetime <- dmy_hms(HPC$datetime)
HPC$Date <- dmy(HPC$Date)
HPCsub <- HPC[(HPC$Date >='2007-02-01' & HPC$Date < '2007-02-03'), ]
HPCsub [, 3:9] <- sapply(HPCsub[, 3:9], as.numeric)

##plot3
png(file='plot3.png', width = 480, height = 480, units = "px")
with(HPCsub, plot(Sub_metering_1 ~ datetime, type = "l", xlab = NA, ylab = "Energy sub metering"))
with(HPCsub, points(Sub_metering_2 ~ datetime, type = "l", col="red"))
with(HPCsub, points(Sub_metering_3 ~ datetime, type = "l", col="blue"))
library(graphics)
legend("topright", lty = 1 ,col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()