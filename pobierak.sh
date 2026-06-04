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

SCRIPT_FILE="$(readlink -f "$0")"
SCRIPT_PATH="$(dirname "$SCRIPT_FILE")"

Pobierak_ver="5.3"
user_comp="$( whoami  )"
usb_mount="$(lsblk | grep /media | grep -oP "sd[a-z][0-9]?" | awk '{print "/dev/"$1}')"
usb_media="$(awk -v needle=$usb_mount '$1==needle {print $2}' /proc/mounts)"
###var_locale="$( cat /etc/default/locale | grep "pl" )"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
unset error_LVL


SCRIPT_FILE="$(readlink -f "$0")"
chmod +x $SCRIPT_FILE

DEFAULT_LANG_FILE="$SCRIPT_PATH/resources/lang/default_lang"

LANGUAGE="$(cat "$DEFAULT_LANG_FILE")"

#Default language
LANGUAGE="${1:-$LANGUAGE}"

# Language file path
LANG_FILE="$SCRIPT_PATH/resources/lang/${LANGUAGE}.sh"
error_LVL=$(cat $SCRIPT_PATH/resources/warnings)
source "$LANG_FILE"


translate() {
    local key="$1"
    echo "${TEXT[$key]}"
}


check_internet_connection() {
    if curl -fsI --connect-timeout 5 --max-time 8 https://github.com >/dev/null 2>&1 || \
       curl -fsI --connect-timeout 5 --max-time 8 https://www.google.com >/dev/null 2>&1; then

        echo "$(translate internet_on)"
        return 0

    else
        if command -v dialog >/dev/null 2>&1; then
            local msg
            msg="$(printf "%s\n\n%s" "$(translate internet_off)" "$(translate internet_check)")"

            dialog --title "$(translate internet_title)" \
                --msgbox "$msg" \
                8 55

            clear
        else
            echo "$(translate internet_off)"
        fi

        return 1
    fi
}


set_default_language() {
    local lang_file="$SCRIPT_PATH/resources/lang/default_lang"
    local selected_lang=""

    mkdir -p "$(dirname "$lang_file")"

    selected_lang=$(dialog \
        --clear \
        --title "Default language" \
        --menu "In which language should POBIERAK be started by default?" \
        15 60 4 \
        "en" "English" \
        "de" "German" \
        "pl" "Polish" \
        "tr" "Turkish" \
        3>&1 1>&2 2>&3)

    if [[ -n "$selected_lang" ]]; then
        echo "$selected_lang" > "$lang_file"
        dialog --title "Language saved" \
            --msgbox "Selected default language: $selected_lang" \
            7 45
    fi

    clear
    exec "$SCRIPT_FILE" "$@"
}

