library("stringr")

args <- commandArgs(trailingOnly = TRUE)
usercount <- args[1]
postfix <- args[2]
hostsfile <- args[3]
rampup <- args[4]
inputdelay <- args[5]
datafolder <- "/home/niels/jmeter/loginresults/"

# Parse and add header
header <- c("Start Time", "Sample Time(ms)", "Label", "Status Code", "Status", "Thread Name", "Data type", "Success", "Bytes", "Latency")
res <- read.csv(paste(datafolder, usercount, "_poll", postfix, ".out", sep=""), header = FALSE)
colnames(res) <- header

# Parse hosts
hosts <- as.vector(read.csv(hostsfile, header = FALSE)[,1])
hosts <- c(hosts, rep("", 4 - length(hosts)))

# Filter and plot
filnplot <- function(data, grepby)
{
	filtered <- subset(data, grepl(grepby, Label))

	#for (i in 1:length(filtered))
	#{
	#	tm <- filtered[i]
	#	id = str_match("1-(\\d+),", tm["Thread Name"])
	#}


	times <- filtered[,"Start Time"]
	start <- min(times)
	times <- times - start

	yaxis <- c(1:length(times))

	latency <- filtered[, "Latency"]
	end <- times + latency

	plot(times, yaxis, ylim=c(0, length(times)), xlim=c(0, max(end)), main=grepby, ylab="Latency (ms)", xlab="Sample#", panel.first = grid())	
	segments(times, yaxis, end, yaxis)
}

# Start output "device"
svg(paste(datafolder, usercount, "_poll", postfix, ".svg", sep=""), width=12, height=8)

# 4 times filter and plot
layout(matrix(c(1,1,2,1,1,2), 2, 3, byrow = TRUE))
filnplot(res, "GET: Login")
#filnplot(res, "POST: Login", "Latency")
#filnplot(res, "GET: Poll", "Latency")
#filnplot(res, "POST: Poll", "Latency")

# Right-side info box
plot(c(-1), c(-1), ylim=c(-1,1), xlim=c(-1,1), xaxt='n', yaxt='n', ann=FALSE, col='white')
labels <- c("Node 1: ", "Node 2: ", "Node 3: ", "Node 4: ", "", "User count: ", "Ramp-up: ", "Input delay: ")
ypos <- seq(1,1+(length(labels)-1)*(-0.1),-0.1)
text(x = c(-1, -1, -1, -1), y = ypos, labels = labels, pos=4, font=2)
values <- append(hosts, c("", usercount, paste(rampup,"secs",sep=" "), paste(inputdelay,"ms",sep=" ")))
text(x = c(-0.5), y = ypos, labels = values, pos=4)

# Close output "device"
dev.off()