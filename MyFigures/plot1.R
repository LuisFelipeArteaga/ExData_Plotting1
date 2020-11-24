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

Data_plot<- Data_plot[complete.cases(Data_plot),]
# --------------------Save Figure -----------------------
png(file = "plot1.png",
    width = 480,
    height = 480)

# ------------------Figure ------------------------------
hist(Data_plot$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     col = "red", 
     main = "Global Active Power")

dev.off()