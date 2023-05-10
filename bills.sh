#!/bin/bash


###########################################################
# Monthly bills payment reminder script  (exec on boot):  #
#  crontab -e				                  #
#  @reboot sleep 30 ; /home/username/reminder.sh          #
###########################################################


# Define the file names for the active bills and log files 
# it's recomended to use fullpath to avoid possible issues with startup tool

bills_file="/home/username/.reminder/bills.txt"
log_file="/home/username/.reminder/bills.log"


# Check function if bills file exists, if not create an empty file with header

function check_file() {
	local file1=$1		# ./bills.txt
	local file2=$2		# ./bills.log
	if [ ! -f "$file1" ]; then
		touch "$file1"		# create bills.txt 
		# Add header text
		printf "%-30s %-7s %-20s\n" "Bill" "Month" "Payment status" > $file1
		printf "%57s\n" | tr " " "=" >> $file1
		# store file creation info in bills.log file
		echo "`date +%d-%m-%y@%H:%M%2t` Created new file \"$file1\" " > $file2
		echo >> $file2
	fi
}


# Function to check if new month bills are added, and add into bills file

function new_month_add() {
	local month=$1		# current mm-yy
	local file=$2		# temporary bills.txt.xx used throughug script execution
	if grep -q $month $file 
	then
	        return
	else
		# change here manually locations for which you pay bills, e.g. "location 1" -> "home"
	    	local lokacija=("location 1" "location 2" "location 3")

		# change here manually the regular bills for above locations (surplus ones can be deleted later)
	        local tip=("electricity" "water supply" "heating")
	        for item1 in "${lokacija[@]}"; do
		        for item2 in "${tip[@]}"; do
        		combination="$item1-$item2"
            		printf "%-30s %-7s %-20s\n" "$combination" "$month" "not payed" >> $file
          		done
        	done
		# add other regular monthly bills 
		printf "%-30s %-7s %-20s\n" "Telekom bill" "$month" "not payed" >> $file
        	printf "%-30s %-7s %-20s\n" "Mobile Phone" "$month" "not payed" >> $file
		printf "%-30s %-7s %-20s\n" "Credit card" "$month" "not payed" >> $file
        	printf "%-30s %-7s %-20s\n" "Mortgage" "$month" "not payed" >> $file
        	printf "%-30s %-7s %-20s\n" "Other bill" "$month" "not payed" >> $file
        fi
}


# Check function if last month bills are payed and remove them if confirmed

function last_month_remove() {
	local file1=$1		# temporary bills.txt.xx
	local file2=$2		# ./bills.txt
	current_year=$(date +%y)
	current_month=$(date +%m)

	# Calculate the year and month of the last month
	if [ "$current_month" -eq 1 ]; then
		last_month_year=$((current_year - 1))
		last_month=12
	else
		last_month_year="$current_year"
		last_month=$((current_month - 1))
	fi

	# Store the last month value in a variable
	last_month_value="$last_month-$last_month_year"

	# create temporary file old_bills.xx	
	grep "$last_month_value   payed" $file1 > "old_bills".$$

	# Display confirmation prompt
	env DISPLAY=:0.0 /usr/bin/zenity --text-info --filename="old_bills".$$ --title="Delete old bills?" --width=700 --height=250 --font="Monospace bold 12" --ok-label "Delete" --cancel-label "Cancel" && grep -v "$last_month_value   payed" $file1 > $file2 || cp $file1 $file2
	rm "old_bills".$$

}


# Function that store bills file changes into a log file

function log_changes() {
	local file1=$1		# bills.txt
	local file2=$2		# temporary bills.txt.xx
	local file3=$3		# bills.log file
	
	# store changes in log file
	if [ $(diff $file1 $file2 | wc -l) -gt 0 ]; then
		echo "`date +%d-%m-%y@%H:%M%2t` Changes in bills list: removed (<) or added (>) lines" >> $file3 
		diff $file1 $file2 | tail -n +2 >> $file3
		echo >> $file3		
	fi
}


# Call function to check if the files exist, if not create an empty files
check_file $bills_file $log_file


# Copy active bills file into temporary file used by the script
cp $bills_file "$bills_file".$$


# Call function to check if new month bills are added
new_month_add `date +%m-%y` "$bills_file".$$
log_changes $bills_file "$bills_file".$$ $log_file


# Check if file have open bills, if yes then display window with bills where user can also input and edit the list
# If all bils are payed the windoiw will not be shown

if grep -q "not payed" "$bills_file".$$; then0
	env DISPLAY=:0.0 /usr/bin/zenity --text-info --editable --filename="$bills_file".$$ --width=700 --height=600 --font="Monospace bold 12" --title="Monthly Bills - payment change status" --ok-label "Change and exit" --cancel-label "Delete old bills" > $bills_file || last_month_remove "$bills_file".$$ $bills_file
fi


log_changes "$bills_file".$$ $bills_file $log_file


# remove the temporary file
rm "$bills_file".$$
