# sshauthfail
Script to ban SSH brute force attacks.  Finds IP addresses with more than 20 failed attempts to log in to ssh, then blocks them from connecting.

Installation:
1. Create the folder /root/sshauthfail
2. Download badclients.sh and put it under /root/sshauthfail
3. Give it execute permission (e.g. chmod +x 700 /root/sshauthfail/badclients.sh)
4. Edit the root crontab to run /root/sshauthfail/badclients.sh at whatever interval you want. (crontab -e to edit, crontab -l to list)
