#!/bin/bash

Start_input="$1"
End_input="$2"
max_val=400000
min_val=30000
random_val=$min_val
cnt=0;
Min_time_gap=4
Max_time_gap=10
break_min=2;
break_max=7;
check_file=0;
Track_id=0
break_line=$(( $RANDOM % $break_max ));
                if [ $break_line -le $break_min ]
                 then
                echo "break_line value is ===$break_line" 
                 break_line=2
                fi

j_day=$(echo $(date +%j))
echo "todays julian day====$j_day"
file="/home/gaian/FV$j_day.BPL"
if [ -f "$file" ]
    then
    printf "$file found.\n"
    rm  $file;
else
    printf "$file not found.\n"
    fi
#        printf "max=====$max,min====$min\n"
#for i in {1..5}
while [ 1 ]
do
   while [ 1 ]
   do
	tmp=$RANDOM
	echo "tmp value is ===$tmp\n"
	echo "random_val ======$random_val\n"
	#var=$(( $tmp % $max_val ));
	var=$(( $random_val % $max_val ));
                ((random_val++))
	        ##break_line=$(( $RANDOM % $break_max ));
	        ##if [ $break_line -le $break_min ]
	         ##then
	        ##echo "break_line value is ===$break_line" 
	        ## continue;
	        ##fi
	#printf "var value   $var min value is $min_val\n"
	if [ $var -le $min_val ]
	then
	printf "in if\n"
		continue;
	else
	{

########################################writing random transaction IDS
        printf "line transaction ids=====$var\n"
########################################
	FILE=/home/gaian/mp4_files.txt

	# get line count for $FILE (simulate 'wc -l')
        lc=0
        while read -r line; do
         ((lc++))
        done < $FILE

        # get a random number between 1 and $lc
        rnd=$RANDOM
        let "rnd %= $lc"
	 ((rnd++))

        # traverse file and find line number $rnd
         i=0
        while read -r line; do
	 ((i++))
	 [ $i -eq $rnd ] && break
        done < $FILE

        # output random line
         printf '2nd========%s\n' "$line"
         
         mp4_name="$(echo $line | awk '{print $1}')"
         dur="$(echo $line | awk '{print $2}')"
	 echo "dur========$dur"



#########################################
       printf 'Start_time=====%s\n' "$Start_input"
       SavedIFS="$IFS"
       IFS=":"
       Time=($Start_input)
       #Total_sec=$((${Time[0]}*3600 + ${Time[1]}*60 + ${Time[2]}))
       s_hr=${Time[0]#0}
       s_min=${Time[1]#0}
       s_sec=${Time[2]#0}
       printf 'Strating hr:min:sec:ms========%.2d:%.2d:%.2d' "$s_hr" "$s_min" "$s_sec" 
       IFS="$SavedIFS"
       ######convert the  Starting time into seconds
       Total_sec=$(( $(($s_hr * 3600)) + $(( $s_min * 60 )) + $s_sec))
       echo "total_sec=====$Total_sec"


###########################################adding the duration to get the End time


         End_time=$(( $Total_sec + $(($dur)) ))

##########################Checking is it less than the EndTime_input or not

         SavedIFS="$IFS"
         IFS=":"
         E_Time=($End_input)
         E_Total_sec=$((${E_Time[0]}*3600 + ${E_Time[1]}*60 + ${E_Time[2]}))
         IFS="$SavedIFS"
         echo "endtime in secs=====$End_time,E_Total_sec========$E_Total_sec"
         if [ $End_time -gt $E_Total_sec ]
         then
         echo "End_time is greater than E_Total_sec .....\n"
         check_file=1
    break;
  fi


##########################
	hr=$(($End_time/3600))
	min=$(($(($End_time-$(($hr*3600)))) / 60))
	sec=$(($End_time%60))
	printf -v Formated_ET '%.2d:%.2d:%.2d:00\n' "$hr" "$min" "$sec"
	printf 'Formatted end_time=====%s\n' "$Formated_ET"

###########################################
	if [ $cnt -eq 0 ]
	then
	POS="F"
	echo " F  Before incrementing cnt=====$cnt,break_line====$break_line" 
	((cnt++))
	elif [ $cnt -eq $break_line ]
	then
	POS="L"
	echo " L  Before incrementing cnt=====$cnt,break_line====$break_line" 
       flag=1 
	cnt=0
	else 
	POS="M"
	echo "M  Before incrementing cnt=====$cnt,break_line====$break_line" 
	((cnt++))
	fi
##############################################################Replace or not
	FILE=/home/gaian/R_N.txt

	# get line count for $FILE (simulate 'wc -l')
	lc3=0
	while read -r R_N; do
	 ((lc3++))
	done < $FILE

	# get a random number between 1 and $lc 
	rnd3=$RANDOM
	let "rnd3 %= $lc3"
	((rnd3++))

	# traverse file and find line number $rnd
	i3=0
	while read -r R_N; do
	 ((i3++))
	 [ $i3 -eq $rnd3 ] && break
	done < $FILE

	# output random line
	printf '7th========%s\n' "$R_N"



############################printing the Id,start_time,end_time,duration in BPL file
	printf -v string '%s %s %s %s %s %s %s %s' "$var" "$mp4_name" "$Start_input" "$Formated_ET" "$dur" "$POS" "$R_N" "$Track_id"
	printf 'STRING=============%s' "$string"
	echo $string >> $file



##################################################after each break add some time
        if [ "$POS" = L ]
        then
           time_gap=$(( $RANDOM % $Max_time_gap ));
           if [ $time_gap -le $Min_time_gap ]
           then
              time_gap=4
           fi
           End_time=$(( $End_time + $(($time_gap * 60)) ))
           hr=$(($End_time/3600))
           min=$(($(($End_time-$(($hr*3600)))) / 60))
           sec=$(($End_time%60))
           printf -v Formated_ET '%.2d:%.2d:%.2d:00\n' "$hr" "$min" "$sec"
           printf '########Formatted end_time=====%s\n' "$Formated_ET"

        fi
	Start_input=$Formated_ET
###########################################
         if [ "$flag" -eq "1" ]
         then
           echo "flag======1"
         break_line=$(( $RANDOM % $break_max ));
                if [ $break_line -le $break_min ]
                 then
                echo "break_line value is ===$break_line" 
                 break_line=2
                fi
          flag=0 
          break
         fi
}
fi
done
################################check_file==1 then it will check the FV.BPL file 

if [ $check_file -eq 1 ]
   then
break
fi
done

