#!/bin/bash
FG_GREEN="$(tput setaf 2)"

echo "Starting the game..."
export stDir="$PWD"
ti=$(date '+%-H:%-M:%-S' | gawk '{print $1}')
export stSec=$(echo "$ti" | cut -d ':' -f3)
export stMin=$(echo "$ti" | cut -d ':' -f2)
export stHr=$(echo "$ti" | cut -d ':' -f1)
#export firstCollect=0
export taughtAlias=0
export taughtWild=0
export taughtPipe=0
export taughtPar=0
export usedDir=0
export houseCnt=0
export millCnt=0
export mineCnt=0
export collectTime=60
export FG_RED="$(tput setaf 1)"
export FG_YELLOW="$(tput setaf 3)"
export FG_WHITE="$(tput setaf 7)"
export FG_GREEN="$(tput setaf 2)"
echo "${FG_GREEN}"
cd gameDir
export gDir="$PWD"
rm house* mill* mine* 2>/dev/null #reset any game data
rm upgrades/* 2>/dev/null 
rm train/* 2>/dev/null
source $stDir/.func

echo "Reduce your collection timer from 1 minute to 30 seconds" > $gDir/upgrades/fastCollect
echo "Such a great upgrade won't be cheap though" >> $gDir/upgrades/fastCollect
echo -e "Cost: 500 gold, 500 wood, 500 food\n" >> $gDir/upgrades/fastCollect

for i in french mongols huns vietnamese mayans incans vikings celtics aztecs persians
do
echo "Militia: $(expr $RANDOM % 401 + 100)" > $gDir/attack/$i
echo "Cavalry: $(expr $RANDOM % 201 + 100)" >> $gDir/attack/$i
echo "Archery: $(expr $RANDOM % 301 + 100)" >> $gDir/attack/$i
chmod 711 $gDir/attack/$i
done

rm army 2>/dev/null
echo "Militia: 0" > $gDir/army
echo "Cavalry: 0" >> $gDir/army
echo "Archery: 0" >> $gDir/army
#reset resources
echo "Gold=50" > resources
echo "Wood=100" >> resources
echo "Food=100" >> resources
clear
echo "Welcome to the empire! Use ls to get to know the area"
echo "When you're ready, head to the build site to make your first building"
