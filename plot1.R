

rm(list=ls())
setwd("D:/archivos de usb2/COURSERA/DATA SCIENCE/CURSO 4/SCRIPTS")

dir("./data")



# Leyendo datos  y modificando

datapower<-read.table("./data/housepower.txt", sep = ";")
str(datapower)
colnames(datapower)
datapower[1,]

colnames(datapower)[1]
datapower[1:2,1:5]
nrow(datapower)


#### Limpiando y convirtiendo ####


power<- data.frame(numero=1:nrow(datapower), Date=datapower$V1,
                   Time=datapower$V2,Global_active_power=datapower$V3,
                   Global_reactive_power=datapower$V4, Voltage=datapower$V5,
                   Global_intendity=datapower$V6, Sub_metering1=datapower$V7,
                   Sub_metering2=datapower$V8, Sub_metering3=datapower$V9)



part1<-power[grepl("2007-02-01",power$Date),]
part2<-power[grepl("2007-02-02",power$Date),]
power<-rbind(part1,part2)

table(grepl("2007-02",power$Date))


power

power<-power[power$numero!=1,]

power[1:6,1:9]
tail(power$Sub_metering1,50)
power<-power[,2:10]
str(power)

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


str(power)

a<-power$FechaT[5]
a<-ymd_hms(a)
a
#### primer grafico ####

with(power, hist(Global_active_power
,main = "Global Active Power",
col = "red", xlab = "Global Active Power (Kilowatts)"))
dev.copy(png,"./figuras/plot1.png")
dev.off()









