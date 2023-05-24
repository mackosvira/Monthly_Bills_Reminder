# Monthly_Bills_Reminder
Simple reminder script that can be usefull if you have 10+ monthly bills, to avoid reminders and additional fees to be paid.

It is simple bash script that runs on PC startup and display monthly bills payment status on simple GUI, using zenity tool, to list bills status with possibility to make changes.
If  you don't have zenity tool you can install with:
> ``` $ sudo apt-get install zenity ```

I use it on Ubuntu, via reminder.sh script running on PC startup (to remind you before starting to do anything else you had in mind): 
> ``` @reboot sleep 30 ; /././reminder_sh ``` - 30 sec delay is to avoid some startup isses (previously used on MX linux, with different startup setup)

## Script and files locations
Main script (```reminder.sh```) is in home directory, used for other reminder scripts for various reasons, therefore I use separate folder ".reminder" to store similar scripts (other reminders)

Bill payment reminder script ```bills.sh``` I place in /.reminder directory, where script creates ```bills.txt``` active bills file,  and ```bills.log``` file that log the changes in active bills file. 

> Note that manuall input in script is needed for exact file paths (use full path to avoid errors)


## How it works

### First startup
> When the script is first started, it checks if bills and log files exist and create them.

> Create initial predefined bills by making a combination of two lists: locations (home, parrents, location 3, ...)  and bill type (electricity, water, heating , phone/internet, ...), adding month of payment and "not payed" status. These lists have to be manualy adopted in the code, there is no dialog for creating them.

> Then it opens window ("zenity" tool - from filetext), showing list of all bills for payment where new bills can be added and stored in bills.txt file

### Regular use
> On PC startup, the script will show a window with payment status of monthly bills, you can make manual corrections for the payed ones and store the changes

> If all monthly bills are with "payed" status the script will not show the window, until first PC startup in the next month. 

> At every startup (usually in begining of month), script check if new predefined bills for current month are stored in bills.txt. 

> If new month bills are not not in the file, it will be created automaticaly.

> If there are bills with "payed" status from previous month, you have button option to remove from bills.txt via separate confirmation window.

> all the changes in bills.txt file are store in separate bills.log file ("diff" command format output is used with timestamp line)

## My comments
The script is initially created for practical reasons, but also for recreational purpose to keep in shape my "long time ago forgoten" knowledge in unix shel scripting.

