args <- commandArgs()

inname <- args[6]
outname <- args[7]
rows <- read.csv(inname, header=FALSE)

cols <- c("keyword", "calls", "total_calls", "percent_calls", "time", "total_time", "percent_time")
colnames(rows) <- cols

keywords <- rows[,"keyword"]
percent_time <- rows[,"percent_time"]
percent_calls <- rows[,"percent_calls"]
time <- rows[,"time"]
calls <- rows[,"calls"]

print(keywords)
print(percent_time)
print(percent_calls)

svg(outname, width=12, height=8)

par(mfrow=c(1, 2))

colors <- rainbow(length(keywords))

pie(
	percent_time,
	col=colors,
	labels=percent_time,
	main="Time spent in methods in %"
)

legend(
	0, 1.3,
	keywords,
	fill=colors
)

pie(
	calls,
	col=colors,
	labels=calls,
	main="Calls to methods"
)

legend(
	0, 1.3,
	keywords,
	fill=colors
)