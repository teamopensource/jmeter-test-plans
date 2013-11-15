<<<<<<< HEAD
postfix="119r" # e.g. 50_poll36r.svg
usercount=500
hostsfile="hosts.csv"
rampup=60 # sec
inputdelay=1000 #ms

java -jar C:/apache-jmeter-2.10/bin/ApacheJMeter.jar -n -t vote4.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

"C:/Program Files/R/R-3.0.2/bin/Rscript.exe" poll_dist4.r $usercount $postfix $hostsfile $rampup $inputdelay
=======
postfix="78r" # e.g. 50_poll36r.svg
usercount=5
hostsfile="testdata/hosts.csv"
debugfile="testdata/debugflags.csv"
rampup=1 # sec
inputdelay=1000 #ms

jmeter -t vote5.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jdebugfile=$debugfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

/usr/bin/Rscript poll_dist4.r $usercount $postfix $hostsfile $rampup $inputdelay
>>>>>>> 1fb42501cb73e1e72d7ca130476fde1f91ba6a22
