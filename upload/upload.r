library("stringr")

args <- commandArgs(trailingOnly = TRUE)
usercount <- args[1]
outputdir <- args[2]
hostsfile <- args[3]
rampup <- args[4]
inputdelay <- args[5]

# Parse and add header
header <- c("Start Time", "Sample Time(ms)", "Label", "Status Code", "Status", "Thread Name", "Data type", "Success", "Bytes", "Latency")
res <- read.csv(paste(outputdir, "/upload-", usercount, ".out", sep=""), header = FALSE)
colnames(res) <- header

# Parse hosts
hosts <- as.vector(read.csv(hostsfile, header = FALSE)[,1])
hosts <- c(hosts, rep("", 4 - length(hosts)))

filnplot <- function(grepby)
{
	filtered <- subset(res, grepl(grepby, Label))

	times <- filtered[,"Start Time"]
	start <- min(times)
	times <- times - start

	yaxis <- c(1:length(times))

	latency <- filtered[, "Latency"]
	end <- times + latency

	plot(times, yaxis, ylim=c(0, length(times)), xlim=c(0, max(end)), main=grepby, ylab="Latency (ms)", xlab="Sample#", panel.first = grid())	
	segments(times, yaxis, end, yaxis)
}

filplotdraw <- function(grepby, outpath)
{
	# Start output "device"
	svg(outpath, width=12, height=8)

	# Layout for 2/3 diagram and 1/3 info box
	layout(matrix(c(1,1,2,1,1,2), 2, 3, byrow = TRUE))

	# Filter and plot
	filnplot(grepby)

	# Right-side info box
	plot(c(-1), c(-1), ylim=c(-1,1), xlim=c(-1,1), xaxt='n', yaxt='n', ann=FALSE, col='white')
	labels <- c("Node 1: ", "Node 2: ", "Node 3: ", "Node 4: ", "", "User count: ", "Ramp-up: ", "Input delay: ")
	ypos <- seq(1,1+(length(labels)-1)*(-0.1),-0.1)
	text(x = c(-1, -1, -1, -1), y = ypos, labels = labels, pos=4, font=2)
	values <- append(hosts, c("", usercount, paste(rampup,"secs",sep=" "), paste(inputdelay,"ms",sep=" ")))
	text(x = c(-0.5), y = ypos, labels = values, pos=4)

	# Close output "device"
	dev.off()
}

filplotdraw("GET: Login", paste(outputdir, "/upload-", usercount, "-getlogin.svg", sep=""))
filplotdraw("POST: Login", paste(outputdir, "/upload-", usercount, "-postlogin.svg", sep=""))
filplotdraw("GET: View assignment", paste(outputdir, "/upload-", usercount, "-viewasign.svg", sep=""))
filplotdraw("GET: Show add submission form", paste(outputdir, "/upload-", usercount, "-showsubm.svg", sep=""))
filplotdraw("POST: Upload file", paste(outputdir, "/upload-", usercount, "-uploadfile.svg", sep=""))
filplotdraw("POST: Save submission", paste(outputdir, "/upload-", usercount, "-savesubm.svg", sep=""))


# Draw summery bar chart
svg(paste(outputdir, "/upload-", usercount, "-summary.svg", sep=""), width=12, height=8)

layout(matrix(c(1,1,2,1,1,2), 2, 3, byrow = TRUE))

times <- res[,"Sample Time(ms)"]
barplot(times)

tmean <- round(mean(times), digits = 0)
tsd <- sd(times)
grey <- rgb(122,122,122, max=255)
abline(h = tmean, col = grey)
abline(h = tmean + tsd, lty = 2, col = grey)
abline(h = tmean - tsd, lty = 2, col = grey)
text(x = 0, y = tmean, labels = tmean, pos = 1, font=2, col = grey)

plot(c(-1), c(-1), ylim=c(-1,1), xlim=c(-1,1), xaxt='n', yaxt='n', ann=FALSE, col='white')
labels <- c("Node 1: ", "Node 2: ", "Node 3: ", "Node 4: ", "", "User count: ", "Ramp-up: ", "Input delay: ")
ypos <- seq(1,1+(length(labels)-1)*(-0.1),-0.1)
text(x = c(-1, -1, -1, -1), y = ypos, labels = labels, pos=4, font=2)
values <- append(hosts, c("", usercount, paste(rampup,"secs",sep=" "), paste(inputdelay,"ms",sep=" ")))
text(x = c(-0.5), y = ypos, labels = values, pos=4)

dev.off()