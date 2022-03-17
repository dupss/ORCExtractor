#!/bin/bash
# decompression des fichiers .7z de facon recursive
nb=$(find . -name "*.7z" |wc -l)
if [ "$nb" -ne 0 ];
then
	for fic in $(find . -name "*.7z")
	do
	    echo "Decompressing $fic ... "
	    dir="${fic%%.7z}"
	    7z e "$fic" -o"$dir"
	    for fic in $(find ${dir} -name "*.7z")
            do
                echo "$fic"
                dir="${fic%%.7z}"
                7z e "$fic" -o"$dir" -p"avproof"
	    done
	done

echo "Removing \"data\" extension"
for file in $(find . -name "*_data")
    do
	    newname=$(echo ${file} | sed 's/\_data//g')
	    mv $file $newname
    done

else echo aucune archive 7z trouvée ;
fi
