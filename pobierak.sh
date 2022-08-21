#!/bin/bash

# EXIT hot-key ctr+c

trap 'exit 0' INT

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
YELLOW='\033[1;33m'
#${RED}
#${NC}
#${PURPLE}
#${BLUE}
#${GREEN}
#${CYAN}
#${YELLOW}

Pobierak_ver="Pobierak_ver 4.6 MultiLang"
user_comp="$( whoami  )"
usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
var_locale="$( cat /etc/default/locale | grep "pl" )"

#CHECK LANGUAGE
if [ -z $var_locale ]
    then
        language="english"
    else
        language="polish"
    fi
#CHECK IF USB IS MOUNTED WHEN NOT GLOBAL DEVICE TO DOWNLOAD IS LOCAL DISK
if [ -z "$usb_media" ];
    then
        usb_mount="/home"
        usb_media="$(eval echo ~$USER)"
        usb_var=0
    else
        echo ""
    fi

#FUNCTION CHECKS IF LABEL IN USB HAS SPACEBAR
usb_LABEL_TEST(){
    dir_test="test"
    test_mkdir_on_usb="$( echo $usb_media/$dir_test )"

	mkdir $test_mkdir_on_usb 2>/dev/null

    if [[ $? -ne 0 ]] ; 
        then
            usb_media="$(eval echo ~$USER)"
            echo 1
        else
            echo 0
            rm -Rf $test_mkdir_on_usb
    fi
}

#FUNCTION PRINTING INFORMATION IF DISK IS MOUNTED OR NOT AND IF THERE IS SPACEBAR IN LABEL OF THE USB WHEN ATATCHED
usb_check(){

space_left_1="$( df -PH "$usb_media" 2>/dev/null | tail -1 | awk '{print $4}' )"
var_usb_label_space=$( usb_LABEL_TEST )

	if [ "$usb_var" == 0 ] ;
        	then
                    if [ $language == "polish" ] ;
                        then
            		        echo -e "${RED}${bold} !!!! ZEWNETRZNY USB NIE JEST ZAMONTOWANY W SYSTEMIE :((( !!!! ${normal}${NC}"
           	 	            echo -e "${GREEN}${bold} DOCELOWY FOLDER ZAPISU TO $usb_media ;) ${normal}${NC}, ${RED} Pozostale miejsce: $space_left_1 ${NC}"
        	            else
                            echo -e "${RED}${bold} !!!! EXTERNAL USB IS NOT INCLUDED IN THE SYSTEM :((( !!!! ${normal}${NC}"
           	                echo -e "${GREEN}${bold} TARGET DIRECTORY FOR DOWNLOAD IS $usb_media ;) ${normal}${NC}, ${RED} FREE SPACE LEFT ON THE DEVICE: $space_left_1 ${NC}"
                        fi
            else
                    if [ "$var_usb_label_space" == 1 ] ;
                        then
                            if [ $language == "polish" ] ;
                                then
                                    usb_media="$(eval echo ~$USER)"
                                    space_left_1="$( df -PH "$usb_media" 2>/dev/null | tail -1 | awk '{print $4}' )"
                                    echo -e "${RED}${bold} NAZWA USB ZAWIERA SPACJE !!!. DOCELOWE MIEJSCE ZAPISU TO:${BLUE} $usb_media (DYSK LOKALNY) . Pozostale miejsce: $space_left_1 ${NC}"
                                    echo -e "${RED}${bold} JESLI CHCESZ UZYWAC USB JAKO MIEJSCE ZAPISU ZMIEN JEGO NAZWE NA BEZ SPACJI ! ${NC}"
                                else
                                    usb_media="$(eval echo ~$USER)"
                                    space_left_1="$( df -PH "$usb_media" 2>/dev/null | tail -1 | awk '{print $4}' )"
                                    echo -e "${RED}${bold} USB NAME CONTAINS SPACES. THE TARGET DIRECTORY IS CHANGED TO:${BLUE} $usb_media (LOCAL DRIVE). FREE SPACE LEFT ON THE DEVICE: $space_left_1 ${NC}"
                                    echo -e "${RED}${bold} IF YOU WANT TO USE YOUR USB YOU HAVE TO CHANGE THE LABEL TO WITHOUT SPACEBAR ! ${NC}"
                            fi
                        else
                            if [ $language == "polish" ] ;
                                then
            		                echo -e "${GREEN}${bold} ZEWNETRZNY USB JEST PRAWIDLOWO ZAMONTOWANY W SYSTEMIE ;). ${RED} Pozostale miejsce to: $space_left_1 ${NC} "
                                else
                                    echo -e "${GREEN}${bold} THE EXTERNAL USB IS PROPERLY MOUNTED IN THE SYSTEM ;). ${RED} FREE SPACE LEFT ON THE DEVICE: $space_left_1 ${NC} "
                            
                            fi
                    fi

      	fi
}

