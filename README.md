# sshauthfail
Script to ban SSH brute force attacks.  Finds IP addresses with more than 20 failed attempts to log in to ssh, then blocks them from connecting.

Installation:
1. Create the folder /root/sshauthfail
2. Download badclients.sh and sendemail.sh and put them under /root/sshauthfail
3. Give it execute permission (e.g. chmod 700 /root/sshauthfail/badclients.sh /root/sshauthfail/sendemail.sh)
4. Edit the root crontab to run /root/sshauthfail/badclients.sh at whatever interval you want. (crontab -e to edit, crontab -l to list)
5. See crontab.txt for an example
6. Install geoiplookup (sudo apt install geoip-bin)
