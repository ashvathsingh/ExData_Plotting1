##The code beigns simply enugh. We read the file in with the spcifications that
## were provided to us. A special mention is given to convert the Date column to
## a character one. 

hpc <- read.csv("C:/Users/admin/SkyDrive/Documents/Accademic/Coursera/Data Science/Exploratory Data Analysis/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)
hpc$Date <- as.character(hpd$Date)

##With this sequence of codes we first strip the time from the character string 
##that we created for the date which will be used for subsetting purposes further 
##along in the code.

hpc$Date <- strptime(hpc$Date, "%e/%m/%Y")
hpc$Date <- as.Date(hpc$Date)

## This bit of code is to show how the data is extracted from the large data set. 
##Essentially we are comparing dates that we require with the dates provided in the data set.

condition1 <- as.Date("2007-02-01")
condition2 <- as.Date("2007-02-02")
req <- (condition1 <= hpc$Date)
hpc1 <- hpc[req, ]
req <- (condition2 >= hpc1$Date)
hpc1 <- hpc1[req, ]

## To make our future work somewhat easier we will make the time and date as one column.
## First we will convert our date's class to character. 

hpc1$Date <- as.character(hpc1$Date)
dt <- paste(hpc1$Date, hpc1$Time)
dt <- strptime(dt, "%Y-%m-%d %H:%M:%S")
class(dt)

##After testing our method of combining of the date and time we can now add it to 
## our original data set and that would give us a nice data set.
hpc2 <- hpc1[, 3:9]
head(hpc2)
hpc2 <- cbind(dt, hpc2)

##Now that we have a subset we shall go along with the Explaratory Analysis!!
##So the code that I finally came up with seems a little convoluted. 
##I first found out which submetering line had the maximum value. 
endval <- max(hpc2$Sub_metering_1)
end <- "Sub_metering_1"
if (endval < max(hpc2$Sub_metering_2)){end <- "Sub_metering_2"}
if (endval < max(hpc2$Sub_metering_3)){end <- "Sub_metering_3"}
end

##Once I found that out I used it to construct a plot that fits the requirement.
##I use the largest value which was sub metering 1's to initialize the plot.
##Then add the remainder of the lines.
plot(hpc2$dt, hpc2$Sub_metering_1, type = "l", ylab = paste("Global", "Active", "Power", "(kilowatts)"), xlab = paste("Time", "->"))
points(hpc2$dt, hpc2$Sub_metering_2, type = "l", col = "red")
points(hpc2$dt, hpc2$Sub_metering_3, type = "l", col = "blue")

##Simply added the legend. Specified the line and it's width.
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd = c(2.5, 2.5) )

##Now that we have the plot we make the .png file with the required name and size.
dev.copy(png, width =480, height = 480, file = "Plot3.png")
dev.off()