download_from_list(){
    #Create var with mounting USB mounting points
    echo ""
	sleep 0.5
    #Set directory for downloaded files
    if [ $language == "polish" ] ;
        then
            read -p "PODAJ NAZWE FOLDERU W KTORYM MAJA BYC ZACHOWANE KAWALKI Z LISTY Z PLIKU: " dir
        else
            read -p "ENTER THE NAME OF THE FOLDER IN WHICH THE SONGS FROM THE FILE LIST SHOULD BE SAVED: " dir
    fi
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
                        
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}' )" 
	sleep 0.5   
	echo ""
    if [ $language == "polish" ] ;
        then
	        echo -e "NA DYSKU POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi
    #Choose quality
    sleep 0.5
	echo ""
    if [ $language == "polish" ] ;
        then
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
    fi

    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        if [ $language == "polish" ] ;
        then
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            echo "THE CORRECT VALUE IS: 128K OR 320K"
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
        fi
    done
    #Reade path to file with list
    sleep 0.5
	echo ""
    if [ $language == "polish" ] ;
        then
            read -p "PRZECIAGNIJ I UPUSC PLIK Z LISTA DO TERMINALU: " plik_1
        else
            read -p "DRAG AND DROP THE FILE WITH LIST TO TERMINAL: " plik_1
    fi
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    xdg-open $mkdir_on_usb
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
        yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --output $mkdir_on_usb/"%(title)s.%(ext)s" "$s"
    done


}


download_song(){

    #Create var with mounting USB mounting points
	sleep 0.5
    #Set directory for downloaded files
    if [ $language == "polish" ] ;
        then
            read -p "PODAJ NAZWE FOLDERU W KTORYM MAJA BYC ZACHOWANE POJEDYNCZE KAWALKI: " dir
        else
            read -p "ENTER THE NAME OF THE FOLDER IN WHICH THE SONGS SHOULD BE SAVED: " dir
    fi
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
    mkdir_on_usb="$( echo $usb_media/$dir   )"

    #Make diroctory on USB accessible for all
	mkdir   $mkdir_on_usb

    #Measure space left on USB
	space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
	sleep 0.5
	echo ""
    
    if [ $language == "polish" ] ;
        then
	        echo -e "NA DYSKU POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi
        
    #Create list with urls
    touch /tmp/site.txt
	while [ 1 ];
	do
	mp3_list=$( cat /tmp/site.txt)
    
    if [ $language == "polish" ] ;
        then
	        read -p "PODAJ CALY ADRES. ABY PRZERWAC WPISZ q I ENTER: " var
        else
            read -p "ENTER FULL ADDRESS. TO STOP THE LOOP AND GO FURTHER WRITE q AND PRESS ENTER: " var
    fi
    
	if [ "$var" == "q" ];
	then
	 rm   /tmp/site.txt
	 break;
	else
	 echo "$var" >> /tmp/site.txt
	fi
	done
	sleep 0.5
	echo ""

    if [ $language == "polish" ] ;
        then
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
    fi

    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        if [ $language == "polish" ] ;
        then
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            echo "THE CORRECT VALUE IS: 128K OR 320K"
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
        fi
    done

    xdg-open $mkdir_on_usb
    #Main download loop
	for site in ${mp3_list[@]}
	 do
	  yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality "$quality_mp3" --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$site"
	done
}

