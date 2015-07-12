# We start with the data file already downloaded and unzipped.

# Read the data using a pipe. This allows us to read in only the data lines
# required for the assignment. As it happens, in this case, the whole data file
# would fit in memory, but it's a useful exercise for when we do encounter a
# file that's too big to read.

# This is not a cross-platform solution, it depends on the presence of the awk
# program, which is installed by default on most linux/unix platforms.


# First construct our awk command. This runs outside R and filters the data file
# returning only the lines that we need.
awk_cmd <- paste(
    "awk -F';' 'NR == 1 || $1 ==\"2/2/2007\" || $1 ==\"1/2/2007\" {print $0}'",
    "household_power_consumption.txt"
)


# Then make our pipe connection. This allows R to read the output of awk above.
pipe_con <- pipe(awk_cmd, open="r")


# Read the data and close the pipe.
epc <- read.table(pipe_con, sep=";", header=T, na.strings="?")
close(pipe_con)


# Draw the plot. Specify the dimensions even though they're the defaults.
png(filename="plot1.png", width=480, height=480)

with(epc,
     hist(Global_active_power,
          col  = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"
    )
)

dev.off()
