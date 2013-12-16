usercount=100
hostsfile="testdata/hosts.csv"
rampup=30 # sec
inputdelay=5000 #ms

#outputdir="results/131212-1639-upload-75"
outputdir=$(date '+results/%y%m%d-%H%M'-upload-$usercount)
#mkdir $outputdir

jmeter -t upload.jmx -Jusercount=$usercount -Joutputdir=$outputdir -Jhostsfile=$hostsfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

/usr/bin/Rscript upload.r $usercount $outputdir $hostsfile $rampup $inputdelay