download_playlist(){
	echo ""
    if [ $language == "polish" ] ;
        then
	        sleep 0.5
            echo    "W CELU SCIAGNIECIA CALEY PLYLISTY NIEZBEDNY JEST JEJ IDENTYFIKATOR"
            sleep 0.5
	        echo -e "IDENTYFIKATOR PLAYLISTY ZOSTAL ZAZNACZONY NA ZIELONO W PRZYKLADOWYM LINKU OBOK https://www.youtube.com/watch?v=${GREEN}PLEsNcyT1Z66QTRRPXdJZJdPoqdud4wNKP ${NC}"
 	        sleep 0.5
            #Read playlist ID
            echo    ""
	        read -p "PODAJ IDENTYFIKATOR PLAYLISTY Z ADRESU W SWOJEJ PRZEGLĄDARCE : " playlist_id
            sleep 0.5
	        echo ""
            #Set directory for downloaded file
	        read -p "PODAJ NAZWE FOLDERU W KTORYM MA BYC ZACHOWANA PLAYLISTA: " dir
        else
            sleep 0.5
            echo    "IN ORDER TO FIND THE ENTIRE PLAYLIST, ITS IDENTIFIER IS NECESSARY"
            sleep 0.5
	        echo -e " THE PART OF THE LINK THAT INCLUDES THE ID IS GREEN IN THE EXAMPLE LINK ON THE RIGHT https://www.youtube.com/watch?v=${GREEN}PLEsNcyT1Z66QTRRPXdJZJdPoqdud4wNKP ${NC}"
 	        sleep 0.5
            #Read playlist ID
            echo ""
	        read -p "GIVE THE PLAYLIST ID FROM ADDRESS IN YOUR WEBBROWSER : " playlist_id
            sleep 0.5
	        echo ""
            #Set directory for downloaded file
	        read -p "ENTER THE NAME OF THE FOLDER IN WHICH SONGS FROM THE PLAYLIST SHOULD BE SAVED: " dir
    fi
            
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
	mkdir_on_usb="$( echo $usb_media/$dir   )"
	mkdir $mkdir_on_usb

    #Measure space left on USB
	space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
	sleep 0.5
	echo ""
    if [ $language == "polish" ] ;
        then
	        echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi

    #Choose quality
    sleep 0.5
	echo ""

    if [ $language == "polish" ] ;
        then
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
    fi

    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        if [ $language == "polish" ] ;
        then
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            echo "THE CORRECT VALUE IS: 128K OR 320K"
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
        fi
    done

    #Main command for download playlist
    echo ""
    
    if [ $language == "polish" ] ;
        then
            echo -e " ${PURPLE} MP3 SA ZACHOWANE POD: $mkdir_on_usb  ${NC} "
        else
            echo -e " ${PURPLE} MP3 file is saved under: $mkdir_on_usb  ${NC} "
    fi

    echo ""

    xdg-open $mkdir_on_usb
    yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --yes-playlist  --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$playlist_id"

}

download_channel(){
	sleep 0.5
	echo ""

if [ $language == "polish" ] ;
        then
	        sleep 0.5
            echo    "W CELU SCIAGNIECIA CALEGO KANALU  NIEZBEDNY JEST LINK ZAWIERAJACY CZLON channel W LINKU"
            sleep 0.5
	        echo -e "PODAJ CALY LINK DO KANALU YOUTUBE np: ${GREEN} https://www.youtube.com/${BLUE}channel/${GREEN}UC0C1W6nV0Rv6QkvAAE_AgXg ${NC}"
 	        sleep 0.5
            #Read channels id
            echo    ""
	        read -p "PO PRAWEJ WKLEJ LINK Z PRZEGLADARKI ZAWIERAJACY CZLON channel W LINKU: " channel_id
            sleep 0.5
	        echo ""
            #Set directory for downloaded file
	        read -p "PODAJ NAZWE FOLDERU W KTORYM MA BYC ZACHOWANA PLAYLISTA: " dir
        else
            sleep 0.5
            echo    "IN ORDER TO FIND THE ENTIRE PLAYLIST, ITS IDENTIFIER IS NECESSARY"
            sleep 0.5
	        echo -e "GIVE AN ENTIRE LINK TO YOUTUBE CHANNEL e.g.  ${GREEN} https://www.youtube.com/${BLUE}channel/${GREEN}UC0C1W6nV0Rv6QkvAAE_AgXg ${NC}"
 	        sleep 0.5
            #Read channels id
            echo ""
	        read -p "ON THE RIGHT PASTE LINK FROM THE BROWSER CONTAINING THE CHANNEL STRING " channel_id
            sleep 0.5
	        echo ""
            #Set directory for downloaded file
	        read -p "ENTER THE NAME OF THE FOLDER IN WHICH SONGS FROM THE WHOLE CHANNEL SHOULD BE SAVED: " dir
    fi

    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
    #Make diroctory on USB accessible for all
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    mkdir   $mkdir_on_usb
    #chown   777 $mkdir_on_usb
    #Measure space left on USB
    space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
    sleep 0.5
    if [ $language == "polish" ] ;
        then
            echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi

    sleep 0.5
	echo ""

    #Choose quality
    sleep 0.5
	echo ""

    if [ $language == "polish" ] ;
        then
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
    fi

    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        if [ $language == "polish" ] ;
        then
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            echo "THE CORRECT VALUE IS: 128K OR 320K"
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
        fi
    done

    echo ""
     if [ $language == "polish" ] ;
        then
            echo -e " ${PURPLE} MP3 SA ZACHOWANE POD: $mkdir_on_usb  ${NC} "
        else
            echo -e " ${PURPLE} MP3 file is saved under: $mkdir_on_usb  ${NC} "
    fi

    echo ""

    xdg-open $mkdir_on_usb
    yt-dlp -f best -ciw --extract-audio --audio-format mp3 --audio-quality $quality_mp3 -o  $mkdir_on_usb/"%(title)s.%(ext)s" -v "$channel_id"
}