check_pobierak_update() {
    local repo_raw_script="https://raw.githubusercontent.com/pagend0s/pobierak_vm/main/pobierak.sh"
    local repo_raw_changelog="https://raw.githubusercontent.com/pagend0s/pobierak_vm/main/resources/chg_log"
    local repo_archive="https://github.com/pagend0s/pobierak_vm/archive/refs/heads/main.tar.gz"

    local current_script="$SCRIPT_FILE"
    local local_changelog="$SCRIPT_PATH/resources/chg_log"

    local tmp_dir=""
    local tmp_archive=""
    local tmp_changelog=""
    local tmp_config_dir=""
    local extracted_dir=""

    local local_ver=""
    local remote_ver=""
    local changelog_text=""
    local msg=""
    local backup_dir=""

    if ! command -v curl >/dev/null 2>&1; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "$(translate pob_update_curl_missing)" \
            8 60
        clear
        return 1
    fi

    if ! command -v tar >/dev/null 2>&1; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "tar is not installed.\n\nCannot update Pobierak." \
            8 60
        clear
        return 1
    fi

    # Local version
    if [[ -n "${Pobierak_ver:-}" ]]; then
        local_ver="$Pobierak_ver"
    else
        local_ver="$(
            grep -m1 -E '^[[:space:]]*Pobierak_ver=' "$current_script" \
            | sed -E 's/^[^=]+=//; s/"//g; s/'\''//g; s/[[:space:]]//g'
        )"
    fi

    [[ -z "$local_ver" ]] && local_ver="unknown"

    # Remote version from GitHub pobierak.sh
    remote_ver="$(
        curl -fsSL "$repo_raw_script" \
        | grep -m1 -E '^[[:space:]]*Pobierak_ver=' \
        | sed -E 's/^[^=]+=//; s/"//g; s/'\''//g; s/[[:space:]]//g'
    )"

    if [[ -z "$remote_ver" ]]; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "$(translate pob_update_remote_error)" \
            8 60
        clear
        return 1
    fi

    # Same version
    if [[ "$local_ver" == "$remote_ver" ]]; then
        echo "$(translate pob_update_current): $local_ver"
        return 0
    fi

    # Version compare
    if [[ "$local_ver" != "unknown" ]]; then
        if [[ "$(printf "%s\n%s\n" "$local_ver" "$remote_ver" | sort -V | tail -n1)" != "$remote_ver" ]]; then
            echo "$(translate pob_update_current): $local_ver"
            return 0
        fi
    fi

    # Changelog: first try remote, then local file
    tmp_changelog="$(mktemp)"

    if curl -fsSL "$repo_raw_changelog" -o "$tmp_changelog"; then
        changelog_text="$(cat "$tmp_changelog")"
    elif [[ -f "$local_changelog" ]]; then
        changelog_text="$(cat "$local_changelog")"
    else
        changelog_text="$(translate pob_update_no_changelog)"
    fi

    msg="$(printf "%s\n\n%s: %s\n%s: %s\n\n%s:\n%s\n\n%s" \
        "$(translate pob_update_available)" \
        "$(translate pob_update_installed)" "$local_ver" \
        "$(translate pob_update_latest)" "$remote_ver" \
        "$(translate pob_update_changelog)" "$changelog_text" \
        "$(translate pob_update_question)")"

    dialog --title "$(translate pob_update_title)" \
        --yesno "$msg" \
        22 85

    if [[ $? -ne 0 ]]; then
        rm -f "$tmp_changelog"
        clear
        echo "$(translate pob_update_skipped)"
        return 0
    fi

    tmp_dir="$(mktemp -d)"
    tmp_archive="$tmp_dir/pobierak.tar.gz"
    tmp_config_dir="$tmp_dir/local_config"

    mkdir -p "$tmp_config_dir"

    # Save local user config before update
    mkdir -p "$tmp_config_dir/resources/lang"
    mkdir -p "$tmp_config_dir/resources"

    [[ -f "$SCRIPT_PATH/resources/lang/default_lang" ]] && \
        cp "$SCRIPT_PATH/resources/lang/default_lang" "$tmp_config_dir/resources/lang/default_lang"

    [[ -f "$SCRIPT_PATH/resources/warnings" ]] && \
        cp "$SCRIPT_PATH/resources/warnings" "$tmp_config_dir/resources/warnings"

    [[ -f "$SCRIPT_PATH/resources/first_run" ]] && \
        cp "$SCRIPT_PATH/resources/first_run" "$tmp_config_dir/resources/first_run"

    # Download full repository archive
    if ! curl -fsSL "$repo_archive" -o "$tmp_archive"; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "$(translate pob_update_download_failed)" \
            8 60

        rm -rf "$tmp_dir"
        rm -f "$tmp_changelog"
        clear
        return 1
    fi

    # Extract archive
    if ! tar -xzf "$tmp_archive" -C "$tmp_dir"; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "Cannot extract update archive.\n\nPobierak was not updated." \
            8 60

        rm -rf "$tmp_dir"
        rm -f "$tmp_changelog"
        clear
        return 1
    fi

    extracted_dir="$(find "$tmp_dir" -mindepth 1 -maxdepth 1 -type d -name "pobierak_vm-*" | head -n 1)"

    if [[ -z "$extracted_dir" || ! -d "$extracted_dir" ]]; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "Cannot find extracted Pobierak files.\n\nPobierak was not updated." \
            8 60

        rm -rf "$tmp_dir"
        rm -f "$tmp_changelog"
        clear
        return 1
    fi

    # Backup whole current directory
    backup_dir="${SCRIPT_PATH}.bak_${local_ver}_$(date +%Y%m%d_%H%M%S)"

    if ! cp -a "$SCRIPT_PATH" "$backup_dir"; then
        dialog --title "$(translate pob_update_title)" \
            --msgbox "Cannot create backup.\n\nPobierak was not updated." \
            8 60

        rm -rf "$tmp_dir"
        rm -f "$tmp_changelog"
        clear
        return 1
    fi

    # Replace/update all project files from GitHub
    cp -a "$extracted_dir/." "$SCRIPT_PATH/"

    # Restore local user config
    [[ -f "$tmp_config_dir/resources/lang/default_lang" ]] && {
        mkdir -p "$SCRIPT_PATH/resources/lang"
        cp "$tmp_config_dir/resources/lang/default_lang" "$SCRIPT_PATH/resources/lang/default_lang"
    }

    [[ -f "$tmp_config_dir/resources/warnings" ]] && {
        mkdir -p "$SCRIPT_PATH/resources"
        cp "$tmp_config_dir/resources/warnings" "$SCRIPT_PATH/resources/warnings"
    }

    [[ -f "$tmp_config_dir/resources/first_run" ]] && {
        mkdir -p "$SCRIPT_PATH/resources"
        cp "$tmp_config_dir/resources/first_run" "$SCRIPT_PATH/resources/first_run"
    }

    # Make main script executable
    if [[ -f "$current_script" ]]; then
        chmod +x "$current_script"
    fi

    rm -rf "$tmp_dir"
    rm -f "$tmp_changelog"

    msg="$(printf "%s\n\n%s: %s\n%s: %s\n\nBackup:\n%s\n\n%s" \
        "$(translate pob_update_done)" \
        "$(translate pob_update_old)" "$local_ver" \
        "$(translate pob_update_new)" "$remote_ver" \
        "$backup_dir" \
        "$(translate pob_update_restart)")"

    dialog --title "$(translate pob_update_title)" \
        --msgbox "$msg" \
        13 75

    clear
    exec bash "$current_script" "$@"
}

