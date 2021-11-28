#!/bin/bash

# EXIT hot-key ctr+c

trap 'exit 0' INT
user_comp="$( whoami  )"

usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"

usb_check(){
    if [ -z "$usb_media" ]
        then
            echo -e "${RED}${bold} !!!! ZEWNETRZNY USB NIE JEST ZAMONTOWANY W VIRTUALCE :((( !!!! ${normal}${NC}"
        else
            echo -e "${GREEN}${bold} ZEWNETRZNY USB JEST PRAWIDLOWO ZAMONTOWANY W WIRTUALCE ;) ${normal}${NC} "
      fi
}

bold=$(tput bold)
normal=$(tput sgr0)
#${bold}
#${normal}
CYAN='\033[1;36m'	# cyan text
RED='\033[1;31m'	# red text
NC='\033[0m'		# white text
PURPLE='\033[1;35m'	# Light Purple
BLUE='\033[1;34m'	# BLUE
GREEN='\033[1;32m'
#${RED}
#${NC}
#${PURPLE}
#${BLUE}
#${GREEN}
#${CYAN}
youtube_dl_update(){

	sudo youtube-dl -Uusb_mount2="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
    usb_media2="$(awk -v needle=$usb_mount2 '$1==needle {print $2}' /proc/mounts)"
}

download_from_list(){
    #Create var with mounting USB mounting points
    echo ""
	usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
	usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
	sleep 0.5
    #Set directory for downloaded files
    read -p "Podaj folder w jakim ma byc zachowana playlista na dysku zewnetrznym: " dir
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -BM | grep "$usb_mount" | awk '{print $4}')"
	sleep 0.5   
	echo ""
	echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
    #Choose quality
    read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
  
    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
        read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    done
    #Reade path to file with list
    read -p "PODAJ SCIEZKE DO PLIKU Z LISTA PIOSENEK: " plik_1
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
        youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --output $mkdir_on_usb/"%(title)s.%(ext)s" "$s"
    done
      

}


download_song(){
    #Create var with mounting USB mounting points
    usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
	usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
	sleep 0.5
    #Set directory for downloaded files
    read -p "Podaj folder w jakim ma byc zachowana playlista na dysku zewnetrznym: " dir
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir   $mkdir_on_usb
    #chown   777 $mkdir_on_usb
    #mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Measure space left on USB
	space_left="$( df -BM | grep "$usb_mount" | awk '{print $4}')"
	sleep 0.5
	echo ""
	echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
    #Create list with urls
    touch /tmp/site.txt
	while [ 1 ];
	do
	mp3_list=$( cat /tmp/site.txt)
	read -p "PODAJ CALY ADRES. ABY PRZERWAC WPISZ q I ENTER: " var
	if [ "$var" == "q" ];
	then
	 rm   /tmp/site.txt
	 break;
	else
	 echo "$var" >> /tmp/site.txt
	fi
	done
	echo ""
    read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    #Choose quality
    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
        read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    done
    #Main download loop
	for site in ${mp3_list[@]}
	 do
	  youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality "$quality_mp3" --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$site"
	done
}

download_playlist(){
	echo ""
    #Create var with mounting USB mounting points
	usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
	usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
	sleep 0.5
	echo -e " Czesc linku gdzie znajduje sie ID jest na zielono https://www.youtube.com/watch?v=${GREEN}PLEsNcyT1Z66QTRRPXdJZJdPoqdud4wNKP ${NC}"
 	sleep 0.5
    #Read playlist ID
	read -p "PODAJ ID LINKU : " playlist_id
        sleep 0.5
	echo ""
    #Set directory for downloaded file
	read -p "Podaj folder w jakim ma byc zachowana PLAYLISTA na dysku zewnetrznym: " dir
	mkdir_on_usb="$( echo $usb_media/$dir   )"
	mkdir $mkdir_on_usb
    #chown   777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -BM | grep "$usb_mount" | awk '{print $4}')"
	sleep 0.5
	echo ""
	echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
	xdg-open $mkdir_on_usb
    #Choose quality
    read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
        read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    done
    #Main command for download playlist
    echo ""
    echo -e " ${PURPLE} MP3 file is saved under: $mkdir_on_usb  ${NC} "
    echo ""
    youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --yes-playlist  --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$playlist_id"
		
}

