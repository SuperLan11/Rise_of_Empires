#!/bin/bash
#collect
FG_GREEN="$(tput setaf 2)"
FG_RED="$(tput setaf 1)"
FG_YELLOW="$(tput setaf 3)"

ti="$(date '+%-H:%-M:%-S')" #get date without leading zeros
sec=$(echo "$ti" | cut -d ':' -f3)
min=$(echo "$ti" | cut -d ':' -f2)
hour=$(echo "$ti" | cut -d ':' -f1)

#echo "sdiff=$sdiff mdiff=$mdiff hdiff=$hdiff"
                                                                                                                                                    
Gold=$(gawk '/Gold/' resources | cut -d '=' -f2)
Wood=$(gawk '/Wood/' resources | cut -d '=' -f2)
Food=$(gawk '/Food/' resources | cut -d '=' -f2)
#echo "hour=$hour min=$min sec=$sec"
num=0
for i in ./*  #change * to braces
do
	if [[ -f "$i" && ( "$i" != "./resources" && "$i" != "./collect.sh" && "$i" != "./army" && "$i" != "./attackGuide" ) ]]
	then
		((num++))
		if [ -z "$(gawk '/collected/' "$i")" ]
		then
			fSec="$(gawk '/Created/ {print $3}' $i | cut -d ':' -f3)"
			fMin="$(gawk '/Created/ {print $3}' $i | cut -d ':' -f2)"
			fHr="$(gawk '/Created/ {print $3}' $i | cut -d ':' -f1)"
		else
			fSec="$(gawk '/collected/ {print $3}' $i | cut -d ':' -f3)"
                        fMin="$(gawk '/collected/ {print $3}' $i | cut -d ':' -f2)"
                        fHr="$(gawk '/collected/ {print $3}' $i | cut -d ':' -f1)"
		fi
		sdiff=$((sec-fSec))
		mdiff=$((min-fMin))
		hdiff=$((hour-fHr))
		if [ $sdiff -lt 0 ]
		then
			((sdiff+=60))
			((mdiff-=1))
		fi
		if [ $mdiff -lt 0 ]
		then
			((mdiff+=60))
			((hdiff-=1))
		fi
		if [ $hdiff -lt 0 ]
		then
			((hdiff+=12))
		fi
	
		if [[ $hdiff -gt 0 || $mdiff -ge 1 || ( $collectTime -eq 30 && $sdiff -ge 30 ) ]]
		then
			typ=$(gawk '/Produces/ {print $3}' "$i")
			amt=$(gawk '/Produces/ {print $2}' "$i")
			typ2=$(gawk '/Produces/ {print $6}' "$i")
			amt2=$(gawk '/Produces/ {print $5}' "$i")
			case "$typ" in
			gold)
				((Gold+=amt))
			;;
			wood)
				((Wood+=amt))
			;;
			food)
				((Food+=amt))
			;;
			esac
			case "$typ2" in
                        gold)
                                ((Gold+=amt2))
                        ;;
                        wood)
                                ((Wood+=amt2))
                        ;;
                        food)
                                ((Food+=amt2))
                        ;;
                        esac	
			echo "Gold=$Gold" > resources
			echo "Wood=$Wood" >> resources
			echo "Food=$Food" >> resources
			if [ -z "$(gawk '/Last/' "$i")" ] #check if building has not been collected yet 
			then
				num=$(gawk '/Created/ {print $3}' $i | cut -d ':' -f3)
				sed -i "/Created/ s/$num /$num\\nLast collected: $hour:$min:$sec/g" "$i"
			else
			        sed -i "/Last/ s/.*/Last collected: $hour:$min:$sec/g" "$i"	
			fi
			case "$typ" in
			gold)
			echo "+$amt ${FG_YELLOW}Gold ${FG_GREEN}from $i"	
			;;
			wood)
			echo "+$amt ${FG_YELLOW}Wood ${FG_GREEN}from $i"
			;;
			food)
			echo "+$amt ${FG_RED}Food ${FG_GREEN}from $i"
			;;
			esac

			case "$typ2" in
                        gold)
                        echo "+$amt ${FG_YELLOW}Gold ${FG_GREEN}from $i"
                        ;;
                        wood)
                        echo "+$amt ${FG_YELLOW}Wood ${FG_GREEN}from $i"
                        ;;
                        food)
                        echo "+$amt ${FG_RED}Food ${FG_GREEN}from $i"
                        ;;
                        esac
		else
			if [ $collectTime -eq 30 ]
			then
				prSec="$((30-$sdiff))"		
			else
				prSec="$((60-$sdiff))"
			fi
			#echo "prSec=$prSec"
			echo -n "Collection unavailable for $i. Next collection in "
			if [ $prSec -ne 60 ]
			then
				echo -n "$((0-$mdiff)):"
				if [ $prSec -lt 10 ] 
				then
					echo "0$prSec"
				else
					echo "$prSec"
				fi
			else
				echo "$((1-$mdiff)):00"
			fi
		fi
	fi
done
if [ $num -eq 0 ]
then
	echo "No buildings to collect yet"
fi
cat resources
echo
