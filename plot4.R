# Prefilter the raw data file, as follows, to extract only the rows required for
# the assignment. This requires the awk program, and was performed in a bash
# shell on a gnu/linux system.

# awk -F";" 'NR == 1 || $1 =="2/2/2007" || $1 == "1/2/2007" {print $0}' \
# household_power_consumption.txt > Assign1.txt


# Read the data from the filtered file created above.
epc <- read.table("Assign1.txt", sep=";", header=T, na.strings="?")


# Create a POSIXlt object vector from the Date and Time character class
# columns.
dTime <- strptime(paste(epc$Date, epc$Time, sep=" "), "%d/%m/%Y %T")


# Save a little typing...
attach(epc)


# Draw the plot. Specify the dimensions even though they're the defaults.
png(filename="plot4.png", width=480, height=480)


# We want a 2x2 grid of plots
par(mfrow=c(2,2))


# Draw the first (top-left) plot
plot(dTime, Global_active_power,
     type="l",
     ylab="Global Active Power",
     xlab=""
)


# Draw the second (top-right) plot.
plot(dTime, Voltage, type="l", xlab="datetime")


# Draw the third (bottom-left) plot, which is the same as plot3.png.
# First create a blank canvas.
plot(dTime, Sub_metering_1,
     type="n",
     ylab="Energy sub metering",
     xlab=""
)


# Then add the three plots.
lines(dTime, Sub_metering_1, col="black")
lines(dTime, Sub_metering_2, col="red")
lines(dTime, Sub_metering_3, col="blue")


# Last of all, a legend.
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=par("lty")
)


# Draw the fourth (bottom-right) plot.
# NOTE: - the assignment shows the raw variable names for the axis labels.
plot(dTime, Global_reactive_power, type="l", xlab="datetime")


# Tidy up.
dev.off()
detach(epc)
