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
png("plot3.png", width = 480, height = 480)
par(mar=c(5, 5,1,1))
#creating a plot diagram for the 3 submetering
plot(power$Date, power$Global_active_power, type = 'n', 
     main="Global Active Power",
     #seting the y axis limits between 0 and the max of the submeter
     ylim = c(0, max(
         c(power$Sub_metering_1, 
           power$Sub_metering_2, 
           power$Sub_metering_3))),
     xlab= "",ylab = "Energy sub metering")
#assigning a colour for each sub metering line
lines(power$Date, power$Sub_metering_1, col = "black")
lines(power$Date, power$Sub_metering_2, col = "red")
lines(power$Date, power$Sub_metering_3, col = "blue")

#creating a legend in the top right corner
legend("topright", lwd =1,
       col = c("black", 
               "red", 
               "blue"),
       legend = c("sub metering 1",
                  "sub metering 2", 
                  "sub metering 3"))

#closing off graphics
dev.off()