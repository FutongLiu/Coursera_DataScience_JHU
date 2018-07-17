##read data
HPC <- read.table("household_power_consumption.txt", header=T, sep=";", stringsAsFactors = F)

##subset data from the dates 2007-02-01 and 2007-02-02
HPC$datetime <- paste(HPC$Date, HPC$Time)
library(lubridate)
HPC$datetime <- dmy_hms(HPC$datetime)
HPC$Date <- dmy(HPC$Date)
HPCsub <- HPC[(HPC$Date >='2007-02-01' & HPC$Date < '2007-02-03'), ]
HPCsub [, 3:9] <- sapply(HPCsub[, 3:9], as.numeric)

##plot4
png(file='plot4.png', width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
##plot4-1
with(HPCsub, plot(Global_active_power ~ datetime, type = "l", ylab = "Global active power (kilowatts)", xlab = NA))
##plot4-2
with(HPCsub, plot(Voltage ~ datetime, type = "l", ylab = "Voltage", xlab = "datetime"))
##plot4-3
with(HPCsub, plot(Sub_metering_1 ~ datetime, type = "l", xlab = NA, ylab = "Energy sub metering"))
with(HPCsub, points(Sub_metering_2 ~ datetime, type = "l", col="red"))
with(HPCsub, points(Sub_metering_3 ~ datetime, type = "l", col="blue"))
library(graphics)
legend("topright", lty = 1 ,col = c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##plot4-4
with(HPCsub, plot(Global_reactive_power ~ datetime, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()