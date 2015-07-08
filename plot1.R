# Prefilter the raw data file, as follows, to extract only the rows required for
# the assignment. This requires the awk program, and was performed in a bash
# shell on a gnu/linux system.

# awk -F";" 'NR == 1 || $1 =="2/2/2007" || $1 == "1/2/2007" {print $0}' \
# household_power_consumption.txt > Assign1.txt

# Read the data from the filtered file created above.
epc <- read.table("Assign1.txt", sep=";", header=T, na.strings="?")

# Add two new columns converting the character Date and Times to R objects.
epc$rDate <- strptime(epc$Date, "%d/%m/%Y")
epc$rTime <- strptime(epc$Time,"%T")

# Draw the plot

png(filename="plot1.png",width=480,height=480)

with(epc,
     hist(Global_active_power,
          col  = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"
    )
)

dev.off()