check_pobierak_update

check_yt_dlp_version(){
    REPO="yt-dlp/yt-dlp"
    # Aktualna wersja lokalna
    if command -v yt-dlp >/dev/null 2>&1; then
        LOCAL_VERSION="$(yt-dlp --version 2>/dev/null || true)"
        LOCAL_PATH="$(command -v yt-dlp)"
    else
        LOCAL_VERSION=""
        LOCAL_PATH=""
    fi

    # Najnowsza wersja z GitHub API
    LATEST_VERSION="$(
        curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
        | grep '"tag_name":' \
        | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/'
    )"

    if [[ "$LOCAL_VERSION" == "$LATEST_VERSION" ]]; then
            echo "$(translate 4_if_latest)"
        else
            msg="$(printf "%s\n\n%s" "$(translate 1_ytdlp_update)" "$(translate 2_ytdlp_update)")"
            dialog --title "YT-DLP update" \
                --msgbox "$msg" \
                10 60
        
    fi
    clear
}

if [ $error_LVL == 0 ];
    then
        ytdlp_err=(--no-warnings  --ignore-errors)
        err_state="$(translate 2_ERR_LVL)"
    else
        ytdlp_err=()
        err_state="$(translate 3_ERR_LVL)"
fi


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

ERROR_LVL(){
    read -p "$(translate 1_ERR_LVL)" err_lvl

    while [[ "$err_lvl" != "YES" && "$err_lvl" != "NO" ]]; do
        read -p "$(translate 1_ERR_LVL)" err_lvl
    done

    if [ "$err_lvl" == "YES" ];
        then
        echo 1 > "$SCRIPT_PATH/resources/warnings"
        else
        echo 0 > "$SCRIPT_PATH/resources/warnings"
    fi
    exec "$SCRIPT_FILE" "$@"
}

