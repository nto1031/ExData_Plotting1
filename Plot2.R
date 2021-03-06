
###### Download the file ######
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./power_cons.zip")
unzip("./power_cons.zip")


###### Read the Table and filter to the necessary dates for analysis #######
consumption <- read.table("household_power_consumption.txt", sep = ";")
names(consumption) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                        "Sub_metering_3")

consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")

consumption_selection <- consumption[consumption$Date == "2007-02-01" | 
                                       consumption$Date == "2007-02-02" , ]
consumption_selection <- consumption_selection[!is.na(consumption_selection$Date) , ]

###### Create Vectors for graphs #####
Global_active <- as.numeric(consumption_selection$Global_active_power[!is.na(consumption_selection$Global_active_power)])
consumption_selection$Date_Time <- paste(consumption_selection$Date, consumption_selection$Time)
datetime <- as.POSIXct(consumption_selection$Date_Time,
                       format = "%Y-%m-%d %H:%M:%S")

#Plot 2
png(filename = "Plot2.png")
plot(datetime, Global_active, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()