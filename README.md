# sshauthfail
Script to ban SSH brute force attacks.  Finds IP addresses with more than 20 failed attempts to log in to ssh, then blocks them from connecting.

Installation:
1. Create the folder /root/sshauthfail
2. Download badclients.sh and put it under /root/sshauthfail
3. Give it execute permission (e.g. chmod +x 700 /root/sshauthfail/badclients.sh)
4. Edit the root crontab to run /root/sshauthfail/badclients.sh at whatever interval you want.
  
Crontab Example:
The below code will check every 15 minutes for too many failed logins and send an email every day at midnight
1. Run crontab -e to edit your crontab
2. Paste the below code there if none exists:

# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
#
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').#
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
#
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
#
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
#
# For more information see the manual pages of crontab(5) and cron(8)
#
# m h  dom mon dow   command
MAILTO=you@example.com
*/15 * * * * /root/sshauthfail/badclients_local.sh
59 23 * * * /root/sshauthfail/sendemail.sh


