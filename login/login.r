header <- c("Start Time", "Sample Time(ms)", "Label", "Status Code", "Status", "Thread Name", "Data type", "Success", "Bytes", "Latency")

res50 <- read.csv("/home/niels/jmeter/loginresults/50_2.out", header = FALSE)
colnames(res50) <- header
res100 <- read.csv("/home/niels/jmeter/loginresults/100_2.out", header = FALSE)
colnames(res100) <- header
res150 <- read.csv("/home/niels/jmeter/loginresults/150_2.out", header = FALSE)
colnames(res150) <- header
res200 <- read.csv("/home/niels/jmeter/loginresults/200_2.out", header = FALSE)
colnames(res200) <- header


dev.new(width=8, height=8)
#svg("/home/niels/jmeter/50_1.svg", width=8, height=8)

par(mfrow=c(2,2))

res50post <- subset(res50, grepl("POST", Label))
latency <- res50post[, "Latency"]
plot(c(1:100), latency, ylim=c(0, 20000), main="50 login requests", xlab="Sample#", panel.first = grid())

res100post <- subset(res100, grepl("POST", Label))
latency <- res100post[, "Latency"]
plot(c(1:200), latency, ylim=c(0, 20000), main="100 login requests", xlab="Sample#", panel.first = grid())

res150post <- subset(res150, grepl("POST", Label))
latency <- res150post[, "Latency"]
plot(c(1:300), latency, ylim=c(0, 20000), main="150 login requests", xlab="Sample#", panel.first = grid())

res200post <- subset(res200, grepl("POST", Label))
latency <- res200post[, "Latency"]
plot(c(1:400), latency, ylim=c(0, 20000), main="200 login requests", xlab="Sample#", panel.first = grid())

#dev.off()