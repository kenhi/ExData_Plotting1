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

#Plot 1

png("plot1.png", width=480, height= 480)
hist(dat_sub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()