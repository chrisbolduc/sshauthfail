#!/bin/bash
# 2018-02-21 CJB
# Updated 2019-11-06 CJB
# Updated 2020-04-17 CJB

NOW=`date`
#echo "${NOW} Running" >> /root/sshauthfail/log.txt

grep 'Failed password' /var/log/secure | cut -d ' ' -f 13 >> /root/sshauthfail/badhosts_in.txt

sort /root/sshauthfail/badhosts_in.txt | uniq > /root/sshauthfail/badhosts_in_sorted.txt

# Remove 127, 192.168.
# Grep for valid IPv4 addresses: grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'
diff --suppress-common-lines /root/sshauthfail/badhosts_in_sorted.txt /root/sshauthfail/badhosts.txt | grep "<" | cut -d " " -f 2 | grep -v "127\.\|192\.168\." | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' > /root/sshauthfail/badhosts_new.txt

cat /root/sshauthfail/badhosts_new.txt /root/sshauthfail/badhosts.txt | sort | uniq > /root/sshauthfail/badhosts2.txt
mv /root/sshauthfail/badhosts2.txt /root/sshauthfail/badhosts.txt
rm /root/sshauthfail/badhosts_in.txt /root/sshauthfail/badhosts_in_sorted.txt

NEWBADDIES=`cat /root/sshauthfail/badhosts_new.txt`

for N in $NEWBADDIES; do
        COUNT=`grep $N /var/log/secure | wc -l`
#       echo "Host: $N Count: $COUNT"
        if [ $COUNT -gt 20 ]; then
                HN=`nslookup $N | grep 'name ='`
                GEOIP=`geoiplookup $N | cut -d ':' -f 2`
                echo "$NOW - $N" >> /root/sshauthfail/log.txt
                echo "<tr><td>$NOW</td><td>$N</td><td>$HN</td><td>$GEOIP</td></tr>" >> /root/sshauthfail/today.log
                # Uncomment to block the offending IP
#                /usr/sbin/iptables -I INPUT -s $N -j DROP
        fi
done

#rm /root/sshauthfail/badhosts_new.txt
