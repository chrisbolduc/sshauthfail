#!/bin/bash

# Uncomment if you don't want to get an email if there are no blocks
# (You might still want the reminder that the script is working.)
#if [ -z /root/sshauthfail/today.log ] then
#       exit 0
#fi

LOGFILE=`cat /root/sshauthfail/today.log`

    (
    echo "From: ${HOSTNAME}@example.com";
    echo "To: you@example.com"
    echo "Subject: ${HOSTNAME} SSH block log";
    echo "Content-Type: text/html";
    echo "MIME-Version: 1.0"
    echo "";
    echo "<html><body>"
#    curl "https://www.melissa.com/v2/lookups/iplocation/ip/?ip=${N}" 2>/dev/null | grep "panel-heading text-center" -B1 -A52 | grep "<table" -A52;
    echo "<p>SSH block log:<br/><table border=1>${LOGFILE}</table></p>";
    echo "</body></html>"
    ) | /usr/sbin/sendmail -f sender@example.com recipient@example.com
rm /root/sshauthfail/today.log
touch /root/sshauthfail/today.log
