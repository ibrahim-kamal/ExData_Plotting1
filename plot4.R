library(lubridate)
data <- data.table::fread('household_power_consumption.txt')
sub_data <- subset(data, !(is.na((stringr::str_locate(string = data$Date,"2007"))[,'start'])),select = names(data))
sub_data <- subset(sub_data,dmy(sub_data$Date)== "2007-02-01"| dmy(sub_data$Date) == "2007-02-02",select = names(sub_data))
plot1 <- as.numeric(sub_data$Global_active_power) 
datetime <- strptime(paste(sub_data$Date,sub_data$Time),"%d/%m/%Y %H:%M:%S")
sm1 <- as.numeric(sub_data$Sub_metering_1)
sm2 <- as.numeric(sub_data$Sub_metering_2)
sm3 <- as.numeric(sub_data$Sub_metering_3)
png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))


#plot 2
plot(datetime, plot1, type="l", xlab="", ylab="Global Active Power (kilowatts)")


#plot 3
plot(datetime, sub_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

#plot 1 
plot(datetime,sm1,type="l", xlab="", ylab="Energy Submetering")
lines(datetime,sm2,type ='l',col='red')
lines(datetime,sm3, type="l", col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch = '_',col = c('black','red','blue'))


#plot 4
plot(datetime, sub_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
dev.off() 