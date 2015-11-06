# read in the data, have assumed the computer being used has enough memory
temp <- tempfile()
ZipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(ZipURL, temp)

HH_consump <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors = FALSE)

# convert the relevant date and time fields to date and time format
HH_consump$Time <- strptime(paste(HH_consump$Date, HH_consump$Time), "%d/%m/%Y %H:%M:%S")
HH_consump$Date <- as.Date(HH_consump$Date, "%d/%m/%Y")

# subset the data to save memory - this is currently read in as factors
HH_consump <- subset(HH_consump, Date >= "2007-02-01" & Date <= "2007-02-02")

# convert the measures into numbers
cols <- 3:length(names(HH_consump))
HH_consump[, cols] = apply(HH_consump[, cols], 2, function(x) as.numeric(x))

# constructing the png plots

# plot 1 - histogram
png('plot1.png', width=480, height=480)
hist(HH_consump$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
#dev.copy(png, file="plot1.png") #need to be 480 x 480 pixels
dev.off() #close the PNG device
