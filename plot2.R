#reading in tables and creating two character classes and seven numeric classes based on what is described
power <- read.table("household_power_consumption.txt", sep=";", header = TRUE, 
                    colClasses = c(rep("character", 2), 
                                   rep("numeric", 7)), na.strings = "?")

#creating a date function
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power <- power[power$Date >= as.Date("2007-02-01") & power$Date <= as.Date("2007-02-02"),]

#returning the actual day of the week
power$Date <- as.POSIXlt(paste(as.Date(power$Date,format="%d/%m/%Y" ), power$Time, sep = " "))


#creating first plot with height requested 
png("plot2.png", width = 480, height = 480)
par(mar=c(5, 5,1,1))
#creating a line plot diagram
plot(power$Date, power$Global_active_power, type = 'l', 
     main="Global Active Power", 
     xlab= "",ylab = "Global Active Power (kilowatts)")

#closing off graphics
dev.off()