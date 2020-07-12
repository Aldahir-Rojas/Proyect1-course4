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


power$Date<-dmy(power$Date)

power<-cbind(power, FechaT=paste(power$Date,power$Time))
power<-cbind(power, dmy=format(power$Date, "%a %b %d"))

power$FechaT<-ymd_hms(power$FechaT)

power$FechaT<-format(power$FechaT, "%a %b %d %H:%M")



#### grafico 2 ####

power.ts<-ts(power$Global_active_power)
plot(power.ts, ylab="Global Active Power (kilowatts)")
dev.copy(png, "./figuras/plot2.png")
dev.off()
