# Monthly_Bills_Reminder
Every month on regular basis I have more than 15 monthly bills to be payed until certain date in the month mainly until 15<sup>th</sup> or latest by 20<sup>th</sup> of each month. Latelly there were several bills payment ommisions, reminders from providers and additional interest fees that I had to pay for some of them.

Therefore I created simple bash script that runs on PC startup and display monthly bills payment status, using zenity tool graphical windfows. Currently I use Ubintu, but previously the script was working fine also on MX linux. 

## Script and files locations
The script (```reminder.sh```) is located in home directory and is started via crontab tool by following setup:
> ``` @reboot sleep 30 ; /home/user_name/reminder_sh ``` - where 30 sec delay is to avoid possible startup isses, I use Ubuintu, but can be addopted  in different ways depending on your OS and ways to startup the script. 

> the reminder script is calling another script ```bills.sh``` located in /home/user_name/.reminder directory, where also ```bills.txt``` active bills file is stored together with '''bills.log''' file that log the changes in active bills file. 

> I use this folder for other reminder scripts created for various reasons and called via main reminder script


## How it works

### first startup
> When the script is first started, it checks if bills files exist and create them if not.
> Create initial predefined bills by making a combination of two arrays: locations (home, parrents, location 3, ...)  and bill type (electricity, water, heating , phone/internet, ...), adding month of payment and "not payed" status 
> open window using "zenity" tool, showing list of all bills for payment where new bills can be added and stored in bills.txt file  

### Regular use
> on PC startup it will show a window with payment status of monthly bills, where you can make manual corrections for the payed ones 
> at every startup (usually in begining of month), script check if new predefined bills for current month are stored in bills.txt. If not, it will be created automaticaly.
> If there are bills with "payed" status from previous month, you have button option to remove from bills.txt via separate confirmation window.
> all the changes in bills.txt file are store in separate bills.log file ("diff" command format output is used with timestamp line)

## My comments
After I started script use, I did not miss any payment so far.
The script is initially created for practical reasons, but also for recreational purpose to keep in shape my "long time ago forgoten" knowledge in unix shel scripting.
For learning purposes I plan to do more advanced version by using python and DB tables instead of text file, Also as an executable program adopted for Windows.

