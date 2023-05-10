# Monthly_Bills_Reminder
Every month on regular basis I have more than 15 monthly bills to be payed until certain date in the month mainly until 15<sup>th</sup> or latest by 20<sup>th</sup> of each month. Latelly there were several bills payment ommisions, reminders from providers and additional interest fees that I had to pay for some of them.

So I created simple bash script that runs on PC startup and display monthly bills payment status, with zenity graphical tool to show bills status in a window. 

## Script and files locations
Main script (```reminder.sh```) in home directory and started via crontab tool by following setup:

> ``` @reboot sleep 30 ; /home/user_name/reminder_sh ``` - where 30 sec delay is to avoid possible startup isses, it works on Ubuntu, previously used on MX linux with different startup setup, and should be addopted accordinlgy depending on your OS and ways you want to startup the script. 

> I use ```reminder.sh``` script for other reminder scripts created for various reasons, therefore separate folder is used to store several reminding scripts. Here I put only montly bills reminder script part

Here the reminder script is only used for calling the main bill payment reminder script ```bills.sh``` located in /home/user_name/.reminder directory, where also ```bills.txt``` active bills file is stored together with ```bills.log``` file that log the changes in active bills file. 

> Note that manuall input in script is needed for exact files variables (use full path to avoid errors)

> It requires installing zenity tool, if not there by default 


## How it works

### First startup
> When the script is first started, it checks if bills and log files exist and create them.

> Create initial predefined bills by making a combination of two lists: locations (home, parrents, location 3, ...)  and bill type (electricity, water, heating , phone/internet, ...), adding month of payment and "not payed" status. These lists have to be manualy adopted in the code, there is no dialog for creating them.

> Finaly opens window ("zenity" tool - from filetext), showing list of all bills for payment where new bills can be added and stored in bills.txt file

### Regular use
> On PC startup, the script will show a window with payment status of monthly bills, where you can make manual corrections for the payed ones and store the changes

> If all monthly bills are with "payed" status the script will not show the window, until first PC startup in the next month. 

> At every startup (usually in begining of month), script check if new predefined bills for current month are stored in bills.txt. 

> If new month bills are not not in the file, it will be created automaticaly.

> If there are bills with "payed" status from previous month, you have button option to remove from bills.txt via separate confirmation window.

> all the changes in bills.txt file are store in separate bills.log file ("diff" command format output is used with timestamp line)

## My comments
After I started script use, I did not miss any payment so far.
The script is initially created for practical reasons, but also for recreational purpose to keep in shape my "long time ago forgoten" knowledge in unix shel scripting.

