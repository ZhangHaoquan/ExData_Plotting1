## This file should be reproducible in Windows R 3.1.2
## W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J is a unique key that tags all objects produced by this series of R codes

## Data Downloading/Unzipping - If file extraction done previously, ignore
if(!file.exists("household_power_consumption_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J.txt"))
{
	fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile = "./DownloadedDataFile.zip")
	unzip("./DownloadedDataFile.zip")
	file.rename("household_power_consumption.txt","household_power_consumption_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J.txt")
}

## Data Reading - If environment contains variable, ignore
if(!("hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J" %in% ls()))
{
	hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J <- read.table("./household_power_consumption_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J.txt",
		na.strings='?', sep=";", quote="", header=TRUE, colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric") )
}

## Data reshaping
if(!("sub_hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J" %in% ls()))
{	
	## Preserve the integrity/rawness of hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J by changing a variable
	hse_pwr_con <- hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J

	hse_pwr_con$DateTime <- strptime(paste(hse_pwr_con$Date, hse_pwr_con$Time), "%d/%m/%Y %H:%M:%S")
	Start_Date <- strptime("2007-02-01", "%Y-%m-%d")
	End_Date <- strptime("2007-02-03", "%Y-%m-%d")
	sub_hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J <- hse_pwr_con[((hse_pwr_con$DateTime >= Start_Date) & (hse_pwr_con$DateTime <= End_Date)),]

	## Preserve the integrity/rawness of sub_hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J by changing a variable
	sub_hse_pwr_con <- sub_hse_pwr_con_W4Ptn32dc3jF9h8h0BW8N3GSF5IGxB7J	
}


## Plotting Plot 3
png(file="plot3.png")
with(sub_hse_pwr_con,  plot(DateTime,Sub_metering_1,type='l',xlab="",ylab='Energy sub metering',col='Black'))
with(sub_hse_pwr_con, lines(DateTime,Sub_metering_2,col='Red'))
with(sub_hse_pwr_con, lines(DateTime,Sub_metering_3,col='Blue'))
legend('topright', legend=paste("Sub_metering_",1:3,sep=""), col=c("Black","Red","Blue"), lty=1)
dev.off()