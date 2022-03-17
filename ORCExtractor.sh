#!/bin/bash

# Function prints a help message
usage() {                                 
  echo "Usage: $0 [ -i ORCs DIRECTORY ] [ -p PASSWORD ]" 1>&2
  exit 1
}


# Set arguements
while getopts i:p: arg
do
    case "${arg}" in
        i) collect_dir=${OPTARG};;
        p) password=${OPTARG};;
        *) usage;;
  esac
done


# Orcs collects recursive decompression 
nb=$(find $collect_dir -name "*.7z" |wc -l)
if [ "$nb" -ne 0 ];
then
	for fic in $(find $collect_dir -name "*.7z")
	do
	    echo "Decompressing $fic ... "
	    dir="${fic%%.7z}"
	    7z e "$fic" -o"$dir"
	    for fic in $(find ${dir} -name "*.7z")
            do
                echo "$fic"
                dir="${fic%%.7z}"
                7z e "$fic" -o"$dir" -p$password
	    done
	done

echo "Removing \"data\" extension"
for file in $(find $collect_dir -name "*_data")
    do
	    newname=$(echo ${file} | sed 's/\_data//g')
	    mv $file $newname
    done

else echo No Archive found! ;
fi
