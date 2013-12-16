usercount=30
hostsfile="testdata/hosts.csv"
debugfile="testdata/debugflags.csv"
rampup=30 # sec
inputdelay=5000 #ms

qcount=5

#outputdir="results/131126-1119-quiz-200"
outputdir=$(date '+results/%y%m%d-%H%M'-quiz-$usercount)
#mkdir $outputdir

jmeter -t quiz.jmx -Jusercount=$usercount -Joutputdir=$outputdir -Jhostsfile=$hostsfile -Jdebugfile=$debugfile -Jrampup=$rampup -Jinputdelay=$inputdelay
wait

/usr/bin/Rscript quiz.r $usercount $outputdir $hostsfile $rampup $inputdelay $qcount