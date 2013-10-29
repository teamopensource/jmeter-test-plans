postfix="17r" # e.g. 50_poll36r.svg
usercount=100
hostname=192.168.1.100
rampup=60 # sec
inputdelay=5000 #ms

jmeter -n -t vote2.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostname=$hostname -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

#/usr/bin/Rscript poll_dist3.r $usercount $postfix