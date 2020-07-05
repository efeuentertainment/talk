#created by ned 01.2017
#its purpose is to audibly notify the user about the exit code of the last executed command.

#this file is sourced in ~/.bashrc using:
#sourcing talk function
#if [ -f ~/scripts/functions.sh ]; then
#  . ~/scripts/functions.sh
#fi


#aplay condition and soundfile link script
#sound files in
#/home/brian/scripts/scifi-computer-voice-pack-2/
#interesting files:

#access denied.wav
#access granted.wav
#identification confirmed.wav
#identify.wav

#affirmative.wav
#negative.wav
#confirm.wav

#core breach imminent.wav
#self destruct initiated.wav

#engage.wav
#processing.wav

#insufficient data.wav
#rephrase your query.wav

#transfer complete.wav
#transfer incomplete.wav

#intruder alert.wav
#incoming communication.wav

#yellow alert.wav

talk(){

retval=$?


                if [ $retval -eq 0 ]; then
                        #echo "affirmative"
                        tell=0
                else
                        #echo "negative"
                        tell=1
                fi

        if [ $# -eq 1 ]; then
                if [ "$1" = "0" ]; then
                        #echo "affirmative"
			tell=0
                fi
                if [ "$1" = "1" ]; then
                        #echo "negative"
                        tell=1
                fi
        fi
	if [ $# -eq 2 ]; then
		if [ "$2" = "0" ]; then
			#echo ok
			tell=0
		fi
		if [ "$2" = "1" ]; then
			#echo nok
			tell=1
		fi
	fi

        #echo "$retval"



case "$1" in
"-h"|"--help")
	printf "talk's purpose is to audibly notify the user about the exit code of the last executed command.\n"
	printf "talk uses sound files stored in: \n/home/brian/scripts/scifi-computer-voice-pack-2/\n\n"
	printf "usage: talk [argument1] [ 0 | 1 ]\n"
	printf "valid [argument1]:\n"
	printf "<no argument1>\t\tuses <exit code>\n"
	printf -- "-t|--transfer\t\tuses <exit code> and transfer*.wav\n"
	printf -- "-a|--access\t\tuses <exit code> and access*.wav\n"
	printf -- "-h|--help\t\tprints this help message\n"
	printf -- "--boot\t\t\t(quiet) boot message\n-p|--processing\t\tprocessing..\n-y|--yellow\t\tyellow alert\n"
	printf "\nthe response can be forced when using:\n1. <no argument1>\n2. -t|--transfer\n3. -a|--access\n"
	printf "by appending the desired response, 0 or 1\n"
	printf "\nexamples:\ntalk\t\t\tresponds using <exit code>\ntalk -a 1\t\tresponds negatively\nrsync *; talk -t\tuses rsync <exit code>\n"

	;;
"--fail")
	return 1
	;;
"--boot")
	#boot
	aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/self\ destruct\ initiated.wav
	;;
"-a"|"--access")
	if [ $tell -eq 0 ]; then
		echo "access granted"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/access\ granted.wav
	else
		echo "access denied"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/access\ denied.wav
		return 1
	fi
	;;
"-p"|"--processing")
	echo "processing.."
	aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/processing.wav
	;;
"-t"|"--transfer")
	if [ $tell -eq 0 ]; then
		echo "transfer complete"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/transfer\ complete.wav
	else
		echo "transfer incomplete"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/transfer\ incomplete.wav
		return 1
	fi
	;;
"-y"|"--yellow")
	#echo "yellow alert!"
	aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/yellow\ alert.wav
	;;
""|"0"|"1")
	#general purpose
	if [ $tell -eq 0 ]; then
		echo "affirmative"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/affirmative.wav
	else
		echo "negative"
		aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/negative.wav
		return 1
	fi
	;;
*)
	echo "...dafuq dude?"
	echo "see 'talk --help' if you can't spell.."
	aplay -q /home/brian/scripts/scifi-computer-voice-pack-2/rephrase\ your\ query.wav
	return 1
	;;
esac
return 0
}
