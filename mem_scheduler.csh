## cron daily: 
## if Memory 80% --> Send Daily
## if Memory > 50% --> Twice a week - Monday 8am and Thursday 8am
## if Memory < 50% --> Only on Monday 8am
 
 
#!/bin/bash
## Path of Disk Space to check:
mem_check_path="************************"
current_date=$(date "+%Y-%m-%d")
 
du_output=$(du -sh "$mem_check_path"/*)
df_output=$(df -h "$mem_check_path")
 
df_output_value=$(df -h | awk '$NF == "$mem_check_path" {print $5}' | tr -d %)
df_output_value=$((df_output_value))
 
email_subject="Disk Usage Report for the following scratch area on \" $current_date\" "

## Email Address for Receiving Party
recipient="*********************.com"
 
 
########### Email Format ###################### 
email_message="Hello Team,
Please find the disk usage report for path: \"$mem_check_path\" on $current_date
 
Disk Usage:
$du_output
 
Disk Space:
$df_output
 
Best regards,
Server"
 
##############################################
 
##Setting up threshold as above request    
    space_threshold=80
    low_threshold=50
 
# Disk space is 80% or more, run daily
    if [ "$df_output_value" -ge "$space_threshold" ]; then
    echo -e "$email_message" | mail -s "$email_subject" "$recipient"
 
 
# Disk space is between 50% and 80%, run twice a week
    elif [ "$df_output_value" -ge "$low_threshold" ]; then
 
    if [ "$(date +%u)" -eq 1 ] || [ "$(date +%u)" -eq 4 ]; then  # Monday and Thursday
    echo -e "$email_message" | mail -s "$email_subject" "$recipient"
    fi
    else
 
# Disk space is less than 50%, run once a week
    if [ "$(date +%u)" -eq 1 ]; then  # Run on Monday only
    echo -e "$email_message" | mail -s "$email_subject" "$recipient"
    fi
    fi