download_movie(){
    touch /tmp/site_mov.txt

    #Set directory for downloaded file
    if [ $language == "polish" ] ;
        then
            read -p "PODAJ NAZWE FOLDERU W KTORYM MA/MAJA BYC ZACHOWANY FILM/FILMY: " dir
        else
            read -p "ENTER THE NAME OF THE FOLDER IN WHICH THE VIDEO/VIDEOS SHOULD BE SAVED: " dir
    fi
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
    #Make diroctory on USB accessible for all
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    mkdir   $mkdir_on_usb
    #chown   777 $mkdir_on_usb
    #Measure space left on USB
    space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
    sleep 0.5
    if [ $language == "polish" ] ;
        then
            echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi

    echo ""
      if [ $language == "polish" ] ;
        then
            while [ 1 ];
                do
	                mov_list=$( cat /tmp/site_mov.txt)
                    read -p "PODAJ CALY ADRES URL FILMU I ZATWIERDZ PRZEZ ENTER. ABY PRZERWAC WPISZ q I WCISNIJ ENTER: " mov
                        if [ "$mov" == "q" ];
                            then
                                rm   /tmp/site_mov.txt
                            break;
                        else
	                        echo "$mov" >> /tmp/site_mov.txt
                        fi
            done
        else
            while [ 1 ];
                do
	                mov_list=$( cat /tmp/site_mov.txt)
                    read -p "ENTER THE ENTIRE VIDEO URL AND CONFIRM WITH ENTER. TO INTERRUPT, ENTER q AND HIT ENTER: " mov
                        if [ "$mov" == "q" ];
                            then
                                rm   /tmp/site_mov.txt
                            break;
                        else
	                        echo "$mov" >> /tmp/site_mov.txt
                        fi
                done
        fi

        sleep 0.5
	    echo ""
        xdg-open $mkdir_on_usb
        for site_mov in ${mov_list[@]}
         do
          yt-dlp --ignore-errors -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best --merge-output-format mp4 --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$site_mov" 
        done

}

