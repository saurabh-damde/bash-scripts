#!/usr/bin/env bash

function cd() {
	[[ $# -eq 0 ]] && return
	builtin cd "$@"
}

function fcd() {
	cd $1
	if [ -z $1 ]
	then
		while true;
		do
			local selection="$(ls -a | fzf --height 50% --reverse --info hidden --prompt "Please select an option:")"
			if [[ -d "$selection" ]]
			then
				>/dev/null cd "$selection"
			elif [[ -f "$selection" ]]
			then
				for file in $selection;
				do
					if [[ $file == *.pdf ]] || [[ $file == *.doc ]] || [[ $file == *.docx ]]
					then
						evince "$selection"
					elif [[ $file == *.jpg ]] || [[ $file == *.png ]]
					then
						shotwell "$selection"
					else
						micro "$selection"
						return
					fi
				done
				else
					break
			fi
		done
	fi
}
