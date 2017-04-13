#/bin/bash

# A script to backup photos in Dropbox
# Author: Changjie, April 12 2017

# test loop over strings
#declare -a arr=("element1" "element2" "element3")
#for it in "${arr[@]}"
#do
#    printf "%s\n" $it
#done

src=/home/changjie/Dropbox/Camera\ Uploads
dst=/home/changjie/BackUps
MaxSize=1024
DATE=$(date +%Y-%m-%d_%H_%M_%S)
printf '%s: %s\n' "Now is" $DATE

declare -a FNAME=("mi" "IPad")


for fname in "${FNAME[@]}"
do
    # destination path
    dpath="$dst"/"$fname"
    # check if path already exists
    test -d "$dpath"|| mkdir "$dpath"
    
    spath="$src"/"$fname" 
    # get folder volume
    Size=$(du -s "$spath" | awk '{print $1}')
    Size=$(( $Size/1024))
    printf '%s: %dM.\n' "The size of the folder is" $Size
    
    if (( $Size>$MaxSize ));then
        
        printf "%s exceeds the limit %dM. Backup it.\n" "$spath" $MaxSize
        Dpath="$dpath"/"$DATE"
        test -d "$Dpath" || mkdir "$Dpath"
        printf "The backup folder is %s\n" "$Dpath"
        for entry in "$spath"/*
        do
            name=$(basename "$entry")        
            #echo "$name"
            $(mv "$spath"/"$name" "$Dpath"/"$name")
        done
    
    else
    
        printf "%s does not need to backup. Done!\n" "$spath"
    fi
    
done
