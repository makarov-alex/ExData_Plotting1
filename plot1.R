plot1<-function()
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
    png(filename="plot1.png", width = 480, height = 480, units="px")
    #plotting graphics
    hist(dataset$Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.off()
}