download_movie_and_music_from_file(){

#Create var with mounting USB mounting points
    echo ""
	sleep 0.5
    #Set directory for downloaded files
    if [ $language == "polish" ] ;
        then
            read -p "PODAJ NAZWE FOLDERU W KTORYM MA/MAJA BYC ZACHOWANE FILM/FILMY WRAZ ZE SCIEZKA/SCIEZKAMI DZWIEKOWA/DZWIEKOWYMI: " dir
        else
            read -p "ENTER THE NAME OF THE FOLDER TO WHICH THE VIDEO/VIDEOS AND SEPARATED SOUNDTRACK/SOUNDTRACK SHOULD BE DOWNLOADED: " dir
    fi
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
	sleep 0.5
	echo ""

	if [ $language == "polish" ] ;
        then
            echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi

    #Choose quality
    sleep 0.5

	echo ""
     if [ $language == "polish" ] ;
        then
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
    fi

    while [ $quality_mp3 != "128K" ] && [ $quality_mp3 != "320K" ];
    do
        if [ $language == "polish" ] ;
        then
            echo "WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
            read -p "W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: " quality_mp3
        else
            echo "THE CORRECT VALUE IS: 128K OR 320K"
            read -p "IN WHICH QUALITY SHOULD BE THE MP3 FILES DOWNLOADED: 128K or 320K? ENTER THE CORRECT VALUE: " quality_mp3
        fi
    done

    #Reade path to file with list
     if [ $language == "polish" ] ;
        then
            read -p "PRZECIAGNIJ I UPUSC PLIK Z LISTA DO TERMINALU: " plik_1
        else
            read -p "DRAG AND DROP THE FILE WITH LIST TO TERMINAL: " plik_1
    fi
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    xdg-open $mkdir_on_usb
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
        yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality $quality_mp3 --output $mkdir_on_usb/"%(title)s.%(ext)s" "$s"
        yt-dlp --ignore-errors -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best --merge-output-format mp4 --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$s"

    done


}

