declare -A TEXT
#check internet
TEXT[internet_on]="Internet connection is ON"
TEXT[internet_title]="Internet connection"
TEXT[internet_off]="No internet connection."
TEXT[internet_check]="Check your network"

# Pobierak update
TEXT[pob_update_title]="Pobierak update"
TEXT[pob_update_curl_missing]="curl is not installed.\n\nCannot check for Pobierak updates."
TEXT[pob_update_remote_error]="Cannot read remote Pobierak version from GitHub."
TEXT[pob_update_available]="A newer version of Pobierak is available."
TEXT[pob_update_installed]="Installed version"
TEXT[pob_update_latest]="Latest version"
TEXT[pob_update_changelog]="Changelog"
TEXT[pob_update_question]="Do you want to update now?"
TEXT[pob_update_skipped]="Pobierak update skipped."
TEXT[pob_update_download_failed]="Download failed.\n\nPobierak was not updated."
TEXT[pob_update_done]="Pobierak has been updated."
TEXT[pob_update_old]="Old version"
TEXT[pob_update_new]="New version"
TEXT[pob_update_restart]="The script will restart now."
TEXT[pob_update_current]="Pobierak is up to date"
TEXT[pob_update_no_changelog]="No changelog available."

#menu
TEXT[pob_version]="Downloader version"
TEXT[1_opt]="DOWNLOAD AS MANY SINGLE LINKS AS YOU WANT"
TEXT[2_opt]="DOWNLOAD SONGS FROM LINKS STORED IN A FILE"
TEXT[3_opt]="DOWNLOAD ENTIRE PLAYLIST"
TEXT[4_opt]="DOWNLOAD ENTIRE CHANNEL"
TEXT[5_opt]="DOWNLOAD VIDEO"
TEXT[6_opt]="DOWNLOAD VIDEOS OR MUSIC VIDEOS FROM A LIST"
TEXT[7_opt]="DOWNLOAD VIDEO & MP3 TRACK"
TEXT[8_opt]="---> YOUTUBE-DLP INSTALLATION <---"
TEXT[9_opt]="UPGRADE CONVERSION LIBRARIES AND YOUTUBE-DLP"
TEXT[10_opt]="INSTALL POBIERAK IN CONSOLE"
TEXT[11_opt]="INSTALL TOR AND DELUGE"
TEXT[12_opt]="EXIT"
TEXT[13_opt]="ABOUT"
TEXT[14_opt]="SHOW YT-DLP ERRORS"
TEXT[15_opt]="SELECT LANGUAGE FOR POBIERAK"
TEXT[20_option]="Select option:"
#yt-dlp info
TEXT[1_if_latest]="Installed version"
TEXT[2_if_latest]="yt-dlp path"
TEXT[3_if_latest]="Latest version"
TEXT[4_if_latest]="yt-dlp is up to date."
TEXT[1_ytdlp_update]="A newer version of YT-DLP is available."
TEXT[2_ytdlp_update]="Use option 9, otherwise the download process may not work correctly."
#USB_INF
TEXT[1_usb_inf]="!!!! EXTERNAL USB IS NOT MOUNTED IN THE SYSTEM :( !!!!"
TEXT[2_usb_inf]="TARGET SAVE FOLDER IS"
TEXT[3_usb_inf]="AVAILABLE DISK SPACE:"
TEXT[4_usb_inf]="USB NAME CONTAINS SPACES !!!. TARGET SAVE LOCATION IS:"
TEXT[5_usb_inf]="(LOCAL DISK). AVAILABLE DISK SPACE: "
TEXT[6_usb_inf]="IF YOU WANT TO USE USB AS SAVE LOCATION, RENAME IT WITHOUT SPACES !"
TEXT[7_usb_inf]="EXTERNAL USB IS PROPERLY MOUNTED IN THE SYSTEM ;)."
#repeating functions
TEXT[1_set_dir]="ENTER THE NAME OF THE FOLDER WHERE FILES SHOULD BE SAVED"
TEXT[1_set_sing_link]="ENTER THE FULL ADDRESS (YOUTUBE LINK). TO CANCEL TYPE q AND PRESS ENTER: "
TEXT[1_set_song_quality]="WHAT MP3 QUALITY DO YOU WANT TO DOWNLOAD: 128K or 320K ? ENTER A VALID VALUE: "
TEXT[2_set_song_quality]="ENTER A VALID VALUE: 128K OR 320K"
TEXT[3_set_song_quality]="WHAT MP3 QUALITY DO YOU WANT TO DOWNLOAD: 128K or 320K ? ENTER A VALID VALUE: "
#Playlist function
TEXT[1_playlist_func]="TO DOWNLOAD THE WHOLE PLAYLIST, ITS IDENTIFIER IS REQUIRED"
TEXT[2_playlist_func]="THE PLAYLIST IDENTIFIER IS MARKED IN GREEN IN THE EXAMPLE LINK NEXT TO IT: "
TEXT[3_playlist_func]="ENTER THE PLAYLIST IDENTIFIER FROM THE ADDRESS IN YOUR BROWSER: "
#Channel function
TEXT[1_channel_func]="TO DOWNLOAD THE WHOLE CHANNEL, A LINK CONTAINING the channel PART IN THE LINK IS REQUIRED"
TEXT[2_channel_func]="ENTER THE FULL LINK TO THE YOUTUBE CHANNEL, EXAMPLE:"
TEXT[3_channel_func]="PASTE THE LINK FROM YOUR BROWSER CONTAINING the channel PART IN THE LINK ON THE RIGHT: "
#Err function
TEXT[1_ERR_LVL]="ERROR REPORTING YES/NO ? : "
TEXT[2_ERR_LVL]="CURRENTLY: NO"
TEXT[3_ERR_LVL]="CURRENTLY: YES"
#Write 2 bash
TEXT[1_drag_drop_bash]="DRAG AND DROP THE SCRIPT/FILE CONTAINING POBIERAK INTO THE TERMINAL: "
TEXT[1_write_bash]="FROM NOW ON YOU CAN USE THE COMMAND"
TEXT[2_write_bash]="BASH DIRECTLY IN THE TERMINAL"
#separated
TEXT[1_drag_drop]="DRAG AND DROP THE FILE WITH THE LIST INTO THE TERMINAL:"
TEXT[1_info]="AFTER DOWNLOAD IS FINISHED, THE FOLDER WITH TRACKS WILL BE OPENED"