#FUNCTION PRINTING INFORMATION IF DISK IS MOUNTED OR NOT AND IF THERE IS SPACEBAR IN LABEL OF THE USB WHEN ATATCHED
usb_check(){

space_left_1="$( df -PH "$usb_media" 2>/dev/null | tail -1 | awk '{print $4}' )"
var_usb_label_space=$( usb_LABEL_TEST )

	if [ "$usb_var" == 0 ] ;
        then
            echo -e "${RED}${bold} $(translate 1_usb_inf) ${normal}${NC}"
            echo -e "${GREEN}${bold} $(translate 2_usb_inf) $usb_media ;) ${normal}${NC}, ${RED} $(translate 3_usb_inf) $space_left_1 ${NC}"
        else
            if [ "$var_usb_label_space" == 1 ] ;
                then
                    usb_media="$(eval echo ~$USER)"
                    space_left_1="$( df -PH "$usb_media" 2>/dev/null | tail -1 | awk '{print $4}' )"
                    echo -e "${RED}${bold} $(translate 4_usb_inf)${BLUE} $usb_media $(translate 5_usb_inf) $space_left_1 ${NC}"
                    echo -e "${RED}${bold} $(translate 6_usb_inf) ${NC}"         
                else
            		echo -e "${GREEN}${bold} $(translate 7_usb_inf) ${RED} $(translate 3_usb_inf) $space_left_1 ${NC}"
            fi
    fi
}

########################################################################
target_folder() {
    sleep 0.5

    read -p "$(translate 1_set_dir): " dir

    dir="${dir// /_}"

    mkdir_on_usb="$usb_media/$dir"

    mkdir -p "$mkdir_on_usb"

    space_left="$(df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}')"

    sleep 0.5
    echo ""
    
}

set_single_link(){
    while [ 1 ];
	do
	mp3_list=$( cat /tmp/site.txt)
    
	read -p "$(translate 1_set_sing_link)" var
    
	if [ "$var" == "q" ];
	then
	 break;
	else
	 echo "$var" >> /tmp/site.txt
	fi
	done
	sleep 0.5
	echo ""

}

set_mp3_quality() {
    read -p "$(translate 1_set_song_quality)" quality_mp3

    while [[ "$quality_mp3" != "128K" && "$quality_mp3" != "320K" ]]; do
        echo "$(translate 2_set_song_quality)"
        read -p "$(translate 3_set_song_quality)" quality_mp3
    done
}

space_left_dir(){
    space_left="$( df -PH "$mkdir_on_usb" | tail -1 | awk '{print $4}' )" 
	sleep 0.5   
	echo ""
    echo -e "$(translate 3_usb_inf) ${RED} $space_left ${NC}"
}
########################################################################

download_song(){
    # Create target dir
    target_folder

    # Create list with urls
    touch /tmp/site.txt
    set_single_link

    mapfile -t mp3_list < /tmp/site.txt
    rm /tmp/site.txt

    space_left_dir

    # Set quality
    set_mp3_quality
    
    # Main download loop
    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"
    
    for site in "${mp3_list[@]}"; do
        yt-dlp "${ytdlp_err[@]}" \
            --format bestaudio \
            --extract-audio \
            --audio-format mp3 \
            --audio-quality "$quality_mp3" \
            --output "$mkdir_on_usb/%(title)s.%(ext)s" \
            "$site"
    done
    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &
}

