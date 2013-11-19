args <- commandArgs()

inputfile <- paste(args[6], "all.csv", sep="/")
outputfile <- paste(args[7], "all.svg", sep="/")

header <- c("Request", "Timestamp", "File", "Function", "Linenumber", "Microseconds")

allRequests <- read.csv(inputfile, header=FALSE)
colnames(allRequests) <- header

uniqueRequests <- sort(unique(allRequests[,"Request"]))
uniqueRequestsCount <- length(uniqueRequests)

plotCols <- 2
plotRows <- ceiling(uniqueRequestsCount / 2)

plotRequest <- function(data, request) {
	#print(nrow(data))

	filtered <- subset(data, Request == request) # rows for specific request

	#print(nrow(filtered))

	functions <- unique(filtered[, "Function"])
	timestamps <- sort(unique(filtered[, "Timestamp"]))

	xaxis <- c(0, length(timestamps))
	yaxis <- c(0, 4 * 1000 * 1000)

	#print(length(timestamps))

	plot(
		xaxis,
		yaxis,
		panel.first = grid()
	)

	for (func in functions) {
		funcFiltered <- subset(filtered, Function == func)

		x <- c()
		y <- c()

		i <- 0

		for (timestamp in timestamps) {
			timeFiltered <- subset(funcFiltered, Timestamp == timestamp)
			time <- sum(timeFiltered[, "Microseconds"])

			x <- c(x, i)
			y <- c(y, time)

			i <- i + 1
		}

		lines(x, y, type="l")
	}
}

#dev.new(width=4*plotCols, height=4*plotRows)
svg(outputfile, width=4*plotCols, height=4*plotRows)

par(mfrow=c(plotRows, plotCols))

for (request in uniqueRequests) {
	plotRequest(allRequests, request)
}

# plotRequest(allRequests, uniqueRequests[1])

dev.off()