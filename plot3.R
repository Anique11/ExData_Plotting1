#collect the data we need from the file
rawdata <- read.csv('household_power_consumption.txt', sep=";")
rawdata.subset <- subset(rawdata, (Date == '1/2/2007' | Date == '2/2/2007'))

#clean it a bit and set the right formats
cleandata <- rawdata.subset
cleandata$DateTime <- paste(as.character(cleandata$Date), as.character(cleandata$Time))
cleandata$DateTime <- strptime(cleandata$DateTime, "%d/%m/%Y %H:%M:%S")
cleandata$Sub_metering_1 <- as.numeric(as.character(cleandata$Sub_metering_1))
cleandata$Sub_metering_2 <- as.numeric(as.character(cleandata$Sub_metering_2))
cleandata$Sub_metering_3 <- as.numeric(as.character(cleandata$Sub_metering_3))

#create the plot
png('plot3.png')
with(cleandata, plot(DateTime, Sub_metering_1, type='n', xlab='',
                                          ylab='Energy sub metering'))
with(cleandata, lines(DateTime, Sub_metering_1, type='l'))
with(cleandata, lines(DateTime, Sub_metering_2, type='l', col='red'))
with(cleandata, lines(DateTime, Sub_metering_3, type='l', col='blue'))
legend('topright', '', lwd=1,
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'))
dev.off()
