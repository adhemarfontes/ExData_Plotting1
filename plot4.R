plot4 <- function(){
  
  library(plyr) 
  library(data.table) 
  library(dplyr) 
  library(stringr)
  
  zipfile <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipfile, method="curl")
  unzip(zipfile)
  unzipedFile<-file("household_power_consumption.txt")
  subsetdata <- read.table(text = grep("^[1,2]/2/2007",readLines(unzipedFile),value=TRUE), sep=";",na.strings="?")
  colnames(subsetdata)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )  
  
  Datetime <-paste(subsetdata$Date,subsetdata$Time)
  subsetdata$Datetime <-strptime(Datetime, "%d/%m/%Y %H:%M:%S")
  
  par(mfrow=c(1,1))
  png(file = "plot4.png", bg = "transparent", width = 480, height = 480)
  par(mfrow=c(2,2), mar=c(4,4,2,1))
   with(subsetdata, {
     plot(Datetime, Global_active_power, type = "l", ylab = "Global Active Power")
     plot(Datetime, Voltage, type="l")
     plot(Datetime, Sub_metering_1, type="l", ylab="Energy Sub Metering", col = "grey")
     points(subsetdata$Datetime, subsetdata$Sub_metering_2, type = "l", col = "red")
     points(subsetdata$Datetime, subsetdata$Sub_metering_3, type = "l", col = "blue")
     legend("topright", lty = 1, bty = "n", cex=0.4, col = c("grey", "red", "blue"), 
            legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
     plot(Datetime, Global_reactive_power, type = "l")
   })
  dev.off ();
  
  
}

