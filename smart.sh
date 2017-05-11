# get all disk identifier
disks=$(diskutil list | grep physical | awk '{print $1}')

# remove /dev/ prefix
disks=$(echo $disks | sed 's/\/dev\///')

for disk in $disks; do
 # get smart attributes for single disk
 lines=$(smartctl -s on -a $disk | grep '[0-9]\{1,\} .\{1,\} 0x')

 while read -r attribute; do
  #ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  id=`echo $attribute | awk '{print $1}'`
  name=`echo $attribute | awk '{print $2}' | tr - _`
  flag=`echo $attribute | awk '{print $3}'`
  value=`echo $attribute | awk '{print $4}'`
  worst=`echo $attribute | awk '{print $5}'`
  thresh=`echo $attribute | awk '{print $6}'`
  type=`echo $attribute | awk '{print $7}'`
  updated=`echo $attribute | awk '{print $8}'`
  whenfailed=`echo $attribute | awk '{print $9}'`
  raw=`echo $attribute | awk '{print $10}'`

  result=$(echo $disk.smart.$name $raw | awk '{print tolower($0)}')
  echo $result
 done <<< "$lines"

done
