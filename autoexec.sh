#!/usr/bin/env bash
keypadConvert() {
#convert simple number to corresponding source name for keypad key
	case $1 in
	1)
		echo "kp_end"
		;;
	2)
		echo "kp_downarrow"
		;;
	3)
		echo "kp_pgdn"
		;;
	4)
		echo "kp_leftarrow"
		;;
	5)
		echo "kp_5"
		;;
	6)
		echo "kp_rightarrow"
		;;
	7)
		echo "kp_home"
		;;
	8)
		echo "kp_uparrow"
		;;
	9)
		echo "kp_pgup"
		;;
	0)
		echo "kp_ins"
		;;
	esac
}

#if user wants default, skip the rest
echo -n "Use default autoexec? (standard things like 128 tick, disable mouse accel, etc) y/n: "
read input

if [[ $input = "y" ]]
then
	echo "Using default preset..."
#start writing to file
	echo "//put this file in steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg" > autoexec.cfg
	echo "//net settings" >> ./autoexec.cfg
	echo "rate \"128000\"" >> autoexec.cfg
	echo "cl_cmdrate \"128\"" >> autoexec.cfg
	echo "cl_updaterate \"128\"" >> autoexec.cfg
	echo "cl_interp_ratio \"1\"" >> autoexec.cfg
	echo "cl_interp \"0\"" >> autoexec.cfg
	echo "tickrate \"128\"" >> autoexec.cfg
	echo "net_graph \"1\"" >> autoexec.cfg
	echo "net_graphproportionalfont \"0\"" >> autoexec.cfg

	echo "" >> autoexec.cfg
	echo "//mouse" >> autoexec.cfg
	echo "m_rawinput \"1\"" >> autoexec.cfg
	echo "m_mouseaccel \"0\"" >> autoexec.cfg
	echo "m_mouseacce2 \"0\"" >> autoexec.cfg
	echo "" >> autoexec.cfg

	echo "//misc" >> autoexec.cfg
	echo "fps_max \"999\" //fps_max 0 causes issues sometimes" >> autoexec.cfg
	echo "cl_forcepreload \"1\"" >> autoexec.cfg
	echo "cl_autohelp \"0\"" >> autoexec.cfg
	echo "cl_showhelp \"0\"" >> autoexec.cfg
	echo "cl_autowepswitch \"0\"" >> autoexec.cfg
	echo "con_enable \"1\"" >> autoexec.cfg

	echo "" >> autoexec.cfg
	echo "host_writeconfig" >> autoexec.cfg
	echo "echo \"\"" >> autoexec.cfg
	echo "echo \"autoexec loaded!\" " >> autoexec.cfg
	echo "echo \"\"" >> autoexec.cfg

else
	echo "//put this file in steam/steamapps/common/Counter-Strike Global Offensive/csgo/cfg" > autoexec.cfg
	echo "" >> autoexec.cfg
	echo ""
	echo "Enter desired value for each setting. Just hit enter for recommended value."

	echo ""
	read -p "Quick set up essential keypad buy binds? y/n: " input
	if [[ $input = "y" ]]
	then
		echo "//buy binds" >> autoexec.cfg
#arrays for weapon names and corresponding binds
		declare -a weapons=("ak/m4" "famas/galil" "awp" "p250" "frag" "flash" "smoke" "molly" "head armor" "body armor")
		declare -a binds=("buy ak47; buy m4a1;" "buy famas; buy galilar;" "buy awp" "buy p250" "buy hegrenade" "buy flashbang" "buy smokegrenade" "buy molotov; buy incgrenade" "buy vesthelm" "buy vest")
