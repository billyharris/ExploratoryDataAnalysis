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

#Plot 3
png(file="plot3.png",bg="transparent") # Default is 480 x 480
with(workingdata,plot(Sub_metering_1~datetime,type="n",xlab="",ylab="Energy sub metering"))
lines(workingdata$datetime,workingdata$Sub_metering_1,col="black")
lines(workingdata$datetime,workingdata$Sub_metering_2,col="red")
lines(workingdata$datetime,workingdata$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub-metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()