download_channel(){
	echo ""
    #Create var with mounting USB mounting points
	usb_mount2="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
    usb_media2="$(awk -v needle=$usb_mount2 '$1==needle {print $2}' /proc/mounts)"
    echo -e " PODAJ CALY LINK DO KANALU YOUTUBE np. ${GREEN} https://www.youtube.com/${BLUE}channel/${GREEN}UC0C1W6nV0Rv6QkvAAE_AgXg ${NC}"
    sleep 0.5
	echo ""
    #Read channels id
    read -p "PODAJ ID LINKU : " channel_id
    sleep 0.5
	echo ""
    #Set directory for downloaded file
    read -p "Podaj folder w jakim ma byc zachowany CHANNEL na dysku zewnetrznym: " dir
    #Make diroctory on USB accessible for all
    mkdir_on_usb_2="$( echo $usb_media2/$dir   )"
    mkdir   $mkdir_on_usb_2
    #chown   777 $mkdir_on_usb
    #Measure space left on USB
    space_left_2="$( df -BM | grep "$usb_mount2" | awk '{print $4}')"
    sleep 0.5
    echo ""
    #Choose quality  
    xdg-open $mkdir_on_usb_2
    read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
  
    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
        do
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
        done
    echo ""
    echo -e " ${PURPLE} MP3 file is saved under: $mkdir_on_usb_2  ${NC} "
    echo ""
    youtube-dl -f best -ciw --extract-audio --audio-format mp3 --audio-quality $quality_mp3 -o  $mkdir_on_usb_2/"%(title)s.%(ext)s" -v "$channel_id"
	

}
upgrade_ytdl(){
	sudo apt install ffmpeg -y
 	#sudo apt install avconv -y
	#sudo apt-get install  libav-tools -y

}
install_ytdl(){
	sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
	sudo chmod a+rx /usr/local/bin/youtube-dl
    sudo apt-get install python-is-python3
}
install_tor(){

	sudo add-apt-repository ppa:micahflee/ppa -y
	sudo apt update
	sudo apt install torbrowser-launcher -y
	sudo apt install deluge -y

}
download_movie(){
touch /tmp/site_mov.txt
while [ 1 ];
        do
	mov_list=$( cat /tmp/site_mov.txt)
        read -p "PODAJ CALY ADRES. ABY PRZERWAC WPISZ q I ENTER: " mov
        if [ "$mov" == "q" ];
        then
         rm   /tmp/site_mov.txt
         break;
        else
	 echo "$mov" >> /tmp/site_mov.txt
        fi
        done
        echo ""
        echo ""
        pu_desk=$(cd /home/$user_comp/ | grep "Pulpit"  )
        if [ -z "$pu_desk" ]
        then
         xdg-open /home/$user_comp/Desktop
        else
         xdg-open /home/$user_comp/Pulpit
        fi
        for site_mov in ${mov_list[@]}
         do
          youtube-dl --ignore-errors -f bestvideo+bestaudio/best --output "%(title)s.%(ext)s"  "$site_mov"
        done

}

download_movie_and_music_from_file(){

#Create var with mounting USB mounting points
    echo ""
	usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
	usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
	sleep 0.5
    #Set directory for downloaded files
    read -p "Podaj folder w jakim ma byc zachowana playlista na dysku zewnetrznym: " dir
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -BM | grep "$usb_mount" | awk '{print $4}')"
	sleep 0.5   
	echo ""
	echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
    #Choose quality
    read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
  
    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
        read -p "W jakiej jakosci chcesz sciagnac MP3 128K lub 320K ? Wpisz popawna wartosc: " quality_mp3
    done
    #Reade path to file with list
    read -p "PODAJ SCIEZKE DO PLIKU Z LISTA PIOSENEK: " plik_1
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
        youtube-dl --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --output $mkdir_on_usb/"%(title)s.%(ext)s" "$s"
        youtube-dl  --external-downloader ffmpeg --external-downloader-args "-v quiet -stats " --ignore-errors -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$s"
        
    done


}

