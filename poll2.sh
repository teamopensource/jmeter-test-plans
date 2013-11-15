postfix="119r" # e.g. 50_poll36r.svg
usercount=500
hostsfile="hosts.csv"
rampup=60 # sec
inputdelay=1000 #ms

java -jar C:/apache-jmeter-2.10/bin/ApacheJMeter.jar -n -t vote4.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

"C:/Program Files/R/R-3.0.2/bin/Rscript.exe" poll_dist4.r $usercount $postfix $hostsfile $rampup $inputdelay
