# Data processing (PLEASE ALTER WORKING DIRECTORY AS APPROPRIATE)
setwd("/home/billy/Documents/CourseraDataScience/ExploratoryDataAnalysis/")
library(data.table)  # Requires installation of data.table package.
powerdata<-data.table(read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE,
    colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")))
powerdata[,datetime:=paste(Date,Time)]
powerdata<-data.frame(powerdata)
powerdata$Date<-as.POSIXct(strptime(powerdata$Date,"%d/%m/%Y"))
powerdata$datetime<-as.POSIXct(strptime(powerdata$datetime,"%d/%m/%Y %H:%M:%S"))
f<-"%d/%m/%Y"
startdate<-as.POSIXct(as.Date("01/02/2007",format=f))
enddate<-as.POSIXct(as.Date("02/02/2007",format=f))
workingdata<-subset(powerdata,powerdata$Date>=startdate &powerdata$Date <=enddate)

# Plot1
png(file="plot1.png",bg="transparent") # Default is 480 x 480
hist(workingdata$Global_active_power,col="red",bg="transparent",main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()

