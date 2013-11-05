postfix="71r" # e.g. 50_poll36r.svg
usercount=200
hostsfile="hosts.csv"
rampup=15 # sec
inputdelay=60000 #ms

jmeter -n -t vote4.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

/usr/bin/Rscript poll_dist3.r $usercount $postfix $hostsfile $rampup $inputdelay
