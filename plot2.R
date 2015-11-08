#collect the data we need from the file
rawdata <- read.csv('household_power_consumption.txt', sep=";")
rawdata.subset <- subset(rawdata, (Date == '1/2/2007' | Date == '2/2/2007'))

#clean it a bit and set the right formats
cleandata <- rawdata.subset
cleandata$DateTime <- paste(as.character(cleandata$Date), as.character(cleandata$Time))
cleandata$DateTime <- strptime(cleandata$DateTime, "%d/%m/%Y %H:%M:%S")
cleandata[, 'Global_active_power'] <- as.numeric(as.character(cleandata[, 'Global_active_power']))

#create the plot
png('plot2.png')
with(cleandata, plot(DateTime, Global_active_power, type='n', xlab='',
                                          ylab='Global Active Power (kilowatts)'))
with(cleandata, lines(DateTime, Global_active_power, type='l'))
dev.off()
