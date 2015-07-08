# Prefilter the raw data file, as follows, to extract only the rows required for
# the assignment. This requires the awk program, and was performed in a bash
# shell on a gnu/linux system.

# awk -F";" 'NR == 1 || $1 =="2/2/2007" || $1 == "1/2/2007" {print $0}' \
# household_power_consumption.txt > Assign1.txt


# Read the data from the filtered file created above.
epc <- read.table("Assign1.txt", sep=";", header=T, na.strings="?")


# Create a POSIXlt object vector from the Date and Time character class
# columns.
dTime <- strptime(paste(epc$Date,epc$Time,sep=" "),"%d/%m/%Y %T")


# Draw the plot
png(filename="plot2.png",width=480,height=480)

with(epc,
     plot(dTime, Global_active_power,
          type = 'l',
          ylab = "Global Active Power (kilowatts)",
          xlab = ""
     )
)

dev.off()
