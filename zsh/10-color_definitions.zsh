#!/bin/bash

function define_colors {
	# Text color variables
	txtred='\e[0;31m'       # red
	txtgrn='\e[0;32m'       # green
	txtylw='\e[0;33m'       # yellow
	txtblu='\e[0;34m'       # blue
	txtpur='\e[0;35m'       # purple
	txtcyn='\e[0;36m'       # cyan
	txtwht='\e[0;37m'       # white
	bldred='\e[1;31m'       # red    - Bold
	bldgrn='\e[1;32m'       # green
	bldylw='\e[1;33m'       # yellow
	bldblu='\e[1;34m'       # blue
	bldpur='\e[1;35m'       # purple
	bldcyn='\e[1;36m'       # cyan
	bldwht='\e[1;37m'       # white
	txtund=$(tput sgr 0 1)  # Underline
	txtbld=$(tput bold)     # Bold
	txtrst='\e[0m'          # Text reset

	bldred=${txtbld}$(tput setaf 1) #  red
	bldblu=${txtbld}$(tput setaf 4) #  blue
	bldwht=${txtbld}$(tput setaf 7) #  white
	info=${bldwht}*${txtrst}        # Feedback
	pass=${bldblu}*${txtrst}
	warn=${bldred}*${txtrst}
	ques=${bldblu}?${txtrst}
}

function print_colors {
	define_colors

	echo -e "$(tput bold) reg  bld  und   tput-command-colors$(tput sgr0)"

	for i in $(seq 1 7); do
	  echo " $(tput setaf $i)Text$(tput sgr0) $(tput bold)$(tput setaf $i)Text$(tput sgr0) $(tput sgr 0 1)$(tput setaf $i)Text$(tput sgr0)  \$(tput setaf $i)"
	done

	echo ' Bold            $(tput bold)'
	echo ' Underline       $(tput sgr 0 1)'
	echo ' Reset           $(tput sgr0)'
	echo '------------------------------------'
	echo 'Special color variables:'
	echo -e "${txtred}\${txtred}${txtrst}"
	echo -e "${txtgrn}\${txtgrn}${txtrst}"
	echo -e "${txtylw}\${txtylw}${txtrst}"
	echo -e "${txtblu}\${txtblu}${txtrst}"
	echo -e "${txtpur}\${txtpur}${txtrst}"
	echo -e "${txtcyn}\${txtcyn}${txtrst}"
	echo -e "${txtwht}\${txtwht}${txtrst}"
	echo -e "${bldred}\${bldred}${txtrst}"
	echo -e "${bldgrn}\${bldgrn}${txtrst}"
	echo -e "${bldylw}\${bldylw}${txtrst}"
	echo -e "${bldblu}\${bldblu}${txtrst}"
	echo -e "${bldpur}\${bldpur}${txtrst}"
	echo -e "${bldcyn}\${bldcyn}${txtrst}"
	echo -e "${bldwht}\${bldwht}${txtrst}"
	echo -e "${txtund}\${txtund}${txtrst}"
	echo -e "${txtbld}\${txtbld}${txtrst}"
	echo -e "\${txtrst}${txtrst} #reset"
	echo '------------------------------------'
	echo -e "${bldred}\${bldred}${txtrst}"
	echo -e "${bldblu}\${bldblu}${txtrst}"
	echo -e "${bldwht}\${bldwht}${txtrst}"
	echo -e "${info}\${info}${txtrst}"
	echo -e "${pass}\${pass}${txtrst}"
	echo -e "${warn}\${warn}${txtrst}"
	echo -e "${ques}\${ques}${txtrst}"
}