if (!file.exists("data.zip")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile="data.zip",
                      method="curl")
        unzip("data.zip")  
}

# Read in data once downloaded, unzipped and in working directory
dat<- read.table("./household_power_consumption.txt", sep=";",nrows= 2075260, header=TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# Subset data to just the date range needed
dat_sub<- subset(elc, (elc$Date == "1/2/2007" | elc$Date== "2/2/2007")) 

# Change class of date
dat_sub$Date <- as.Date(sub$Date, format = "%d/%m/%Y")

# Combine date and time, add new column "DateTime"
dat_sub$DateTime <- as.POSIXct(paste(sub$Date, sub$Time))



#Plot 4

png("plot4.png", width=480, height= 480)
par(mfrow = c(2,2))
par(mar = c(4,4,3,2))
#topleft
plot(dat_sub$DateTime, dat_sub$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")
#topright
plot(dat_sub$DateTime, dat_sub$Voltage, type="l", ylab="Voltage", xlab = "datetime")
#bottomleft
plot(dat_sub$DateTime, dat_sub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab = "")
lines(dat_sub$DateTime, dat_sub$Sub_metering_2, type = "l", col="red")
lines(dat_sub$DateTime, dat_sub$Sub_metering_3, type = "l", col="blue")
legend("topright", bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
#bottomright
plot(dat_sub$DateTime, dat_sub$Global_reactive_power, type="l", ylab="global_reactive_power", xlab = "datetime")
dev.off()


