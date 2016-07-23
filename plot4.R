plot4<-function()
{
    ##READING DATA
    #checking if data exists in working folder, if no, download it and unzip it
    if(file.exists("household_power_consumption.txt")==FALSE)
    {
        if(file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")==FALSE)
        {
            print("Loading data...")
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata%2Fdata%2Fhousehold_power_consumption.zip")
        }
        unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
    }
    #reading column names
    col_names<-read.csv("./household_power_consumption.txt",sep = ";",nrows=1)
    #reading data and assigning column names (only rows, which are used for graphics)
    dataset<-read.csv("./household_power_consumption.txt",sep = ";",skip=66636,nrows=2880)
    names(dataset)<-names(col_names)
    #converting date and time to date_time column with proper format
    dataset$Date_Time<-interaction(dataset$Date,dataset$Time, sep=" ")
    dataset$Date_Time<-strptime(dataset$Date_Time,"%d/%m/%Y %H:%M:%S")
    #opening graphic device
    png(filename="plot4.png", width = 480, height = 480, units="px")
    #plotting graphics 
    par(mfcol=c(2,2))
    plot(dataset$Date_Time,dataset$Global_active_power,type="l",ylab="Global Active Power",xlab="")
    plot(dataset$Date_Time,dataset$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
    lines(dataset$Date_Time,dataset$Sub_metering_2, col="red")
    lines(dataset$Date_Time,dataset$Sub_metering_3, col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty="n",cex=0.75)
    plot(dataset$Date_Time,dataset$Voltage,type="l",ylab="Voltage",xlab="datetime")
    plot(dataset$Date_Time,dataset$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
    dev.off()
}