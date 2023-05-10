#!/bin/bash

#####################################################
# Reminder script (exec on boot):
# - to pay pay monthy bills
# - each second Sunday do...
# - Weekly reminder for ...
#
#  started via crontab tool
#  crontab -e
#  @reboot sleep 60 ; /home/macko/reminder_sh
#####################################################

sleep 3


# Call script for bills payment reminder
# it's recomended to use fullpath to avoid possible issues with startup tool
exec /home/username/.reminder/bills.sh


# Call script for bills payment reminder script 1


# Call script for bills payment reminder script 2


# Call script for bills payment reminder script 3