download_from_list(){
    #Create var with mounting USB mounting points
    echo ""
	sleep 0.5
    # Create target dir
    target_folder

    space_left_dir
    
    # Set quality
    set_mp3_quality
    #Reade path to file with list
    sleep 0.5
	echo ""

    read -p "$(translate 1_drag_drop) " file_1

    file_path=$( echo  $file_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    
    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"
    #Main download loop
    for s in $( cat $file_path )  ;
    do
        yt-dlp "${ytdlp_err[@]}" \
            --format bestaudio \
            --extract-audio \
            --audio-format mp3 \
            --audio-quality $quality_mp3 \
            --output $mkdir_on_usb/"%(title)s.%(ext)s" \
            "$s"
    done
    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &

}

download_playlist(){
	echo ""
	sleep 0.5
    echo    "$(translate 1_playlist_func)"
    sleep 0.5
	echo -e "$(translate 2_playlist_func) https://www.youtube.com/watch?v=${GREEN}PLEsNcyT1Z66QTRRPXdJZJdPoqdud4wNKP ${NC}"
 	sleep 0.5
    #Read playlist ID
    echo    ""
	read -p "$(translate 3_playlist_func)" playlist_id
    sleep 0.5
	echo ""
       
    # Create target dir
    target_folder

    space_left_dir
    
    # Set quality
    set_mp3_quality
    #Reade path to file with list
    sleep 0.5
	echo ""

    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"

    yt-dlp "${ytdlp_err[@]}" \
        --format bestaudio \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality $quality_mp3 \
        --yes-playlist \
        --output $mkdir_on_usb/"%(title)s.%(ext)s" \
        "$playlist_id"

    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &
}

download_channel(){
	sleep 0.5
	echo ""
	sleep 0.5
    echo    "$(translate 1_channel_func)"
    sleep 0.5
	echo -e "$(translate 2_channel_func) ${GREEN} https://www.youtube.com/${BLUE}channel/${GREEN}UC0C1W6nV0Rv6QkvAAE_AgXg ${NC}"
 	sleep 0.5
    #Read channels id
    echo    ""
	read -p "$(translate 3_channel_func)" channel_id

    # Create target dir
    target_folder

    space_left_dir
    
    # Set quality
    set_mp3_quality
    #Reade path to file with list

    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"

    yt-dlp "${ytdlp_err[@]}" \
        -f best \
        -ciw \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality $quality_mp3 \
        -o  $mkdir_on_usb/"%(title)s.%(ext)s" \
        -v "$channel_id"

    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &
}

download_movie(){
    # Create target dir
    target_folder

    # Create list with urls
    touch /tmp/site.txt
    set_single_link

    mapfile -t mov_list < /tmp/site.txt
    rm /tmp/site.txt

    space_left_dir

    # Set quality
    set_mp3_quality

    # Main download loop
    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"

    sleep 0.5
	echo ""
        
    for site_mov in ${mov_list[@]}
        do
          yt-dlp "${ytdlp_err[@]}" \
            -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best \
            --merge-output-format mp4 \
            --output $mkdir_on_usb/"%(title)s.%(ext)s"  \
            "$site_mov" 
        done
    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &
}

download_movie_and_music_from_file(){
    # Create target dir
    target_folder

    space_left_dir
    
    # Set quality
    set_mp3_quality
    #Reade path to file with list
    sleep 0.5
	echo ""

    read -p "$(translate 1_drag_drop) " file_1

    file_path=$( echo  $file_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    
    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"
    #Main download loop
    sleep 0.5
    
    #Main download loop
    for s in $( cat $file_path )  ;
    do
        yt-dlp "${ytdlp_err[@]}" \
            --format bestaudio \
            --extract-audio \
            -audio-format mp3 \
            --audio-quality $quality_mp3 \
            --output $mkdir_on_usb/"%(title)s.%(ext)s" \
            "$s"

        yt-dlp "${ytdlp_err[@]}" \
            -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best \
            --merge-output-format mp4 \
            --output $mkdir_on_usb/"%(title)s.%(ext)s" \
            "$s"

    done
    setsid xdg-open $mkdir_on_usb >/dev/null 2>&1 &
}

download_movie_from_file(){

# Create target dir
    target_folder

    space_left_dir
    
    # Set quality
    #Reade path to file with list
    sleep 0.5
	echo ""

    read -p "$(translate 1_drag_drop) " file_1

    file_path=$( echo  $file_1 |  sed 's/"//g' |  sed s/\'//g )
    sleep 0.5
    
    echo -e "${YELLOW}${u}$(translate 1_info)${NC}"
    #Main download loop
    sleep 0.5
    
    #Main download loop
    for s in $( cat $file_path )  ;
    do
     yt-dlp "${ytdlp_err[@]}" \
        -f bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best \
        --merge-output-format mp4 \
        --output $mkdir_on_usb/"%(title)s.%(ext)s"  \
        "$s"
    done
    xdg-open $mkdir_on_usb
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

    read -p "$(translate 1_drag_drop_bash)" plik

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
    echo -e "$(translate 1_write_bash)${RED}${u}pobierak${NC} $(translate 2_write_bash)"
    sleep 5
    exec bash
exit
}


###############################
#7.        PRINT MENU         #
###############################
u='\e[4m'

printMenu_MULTI(){
	clear && printf '\e[3J'
    check_internet_connection
    check_yt_dlp_version
    echo "$(translate 1_if_latest) ${LOCAL_VERSION:-brak}"
    echo "$(translate 2_if_latest) ${LOCAL_PATH:-brak}"
    echo "$(translate 3_if_latest) $LATEST_VERSION"
	echo ""
	usb_check
	echo ""
    echo -e "${normal} ${u}$(translate pob_version): $Pobierak_ver${NC}"
	echo ""
	echo -e	"${PURPLE}  \t1)	$(translate 1_opt) ${NC}"
    echo ""
    echo -e "${BLUE}    \t2)	$(translate 2_opt) ${NC}"
	echo ""
	echo -e	"${PURPLE}  \t3)	$(translate 3_opt) ${NC}"
	echo ""
	echo -e "${BLUE}    \t4)	$(translate 4_opt) ${NC}"
	echo ""
	echo -e "${PURPLE}  \t5)	$(translate 5_opt)  ${NC}"
    echo ""
    echo -e "${BLUE}    \t6)	$(translate 6_opt) ${NC}"
	echo ""
    echo -e "${PURPLE}  \t7)	$(translate 7_opt) ${NC}"
    echo ""
	echo -e "${CYAN}    \t8)	$(translate 8_opt) <--- ${NC}"
	echo ""
	echo -e "${CYAN}    \t9)	$(translate 9_opt) ${NC}"
	echo ""
    echo -e "${CYAN}    \t10)   $(translate 10_opt)  ${NC}"
    echo ""
    echo -e "${CYAN}    \t11)	$(translate 11_opt) ${NC}"
	echo ""
	echo -e "   \t12)   $(translate 12_opt)"
    echo ""
    echo -e "${PURPLE}  \t13)   $(translate 13_opt) ${NC}"
    echo ""
    echo -e "${PURPLE}  \t14)   $(translate 14_opt): ${YELLOW}$err_state ${NC}"
	echo ""
    echo -e "${PURPLE}  \t15)   $(translate 15_opt)${NC}"
	read -r -p "$(translate 20_option)" option;

	while ! [[ "$option" =~ ^([1-9]|1[0-5])$ ]]; do
        echo "Invalid option. Choose number from 1 to 15."
        read -r -p "$(translate 20_option) " option
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
    14) ERROR_LVL;;
    15) set_default_language;;
	*)
		echo "Invalid option."
		;;
	esac
	echo "Press any key to continue"
	read -r x         
}
while true; do
        printMenu_MULTI
done