download_movie_from_file(){

#Create var with mounting USB mounting points
    echo ""
	sleep 0.5
    #Set directory for downloaded files
     if [ $language == "polish" ] ;
        then
            read -p "PODAJ NAZWE FOLDERU W KTORYM MAJA BYC ZACHOWANE FILMY Z LISTY:  " dir
        else
            read -p "ENTER THE NAME OF THE FOLDER IN WHICH THE VIDEOS FROM THE LIST WILL BE SAVED:  " dir
    fi
    
    #CHECK IF DIR VAR HAVE SPACEBAR IN STRING
    if [ "$dir" != "${dir% *}" ] ; 
    then
        dir="${dir// /_}" ;
    else
        echo ""
    fi
    
    mkdir_on_usb="$( echo $usb_media/$dir   )"
    #Make diroctory on USB accessible for all
	mkdir $mkdir_on_usb
    #chown -R  777 $mkdir_on_usb
    #Measure space left on USB
	space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"
	sleep 0.5
	echo ""

	if [ $language == "polish" ] ;
        then
            echo -e "NA DYSKU USB POZOSTALO: ${RED} $space_left ${NC}"
        else
            echo -e "THE AMOUNT OF FREE SPACE ON THE DISK: ${RED} $space_left ${NC}"
    fi

    #Reade path to file with list
    sleep 0.5
	echo ""
    if [ $language == "polish" ] ;
        then
            read -p "PRZECIAGNIJ I UPUSC PLIK Z LISTA DO TERMINALU: " plik_1
        else
            read -p "DRAG AND DROP THE FILE WITH LIST TO TERMINAL: " plik_1
    fi
    plik_string=$( echo  $plik_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    xdg-open $mkdir_on_usb
    #Main download loop
    for s in $( cat $plik_string )  ;
    do
     yt-dlp --ignore-errors -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best --merge-output-format mp4 --output $mkdir_on_usb/"%(title)s.%(ext)s"  "$s"

    done


}

upgrade_yt-dlp(){
    
	sudo apt install ffmpeg -y
    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
 	#sudo apt install avconv -y
	#sudo apt-get install  libav-tools -y

}
install_yt-dlp(){
	sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    sudo apt-get install python-is-python3
}
install_tor(){

	sudo add-apt-repository ppa:micahflee/ppa -y
	sudo apt update
	sudo apt install torbrowser-launcher -y
	sudo apt install deluge -y

}

wpis_bash(){

    if [ $language == "polish" ] ;
        then
            read -p "PRZECIAGNIJ I UPUSC SKRYPT/PLIK ZAWIERAJACY POBIERAKA DO TERMINALA: " plik
        else
            read -p "DRAG AND DROP SCRIPT/FILE CONTAINING THE POBIERAK INTO THE TERMINAL: " plik
    fi

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
    if [ $language == "polish" ] ;
        then
            echo -e "OD TERAZ MOZESZ UZYC KOMENDY ${RED}${u}pobierak${NC} BASH BEZPOSREDIO W TERMINALU"
        else
            echo -e "NOW YOU CAN USE THE COMMAND ${RED}${u}pobierak${NC} BASH DIRECTLY IN THE TERMINAL"
    fi

sleep 5
exec bash
exit
}

about(){
if [ $language == "polish" ] ;
        then
            clear
            echo -e "${YELLOW}"
            cat << "EOF" >&2

                                                ++++---->    POBIERAK    <----++++

    PROGRAM BAZUJE NA PROJEKCIE YOUTUBE-DLP [ https://github.com/yt-dlp/yt-dlp ] KONTYNUACJA YOUTUBE-DL.
    ZAWIERA ZBIOR KOMEND ORAZ FUKCJI UPROSZCZAJACYCH I AUTOMATYZUJACYCH PROCES SCIAGANIA FILMOW I MUZYKI Z YT.
    TEN SKRYPT TO NAKLADKA (WRAPPER) TERMINALOWY Z JUZ PRZYGOTOWANYMI POLAMI WYBOROW.
    
                                            DO PRAWIDLOWEGO DZIALANIA SKRYPTU NIEZBEDNE SA:

        -   yt-dlp              GLOWNY PROGRAM
        -   python-is-python3   OBSLUGA JEZYKA PYTHON W KTORYM NAPISANY JEST YT-DLP
        -   ffmpeg              BIBLIOTEKI DO KONWERTOWANIA SCIAGNIETYCH PLIKOW

    ZARAZ NA POCZATKU SKRYPT SPRAWDZA CZY ZAMONTOWANY JEST NOSNIK USB ORAZ CZY UZYTKOWNIK MA NA NIM PRAWA ZAPISU
    JESLI WSZYSTKO JEST WPORZADKU, MIEJSCEM DOCELOWYM DLA SCIAGANIA PLIKOW JEST DYSK ZEWNETRZNY W PRZECIWNYM WYPADKU FOLDER DOMOWY UZYTKOWNIKA
    
    DZEIKI MC ZA MOTYWACJE DO NAPISANIA TEGO SKRYPTU, POZA JEGO PRAKTYCZNOSCIA IDZIE ROWNIEZ OSZCZEDNOSC KASY ;)    POZDRO 600

EOF

        else
            clear
            echo -e "${YELLOW}"
            cat << "EOF" >&2
                                                ++++---->    POBIERAK    <----++++
            THE PROGRAM IS BASED ON THE YOUTUBE-DLP PROJECT [https://github.com/yt-dlp/yt-dlp] CONTINUED BY YOUTUBE-DL.
       CONTAINS A SET OF COMMANDS AND FUNCTIONS TO SIMPLIFY AND AUTOMATE THE PROCESS OF DOWNLOADING FILMS AND MUSIC FROM YT.
                        THIS SCRIPT IS A TERMINAL WRAPPER WITH ALREADY PREPARED SELECTION FIELDS.

                                         FOR THE PROPER OPERATION OF THE SCRIPT, NECESSARY ARE:
        
        -   yt-dlp              MAIN PROGRAM
        -   python-is-python3   HANDLING PYTHON IN WHICH IS WRITTEN YT-DLP
        -   ffmpeg              LIBRARIES FOR CONVERTING DOWNLOADED FILES

    IMMEDIATELY AT THE BEGINNING, THE SCRIPT CHECKS IF THERE IS A USB STORAGE ATTACHED AND IF THE USER HAS WRITE RIGHTS ON IT
            IF EVERYTHING IS OK, DESTINATION FOR THE DOWNLOADED FILES IS EXTERNAL UDB DRIVE, OTHERWISE USER'S HOME FOLDER

        THANKS MC FOR THE MOTIVATION TO WRITE THIS SCRIPT, BEYOND ITS PRACTICALITY, THERE IS ALSO SAVING MONEY;) POZDRO 600
EOF
        fi

}

###############################
#7.        PRINT MENU         #
###############################
u='\e[4m'

printMenu_EN(){
	clear && printf '\e[3J'
	echo ""
	usb_check
	echo ""
    echo -e "${normal} ${u} $Pobierak_ver ${NC}"
	echo ""
	echo -e	"${PURPLE}  \t1)      DOWNLOAD AS MUCH AS YOU WANT SINGLE LINKS ${NC}"
    echo ""
    echo -e "${BLUE}    \t2)	DOWNLOAD SONGS FROM LINKS IN THE FILE ${NC}"
	echo ""
	echo -e	"${PURPLE}  \t3)	DOWNLOAD THE WHOLE PLAYLIST ${NC}"
	echo ""
	echo -e "${BLUE}    \t4)	DOWNLOAD WHOLE CHANNEL ${NC}"
	echo ""
	echo -e "${PURPLE}  \t5)	DOWNLOAD MOVIE ${NC}"
    echo ""
    echo -e "${BLUE}    \t6)	DOWNLOAD VIDEOS OR MUSIC VIDEOS FROM LIST ${NC}"
	echo ""
    echo -e "${PURPLE}  \t7)	DOWNLOAD THE FILM AND SEPARATE MP3 TRACK ${NC}"
    echo ""
	echo -e "${CYAN}    \t8)	---> YOUTUBE-DLP INSTALLATION <--- ${NC}"
	echo ""
	echo -e "${CYAN}    \t9)	UPGRADE LIBRARIES TO CONVERT AND YOUTUBE-DLP ${NC}"
	echo ""
    echo -e "${CYAN}    \t10)     INSTALL "POBIERAKA" IN THE CONSOLE (~./bashrc entry)  ${NC}"
    echo ""
    echo -e "${CYAN}    \t11)	INSTALL TOR AND DELUGE ${NC}"
	echo ""
	echo -e "   \t12)   EXIT"
    echo ""
    echo -e "${PURPLE}  \t13)   ABOUT ${NC}"
    echo ""

	echo ""
	read option;

	while [[ $option -gt 13 || ! $(echo $option ) ]] # | grep '^[1-9]$') ]]
	do
		printMenu_EN

	done
	runOption
}

printMenu_PL(){
	clear && printf '\e[3J'
	echo ""
	usb_check
	echo ""
    echo -e "${normal} ${u} $Pobierak_ver ${NC}"
	echo ""
	echo -e	"${PURPLE}  \t1)      SCIAGNIJ ILE CHCESZ POJEDYNCZYCH LINKOW ${NC}"
    echo ""
    echo -e "${BLUE}    \t2)	SCIAGNIJ PIOSENKI Z LINKOW ZNAJDUJACYCH SIE W PLIKU ${NC}"
	echo ""
	echo -e	"${PURPLE}  \t3)	SCIAGNIJ CALA PLAYLISTE ${NC}"
	echo ""
	echo -e "${BLUE}    \t4)	SCIAGNIJ CALY KANAL ${NC}"
	echo ""
	echo -e "${PURPLE}  \t5)	SCIAGNIJ FILM ${NC}"
    echo ""
    echo -e "${BLUE}    \t6)	SCIAGNIJ FILMY LUB TELEDYSKI Z LISTY ${NC}"
	echo ""
    echo -e "${PURPLE}  \t7)	SCIAGNIJ FILM & SCIEZKE MP3 ${NC}"
    echo ""
	echo -e "${CYAN}    \t8)	---> INSTALACJA YOUTUBE-DLP <--- ${NC}"
	echo ""
	echo -e "${CYAN}    \t9)	UPGRADE BIBLIOTEK DO KONWERTOWANIA ORAZ YOUTUBE-DLP${NC}"
	echo ""
    echo -e "${CYAN}    \t10)     INSTALUJ POBIERAKA W KONSOLI  ${NC}"
    echo ""
    echo -e "${CYAN}    \t11)	INSTALL TOR AND DELUGE ${NC}"
	echo ""
	echo -e "   \t12)   EXIT"
    echo ""
    echo -e "${PURPLE}  \t13)   ABOUT ${NC}"
    echo ""

	echo ""
	read option;

	while [[ $option -gt 13 || ! $(echo $option ) ]] # | grep '^[1-9]$') ]]
	do
        printMenu_PL

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
    8) install_yt-dlp;;
	9) upgrade_yt-dlp;;
	10) wpis_bash;;
    11) install_tor;;
	12) exit;;
    13) about;;

	esac
	echo "Press any Key to continue"
	read x
	if [ $language == "polish" ] ;
        then
            printMenu_PL
        else
            printMenu_EN
    fi
            
}
while true ;
do
	if [ $language == "polish" ] ;
        then
            printMenu_PL
        else
            printMenu_EN
    fi
done
