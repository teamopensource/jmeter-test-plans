postfix="22-nov-001-110-d5-u10-r30-i5"
usercount=10
hostsfile="hosts.csv"
debugfile="debugflags.csv"
rampup=30 # sec
inputdelay=5000 #ms
server=110
localfolder="./php-profiling-data"
cap=0

#jmeter -t../vote5.jmx -Jusercount=$usercount -Joutpostfix=$postfix -Jhostsfile=$hostsfile -Jdebugfile=$debugfile -Jrampup=$rampup -Jinputdelay=$inputdelay
#wait

# Rscript ../poll_dist4.r $usercount $postfix $hostsfile $rampup $inputdelay

## move output to subdirectory on server
#ssh moodle@192.168.1.$server "mkdir /var/tmp/$postfix; cd /var/tmp/$postfix; mv /var/tmp/cachegrind.* /var/tmp/$postfix"

## copy output to local directory
#mkdir "$localfolder"
#mkdir "$localfolder/$postfix"
#scp moodle@192.168.1.$server:/var/tmp/$postfix/cachegrind.* "$localfolder/$postfix/."

## convert kcachegrind to csv - individually
#python ./conversion/k-to-csv.py --i "$localfolder/$postfix" --o "$localfolder/$postfix-csv-individual" --cap $cap
## convert kcachegrind to csv - all
python ./conversion/k-to-csv-all.py --i "$localfolder/$postfix" --o "$localfolder/$postfix-csv-all" --cap $cap

## convert csv to graph - individually
#python ./visualization/individual.py --i "$localfolder/$postfix-csv-individual" --o "$localfolder/$postfix-graph-individual"
## convert csv to graph - all
#python ./visualization/all.py --i "$localfolder/$postfix-csv-all" --o "$localfolder/$postfix-graph-all"