postfix="78r" # e.g. 50_poll36r.svg
usercount=5
hostsfile="hosts.csv"
debugfile="debugflags.csv"
rampup=1 # sec
inputdelay=1000 #ms

jmeter -t vote5.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jdebugfile=$debugfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

/usr/bin/Rscript poll_dist4.r $usercount $postfix $hostsfile $rampup $inputdelay