about(){
clear
    echo -e "${YELLOW}"
    cat <<'EOF'
                                                ++++---->    POBIERAK    <----++++
    THE PROGRAM IS BASED ON THE YOUTUBE-DLP PROJECT [ https://github.com/yt-dlp/yt-dlp ], A CONTINUATION OF YOUTUBE-DL.
    IT CONTAINS A SET OF COMMANDS AND FUNCTIONS THAT SIMPLIFY AND AUTOMATE DOWNLOADING VIDEOS AND MUSIC FROM YT.
    THIS SCRIPT IS A TERMINAL WRAPPER WITH PREPARED SELECTION FIELDS.
                                            REQUIRED FOR PROPER SCRIPT OPERATION:
        -   yt-dlp              MAIN PROGRAM
        -   python-is-python3   PYTHON SUPPORT USED BY YT-DLP
        -   ffmpeg              LIBRARIES FOR CONVERTING DOWNLOADED FILES
    AT STARTUP, THE SCRIPT CHECKS WHETHER A USB DRIVE IS MOUNTED AND WHETHER THE USER HAS WRITE PERMISSIONS ON IT.
    IF EVERYTHING IS OK, THE TARGET DOWNLOAD LOCATION IS THE EXTERNAL DRIVE; OTHERWISE, THE USER HOME FOLDER IS USED.
    THANKS TO MC FOR THE MOTIVATION TO WRITE THIS SCRIPT AND TO KAGAN FOR MENTIONING THE UPDATE ;)
                                    BESIDES BEING PRACTICAL, IT ALSO SAVES MONEY ;)    CHEERS 600
EOF
    echo -e "${NC}"
}
