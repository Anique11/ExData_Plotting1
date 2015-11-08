#collect the data we need from the file
rawdata <- read.csv('household_power_consumption.txt', sep=";")
rawdata.subset <- subset(rawdata, (Date == '1/2/2007' | Date == '2/2/2007'))

#clean it a bit and set the right formats
cleandata <- rawdata.subset
##for the X
cleandata$DateTime <- paste(as.character(cleandata$Date), as.character(cleandata$Time))
cleandata$DateTime <- strptime(cleandata$DateTime, "%d/%m/%Y %H:%M:%S")
##for the Y:
#subplot a
cleandata$Global_active_power <- as.numeric(as.character(cleandata$Global_active_power))
#subplot b
cleandata$Voltage <- as.numeric(as.character(cleandata$Voltage))
#subplot c
cleandata$Sub_metering_1 <- as.numeric(as.character(cleandata$Sub_metering_1))
cleandata$Sub_metering_2 <- as.numeric(as.character(cleandata$Sub_metering_2))
cleandata$Sub_metering_3 <- as.numeric(as.character(cleandata$Sub_metering_3))
#subplot d
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))

#create the plot
png('plot4.png')
## create area for multiple subplots
par(mfrow=c(2,2))

##subplot a
with(cleandata, plot(DateTime, Global_active_power, type='n', xlab='',
                     ylab='Global Active Power'))
with(cleandata, lines(DateTime, Global_active_power, type='l'))

##subplot b
with(cleandata, plot(DateTime, Voltage, type='n', xlab='datetime'))
with(cleandata, lines(DateTime, Voltage, type='l'))

##subplot c
with(cleandata, plot(DateTime, Sub_metering_1, type='n', xlab='',
                                          ylab='Energy sub metering'))
with(cleandata, lines(DateTime, Sub_metering_1, type='l'))
with(cleandata, lines(DateTime, Sub_metering_2, type='l', col='red'))
with(cleandata, lines(DateTime, Sub_metering_3, type='l', col='blue'))
legend('topright', '', lwd=1, box.lwd=0,
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'))

##subplot d
with(cleandata, plot(DateTime, Global_reactive_power, type='n', xlab='datetime'))
with(cleandata, lines(DateTime, Global_reactive_power, type='l'))

dev.off()
