#!/bin/sh

# GWR
# Gnome wallpaper changer/randomizer
# Author: AD

#--------------------------------------------------

PATH="${HOME}/Pictures/Wallpapers"
SINGLE="SingleMonitor"
DUAL="DualMonitor"

# Text for manual selection
dual="dual"
single="single"

wc(){
	/usr/bin/wc "${@}"
}

awk(){
	/usr/bin/awk "${@}"
}

shuf(){
	/usr/bin/shuf "${@}"
}

gsettings(){
	/usr/bin/gsettings "${@}"
}

err() {
    echo "Error: $*" >>/dev/stderr
    exit 1
}

#--------------------------------------------------

main(){
	echo "Wallpaper changer !"
	if [ $# -eq 0 ]; then
		set_wallpaper
	else
		while getopts t:f:l option
		do
			case "${option}" in 
				f)	
				        file_name=${OPTARG}
					set_by_file 
					;;
				t)
				        type_name=${OPTARG}
					set_by_type
					;;
				l)
					list
					;;
			esac
		done
	fi
}

list(){
	/usr/bin/ls ${PATH}/*
}


set_by_type(){
	if [ "$type_name" = "$dual" ]; then
		image $DUAL
		set_dual_paper
	elif [ "$type_name" = "$single" ]; then
		image $SINGLE
		set_single_paper
	else
		err "Invalid type name given with -t"
	fi
}

set_by_file(){
	if [ -f ${PATH}/${SINGLE}/$file_name.* ]; then
		file="${PATH}/${SINGLE}/$file_name.*"
		set_single_paper
	elif [ -f ${PATH}/${DUAL}/$file_name.* ]; then
		file="${PATH}/${DUAL}/$file_name.*"
		set_dual_paper
	else
		err "File: ${file_name} does not exist !"
	fi
}

set_wallpaper(){
	count_single=$(wc -l ${PATH}/${SINGLE}/* | wc -l) 
	count_single=$((${count_single} - 1)) # -1 for 'Total' line

	count_dual=$(wc -l ${PATH}/${DUAL}/* | wc -l) 
	count_dual=$((${count_dual} - 1))

	total=$(($count_single + $count_dual))

	rand_draw=$(shuf -i 1-${total} -n 1)

	# Probability of choising single vs dual wallpaper
	# based on the number of wallpapers in each catagory
	# Keeps an equal chance for each image to appear
	# Let the first 1-count_single choices be for Single
	# and the next count_single-total choices be for Dual.
	if [ $rand_draw -gt $count_single ]; then
		image $DUAL
		set_dual_paper
	else
		image $SINGLE
		set_single_paper
	fi
}

set_dual_paper(){
    # Uncomment to set for both light and dark mode
	# gsettings set org.gnome.desktop.background picture-uri $file
	gsettings set org.gnome.desktop.background picture-uri-dark $file
	gsettings set org.gnome.desktop.background picture-options 'spanned'
}

set_single_paper(){
	# gsettings set org.gnome.desktop.background picture-uri $file
	gsettings set org.gnome.desktop.background picture-uri-dark $file
	gsettings set org.gnome.desktop.background picture-options 'zoom'
}

image(){
	file=$(shuf -n1 -e ${PATH}/$1/*)
}

#--------------------------------------------------
main $@