download_movie_from_file(){

#Create var with mounting USB mounting points
    echo ""
	usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
	usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
	sleep 0.5
    #Set directory for downloaded files
    read -p "Podaj folder w jakim ma byc zachowana playlista na dysku zewnetrznym: " dir
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -BM | grep "$usb_mount" | awk '{print $4}')"
	sleep 0.5   
	echo ""
	echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
    #Choose quality
    #Reade path to file with list
    read -p "PODAJ SCIEZKE DO PLIKU Z LISTA PIOSENEK: " plik_1
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
     youtube-dl  --external-downloader ffmpeg --external-downloader-args "-v quiet -stats " --ignore-errors -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$s"
    done


}

wpis_bash(){

read -p "PODAJ SCIEZKE DO PLIKU: " plik
plik_zr=$( echo  $plik |  sed 's/"//g' |  sed s/\'//g )
skrypt=$( ls /home/$user_comp/ | grep "SKRYPTY" )
dest=$(echo "/home/"$user_comp"/SKRYPTY/pobierak.sh")
if [ -z "$skrypt" ]
	then
      	 mkdir /home/$user_comp/SKRYPTY
	else
         echo ""
fi

cp $plik_zr $dest
sudo sed -i.bak '/pobierak/d' ~/.bashrc
sudo echo "alias pobierak='/home/$user_comp/SKRYPTY/pobierak.sh'" >> ~/.bashrc
chmod +x "/home/$user_comp/SKRYPTY/pobierak.sh"
echo -e "OD TERAZ MOZESZ UZYC KOMENDY ${RED}${u}pobierak${NC} BASH BEZPOSREDIO W TERMINALU"
sleep 5
exec bash
exit
}
###############################
#7.        PRINT MENU         #
###############################
u='\e[4m'

printMenu(){
	clear && printf '\e[3J'
	echo ""
	usb_check
	echo ""
    echo -e "${normal} ${u}Pobierak_ver2.2.3${NC}"
	echo ""
	echo -e	"${PURPLE}	\t1)	SCIAGNIJ ILE CHCESZ POJEDYNCZYCH LINKOW ${NC}"
    echo ""
    echo -e "${BLUE}	\t2)	SCIAGNIJ PIOSENKI Z LINKOW ZNAJDUJACYCH SIE W PLIKU ${NC}"
	echo ""
	echo -e	"${PURPLE}	\t3)	SCIAGNIJ CALA PLAYLISTE ${NC}"
	echo ""
	echo -e "${BLUE}	\t4)	SCIAGNIJ CALY KANAL ${NC}"
	echo ""
	echo -e "${PURPLE}	\t5)	SCIAGNIJ FILM ${NC}"
    echo ""
    echo -e "${BLUE}	\t6)	SCIAGNIJ FILMY LUB TELEDYSKI Z LISTY ${NC}"
	echo ""
    echo -e "${PURPLE}	\t7)	SCIAGNIJ FILM & SCIEZKE MP3 ${NC}"
    echo ""
	echo -e "${CYAN} 	\t8)	INSTALACJA YOUTUBE_DL ${NC}"
	echo ""
	echo -e "${CYAN}	\t9)	UPGRADE BIBLIOTEK DO KONWERTOWANIA ${NC}"
	echo ""
    echo -e "${CYAN}        \t10)      INSTALUJ POBIERAKA W KONSOLI  ${NC}"
    echo ""
    echo -e "${CYAN} 	\t11)	YOUTUBE-DL UPDATE ${NC}"
    echo ""
    echo -e "${CYAN} 	\t12)	INSTALL TOR AND DELUGE ${NC}"
	echo ""
	echo -e "           \t13)   EXIT"
    echo ""

	echo ""
	read option;

	while [[ $option -gt 13 || ! $(echo $option ) ]] # | grep '^[1-9]$') ]]
	do
		printMenu

	done
	runOption
}
#############################
#8.	RUN OPTION	    #
#############################
runOption(){
	case $option in
		1) download_song;;
        2) download_from_list;;
		3) download_playlist;;
		4) download_channel;;
		5) download_movie;;
        6) download_movie_from_file;;
        7) download_movie_and_music_from_file;;
        8) install_ytdl;;
		9) upgrade_ytdl;;
		10) wpis_bash;;
		11) youtube_dl_update;;
        12) install_tor;;
		13) exit;;
        
		
	esac
	echo "Press any Key to continue"
	read x
	printMenu
}
while true ;
do
	printMenu
done
