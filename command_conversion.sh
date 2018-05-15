#!/bin/bash

JSON_FILE=$1
echo "FileName: $JSON_FILE";echo ""
AnimationSymbol=( SL LB LG SC BU BO VB HB )
BitNumber=( 1 5 12 15 24 25 45 46 )

index=0
a=( 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111 )

echo "========== Start of Command List ============="
while read -r line
do
	if [[ "$line" =~ "startCmd" ]]
	then
		CommandList[$index]=${line#*: }
		echo "startCmd: ${CommandList[$index]}"
		index=$((index+1))
	fi
done < $JSON_FILE
echo "========== End of Command List ===============";echo ""

k=0
for str in "${AnimationSymbol[@]}"
do
	i=0
	while [ $i -lt $index ]
	do
		if [[ "${CommandList[$i]}" =~ "${str}" ]]
		then
			Temp=${CommandList[$i]:6}
			CommandInHexa=$(echo $Temp| cut -d',' -f 1)
			echo "For $str CommandInHexa: [$CommandInHexa]"
			for((j=0; $j <${#CommandInHexa}; j++))
			do
				TempCommand[$j]=$(printf ${a[16#${CommandInHexa:j:1}]})
			done
			CommandInBinary=$(echo "${TempCommand[@]}"| tr -d ' ')
			echo "CommandInBinary = $CommandInBinary"
			Value=${CommandInBinary:${BitNumber[$k]}:1}	
			if [[ "$Value" =~ "0" ]]
			then
				echo "$str is NOT SET" 
			else
				echo "$str is SET" 
			fi
			echo ""
		fi
		i=$((i+1))
	done
	k=$((k+1))
done