# get length of array
		arraylength=${#weapons[@]}
#iterate through array and ask for desired key for each weapon
		for (( i=0; i<${arraylength}; i++ ));
		do
   			read -p "Keypad number to bind for ${weapons[$i]}: " input
   			key=$(keypadConvert $input)
   			echo "bind $key \"${binds[$i]}\"" >> autoexec.cfg
   		done
	fi

#prompts for custom user autoexec
	echo ""
#default value
	rate=128000
	read -p "rate ($rate): " input
#only change from default if they entered something
	if [[ ! -z $input ]]
	then
		$rate=$input
	fi

	echo ""
	tick=128
	read -p "tickrate ($tick): " input
	if [[ ! -z $input ]]
	then
		tick=$input
	fi

	echo ""
	net_graph=1
	read -p "net_graph? ($net_graph): " input
	if [[ ! -z $input ]]
	then
		net_graph=$input
	fi

	echo ""
	mmping=100
	read -p "Maximum matchmaking search ping ($mmping): " input
	if [[ ! -z $input ]]
	then
		mmping=$input
	fi

	echo ""
#big chunk for one functionality
	read -p "Reduce viewmodel bob? y/n: " input
	if [[ $input = "y" ]]
	then
		echo "//reduce viewmodel bobbing" >> autoexec.cfg
		echo "cl_viewmodel_shift_left_amt \"0\"" >> autoexec.cfg
		echo "cl_viewmodel_shift_right_amt \"0\"" >> autoexec.cfg
		echo "cl_bob_lower_amt \"0\"" >> autoexec.cfg
		echo "cl_bobamt_lat \"0\"" >> autoexec.cfg
		echo "cl_bobamt_vert \"0\"" >> autoexec.cfg
	fi

	echo ""
	read -p "Bind \"n\" key to switch right/lefthanded? y/n: " input
	if [[ $input = "y" ]]
	then
		echo "bind \"n\" \"incrementvar cl_righthand 0 1 1\" //bind for viewmodel swap" >> autoexec.cfg
	fi

	echo ""
	rawinput=1
	read -p "raw mouse input ($rawinput): " input
	if [[ ! -z $input ]]
	then
		rawinput=$input
	fi

	echo ""
	read -p "Disable mouse accel? y/n: " input
	if [[ $input = "y" ]]
	then
		echo "//disable mouse accel" >> autoexec.cfg
		echo "m_mouseaccel \"0\"" >> autoexec.cfg
		echo "m_mouseacce2 \"0\"" >> autoexec.cfg
	fi

	echo ""
	fpsmax=999
	read -p "FPS cap ($fpsmax): " input
	if [[ ! -z $input ]]
	then
		fpsmax=$input
	fi

#--------------------------------------------------------
#write to file
	echo "" >> autoexec.cfg
	echo "//net settings" >> ./autoexec.cfg
	echo "rate \"$rate\"" >> autoexec.cfg
	echo "cl_cmdrate \"$tick\"" >> autoexec.cfg
	echo "cl_updaterate \"$tick\"" >> autoexec.cfg
	echo "cl_interp_ratio \"1\"" >> autoexec.cfg
	echo "cl_interp \"0\"" >> autoexec.cfg
	echo "tickrate \"$tick\"" >> autoexec.cfg
	echo "net_graph \"$net_graph\"" >> autoexec.cfg
	echo "net_graphproportionalfont \"0\"" >> autoexec.cfg

	echo "//misc" >> autoexec.cfg
	echo "fps_max \"$maxfps\"" >> autoexec.cfg
	echo "cl_forcepreload \"1\"" >> autoexec.cfg
	echo "cl_autohelp \"0\"" >> autoexec.cfg
	echo "cl_showhelp \"0\"" >> autoexec.cfg
	echo "cl_autowepswitch \"0\"" >> autoexec.cfg
	echo "con_enable \"1\"" >> autoexec.cfg
	echo "m_rawinput \"$rawinput\"" >> autoexec.cfg

	echo ""
	echo "host_writeconfig" >> autoexec.cfg
	echo "echo \"\"" >> autoexec.cfg
	echo "echo \"autoexec loaded!\" " >> autoexec.cfg
	echo "echo \"\"" >> autoexec.cfg

fi
echo "Created autoexec.cfg! Put in your csgo\\cfg folder."

