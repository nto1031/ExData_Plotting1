
###### Download the file ######
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./data.txt")

###### Read the Table and filter to the necessary dates for analysis #######
consumption <- read.table("./data.txt", sep = ";")
names(consumption) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                        "Sub_metering_3")

consumption$Date <- as.Date(consumption$Date, "%m/%d/%Y")

consumption_selection <- consumption[consumption$Date == "2007-02-01" | 
                                       consumption$Date == "2007-02-02" , ]
consumption_selection <- consumption_selection[!is.na(consumption_selection$Date) , ]

###### Create Vectors for graphs #####
Global_active <- as.numeric(consumption_selection$Global_active_power[!is.na(consumption_selection$Global_active_power)])
datetime <- as.POSIXct(consumption_selection$Date_Time,
                       format = "%m/%d/%Y %H:%M:%S")



#Plot 4
png("Plot4.png")
par(mfrow = c(2, 2))
plot(datetime, Global_active, type = "l", ylab = "Global Active Power (kilowatts)", 
     xlab = "")
plot(datetime, consumption_selection$Voltage, ylab = "Voltage", type = "l")
plot(datetime, consumption_selection$Sub_metering_3, type = "l", col = "blue", 
     ylab = "Energy sub metering", xlab = "")
lines(datetime, consumption_selection$Sub_metering_2, col = "red")
lines(datetime, consumption_selection$Sub_metering_1)
legend("topright", c("Sub metering 1", "Sub metering 2", "Sub metering 3"), 
       col = c("black", "red", "blue"), 
       lty = 1)
plot(datetime, consumption_selection$Global_reactive_power, ylab = "Global_reactive_power",
     type = "l")
dev.off()