# get all disk identifier
disks=$(ls /sys/block | grep -v loop)

# remove /dev/ prefix

scripts=$(dirname "$0")

for file in /var/lib/smartmontools/smartd.*; do
 filename="${file##*/}"
 filename=$(echo $filename | sed 's/smartd.//' | sed 's/.ata.state//')
 content=$(cat $file | grep -v file) 
 attributes=$(echo "$content" | grep ata-smart-attribute)
 other=$(echo "$content" | grep -v ata-smart-attribute)
 #echo "$attributes"

 ids=$(echo "$attributes" | grep id | awk '{print $3}')
 for id in $ids; do
  #echo "ata-smart-attribute\.[0-9]*\.id \= $id"
  attributeid=$(echo "$attributes" | grep "ata-smart-attribute\.[0-9]*\.id \= $id$")
  attributeid=$(echo "$attributeid" | sed "s/ata-smart-attribute.//" | sed "s/.id.*//")
  value=$(echo "$attributes" | grep "\.$attributeid\.val" | awk '{print $3}')
  raw=$(echo "$attributes" | grep "\.$attributeid\.raw" | awk '{print $3}')
  worst=$(echo "$attributes" | grep "\.$attributeid\.worst" | awk '{print $3}')

  $scripts/_report.sh drive.$filename.smart.$id.value $value
  $scripts/_report.sh drive.$filename.smart.$id.raw $raw
  $scripts/_report.sh drive.$filename.smart.$id.worst $worst

 done
done
