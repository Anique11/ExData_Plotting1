#collect the data we need from the file
rawdata <- read.csv('household_power_consumption.txt', sep=";")
rawdata.subset <- subset(rawdata, (Date == '1/2/2007' | Date == '2/2/2007'))

#clean it a bit and set the right formats
cleandata <- rawdata.subset
cleandata[, 'Date'] <- as.Date(cleandata[, 'Date'], "%d/%m/%Y")
cleandata[, 'Global_active_power'] <- as.numeric(as.character(cleandata[, 'Global_active_power']))

#create the plot
png('plot1.png')
with(cleandata, hist(Global_active_power, main='Global Active Power',
                                          xlab='Global Active Power (kilowatts)',
                                          col='Red'))
dev.off()
