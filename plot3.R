rm(list=ls())
setwd("D:/archivos de usb2/COURSERA/DATA SCIENCE/CURSO 4/SCRIPTS")


# Leyendo datos  y modificand
datapower<-read.table("./data/housepower.txt", sep = ";")
str(datapower)
colnames(datapower)



power<- data.frame(numero=1:nrow(datapower), Date=datapower$V1,
                   Time=datapower$V2,Global_active_power=datapower$V3,
                   Global_reactive_power=datapower$V4, Voltage=datapower$V5,
                   Global_intendity=datapower$V6, Sub_metering1=datapower$V7,
                   Sub_metering2=datapower$V8, Sub_metering3=datapower$V9)

power<-power[power$numero!=1,]
power<-power[,2:10]

power$Global_active_power<-as.numeric(power$Global_active_power)
power$Global_reactive_power<-as.numeric(power$Global_reactive_power)
power$Voltage<-as.numeric(power$Voltage)
power$Global_intendity<-as.numeric(power$Global_intendity)
power$Sub_metering1<-as.numeric(power$Sub_metering1)
power$Sub_metering2<-as.numeric(power$Sub_metering2)
power$Sub_metering3<-as.numeric(power$Sub_metering3)

library(lubridate)

power$Date<-dmy(power$Date)

power<-cbind(power, FechaT=paste(power$Date,power$Time))
power<-cbind(power, dmy=format(power$Date, "%a %b %d"))

power$FechaT<-ymd_hms(power$FechaT)

power$FechaT<-format(power$FechaT, "%a %b %d %H:%M")

part1<-power[grepl("2007-02-01",power$Date),]
part2<-power[grepl("2007-02-02",power$Date),]
power<-rbind(part1,part2)

#### grafico 3 #### 

power.ts1<-ts(power$Sub_metering1)
power.ts2<-ts(power$Sub_metering2)
power.ts3<-ts(power$Sub_metering3)
plot(power.ts1, col="red")
plot(power.ts2, col="blue")
plot(power.ts3, col="black")
subdata<-power[,7:9]
sub.ts<-ts(subdata)


plot(sub.ts, plot.type = "single", col = c("black","red","blue"), ylab="Energy sub metering")
legend("topright",pch=1, colnames(sub.ts), col = c("black","red","blue"))
dev.copy(png,"./figuras/plot3.png")
dev.off()



dir()
#head(subdata)




#head(power[,7:9])





