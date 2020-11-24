library(data.table)

# -----------------Read Data-------------------------------
# Folder containing the database
file_dir <- file.path("..","Data", "household_power_consumption.txt")
Data     <- read.table(file_dir, header = TRUE, sep = ";", na.strings = "?",
                       colClasses = c('character','character','numeric',
                                      'numeric','numeric','numeric','numeric',
                                      'numeric','numeric'))

# Convert the Data and Time to Data/Time classes
Data$Date <- as.Date(Data$Date, format = "%d/%m/%Y")
Data_plot <- subset(Data, Data$Date == "2007-02-01" | Data$Date == "2007-02-02")

#Time and Date variables are unified
Date_Time <- paste(Data_plot$Date, Data_plot$Time)
Data_plot <- subset(Data_plot, select  = -c(Date, Time))
Data_plot <- cbind(Date_Time,Data_plot)

Data_plot$Date_Time <- as.POSIXct(Data_plot$Date_Time)
Data_plot$Global_active_power <- as.numeric(Data_plot$Global_active_power)

Data_plot<- Data_plot[complete.cases(Data_plot),]
# --------------------Save Figure -----------------------
png(file = "plot3.png",
    width = 480,
    height = 480)
# ------------------Figure ------------------------------
with(Data_plot,{plot(Date_Time,Sub_metering_1,type = "l", xlab = "",
                    ylab = "Global Active Power (Kilowatts)")
     lines(Date_Time,Sub_metering_2, col = "red")
     lines(Date_Time,Sub_metering_3, col = "blue")})
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty=1,col = c("black","red","blue"))
dev.off()