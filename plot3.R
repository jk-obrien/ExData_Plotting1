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


# Draw the plot. Specify the dimensions even though they're the defaults.
png(filename="plot3.png", width=480, height=480)

# First create a blank canvas.
with(epc,
     plot( dTime, Sub_metering_1,
           type="n",
           ylab="Energy sub metering",
           xlab=""
    )
)

# Then add the three plots.
with(epc, lines(dTime, Sub_metering_1, col="black"))
with(epc, lines(dTime, Sub_metering_2, col="red"))
with(epc, lines(dTime, Sub_metering_3, col="blue"))

# Last of all, a legend.
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=par("lty")
)

dev.off()
