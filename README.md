Save the mem_scheduler.csh in the home directory

Edit the path and email address in the script

Trigger the crontab scheduler on the terminal which will make the script run automatically at 8AM daily.

Edit the crontab file: Use the following command to edit your user's crontab file:
  crontab -e

Add the cron job: In the editor that opens, add the following line to run your script at 8 AM every day:
  0 8 * * * /path/to/your/mem_scheduler.csh
