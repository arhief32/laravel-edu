#$1 = schoolID
#$2 = school name

schoolDDL=`cat $PWD"/public/script/"schoolDDL.sql`
paramDDL="SET NAMES utf8mb4; SET FOREIGN_KEY_CHECKS = 0; CREATE DATABASE IF NOT EXISTS school$1; USE school$1; "
queryDDL="$paramDDL""$schoolDDL"
#echo "$queryDDL"

schoolDataDL=`cat $PWD"/public/script/"schoolData.sql`
paramData="USE school$1; set @schoolID='$1', @sname='$2'; "
queryData="$paramData""$schoolData"

mysql -h 172.18.133.135 -P 3306 -u root -proot -e "$queryDDL"
mysql -h 172.18.133.135 -P 3306 -u root -proot -e "$queryData"

