declare -A TEXT
#check internet

TEXT[internet_on]="Internetverbindung ist aktiv"
TEXT[internet_title]="Internetverbindung"
TEXT[internet_off]="Keine Internetverbindung."
TEXT[internet_check]="Pruefe dein Netzwerk und versuche es erneut."

# Pobierak update
TEXT[pob_update_title]="Pobierak-Aktualisierung"
TEXT[pob_update_curl_missing]="curl ist nicht installiert.\n\nPobierak-Aktualisierungen koennen nicht geprueft werden."
TEXT[pob_update_remote_error]="Remote-Version von Pobierak konnte nicht von GitHub gelesen werden."
TEXT[pob_update_available]="Eine neuere Version von Pobierak ist verfuegbar."
TEXT[pob_update_installed]="Installierte Version"
TEXT[pob_update_latest]="Neueste Version"
TEXT[pob_update_changelog]="Aenderungsliste"
TEXT[pob_update_question]="Moechtest du jetzt aktualisieren?"
TEXT[pob_update_skipped]="Pobierak-Aktualisierung uebersprungen."
TEXT[pob_update_download_failed]="Download fehlgeschlagen.\n\nPobierak wurde nicht aktualisiert."
TEXT[pob_update_done]="Pobierak wurde aktualisiert."
TEXT[pob_update_old]="Alte Version"
TEXT[pob_update_new]="Neue Version"
TEXT[pob_update_restart]="Das Skript wird jetzt neu gestartet."
TEXT[pob_update_current]="Pobierak ist aktuell"
TEXT[pob_update_no_changelog]="Keine Aenderungsliste verfuegbar."

#menu
TEXT[pob_version]="Pobierak-Version"
TEXT[1_opt]="SO VIELE EINZELNE LINKS HERUNTERLADEN, WIE DU MOECHTEST"
TEXT[2_opt]="SONGS AUS LINKS IN EINER DATEI HERUNTERLADEN"
TEXT[3_opt]="GANZE PLAYLIST HERUNTERLADEN"
TEXT[4_opt]="GANZEN KANAL HERUNTERLADEN"
TEXT[5_opt]="VIDEO HERUNTERLADEN"
TEXT[6_opt]="VIDEOS ODER MUSIKVIDEOS AUS EINER LISTE HERUNTERLADEN"
TEXT[7_opt]="VIDEO & MP3-SPUR HERUNTERLADEN"
TEXT[8_opt]="---> YOUTUBE-DLP INSTALLATION <---"
TEXT[9_opt]="KONVERTIERUNGSBIBLIOTHEKEN UND YOUTUBE-DLP AKTUALISIEREN"
TEXT[10_opt]="POBIERAK IN DER KONSOLE INSTALLIEREN"
TEXT[11_opt]="TOR UND DELUGE INSTALLIEREN"
TEXT[12_opt]="BEENDEN"
TEXT[13_opt]="UEBER"
TEXT[14_opt]="YT-DLP FEHLER ANZEIGEN"
TEXT[15_opt]="SPRACHE FUER POBIERAK AUSWAEHLEN"
TEXT[20_option]="Option auswaehlen:"
#yt-dlp info
TEXT[1_if_latest]="Installierte Version"
TEXT[2_if_latest]="yt-dlp Pfad"
TEXT[3_if_latest]="Neueste Version"
TEXT[4_if_latest]="yt-dlp ist aktuell."
TEXT[1_ytdlp_update]="Eine neuere Version von YT-DLP ist verfuegbar."
TEXT[2_ytdlp_update]="Nutze Option 9, sonst funktioniert der Download-Prozess moeglicherweise nicht korrekt."
#USB_INF
TEXT[1_usb_inf]="!!!! EXTERNER USB-DATENTRAEGER IST NICHT IM SYSTEM EINGEHAENGT :( !!!!"
TEXT[2_usb_inf]="ZIELORDNER ZUM SPEICHERN IST"
TEXT[3_usb_inf]="VERFUEGBARER SPEICHERPLATZ:"
TEXT[4_usb_inf]="USB-NAME ENTHAELT LEERZEICHEN !!!. ZIELSPEICHERORT IST:"
TEXT[5_usb_inf]="(LOKALE FESTPLATTE). VERFUEGBARER SPEICHERPLATZ: "
TEXT[6_usb_inf]="WENN DU USB ALS SPEICHERORT NUTZEN WILLST, BENENNE IHN OHNE LEERZEICHEN UM !"
TEXT[7_usb_inf]="EXTERNER USB-DATENTRAEGER IST KORREKT IM SYSTEM EINGEHAENGT ;)."
#repeating functions
TEXT[1_set_dir]="GIB DEN NAMEN DES ORDNERS EIN, IN DEM DIE DATEIEN GESPEICHERT WERDEN SOLLEN"
TEXT[1_set_sing_link]="GIB DIE VOLLSTAENDIGE ADRESSE EIN (YT-LINK). ZUM ABBRECHEN q EINGEBEN UND ENTER DRUECKEN: "
TEXT[1_set_song_quality]="IN WELCHER MP3-QUALITAET MOECHTEST DU HERUNTERLADEN: 128K oder 320K ? GIB EINEN GUELTIGEN WERT EIN: "
TEXT[2_set_song_quality]="GIB EINEN GUELTIGEN WERT EIN: 128K ODER 320K"
TEXT[3_set_song_quality]="IN WELCHER MP3-QUALITAET MOECHTEST DU HERUNTERLADEN: 128K oder 320K ? GIB EINEN GUELTIGEN WERT EIN: "
#Playlist function
TEXT[1_playlist_func]="UM DIE GANZE PLAYLIST HERUNTERZULADEN, WIRD IHRE KENNUNG BENOETIGT"
TEXT[2_playlist_func]="DIE PLAYLIST-KENNUNG IST IM BEISPIELLINK DANEBEN GRUEN MARKIERT: "
TEXT[3_playlist_func]="GIB DIE PLAYLIST-KENNUNG AUS DER ADRESSE IN DEINEM BROWSER EIN: "
#Channel function
TEXT[1_channel_func]="UM DEN GANZEN KANAL HERUNTERZULADEN, WIRD EIN LINK MIT DEM TEIL channel IM LINK BENOETIGT"
TEXT[2_channel_func]="GIB DEN VOLLSTAENDIGEN LINK ZUM YOUTUBE-KANAL EIN, BEISPIEL:"
TEXT[3_channel_func]="FUEGE RECHTS DEN LINK AUS DEM BROWSER EIN, DER DEN TEIL channel IM LINK ENTHAELT: "
#Err function
TEXT[1_ERR_LVL]="FEHLERBERICHTE YES/NO ? : "
TEXT[2_ERR_LVL]="AKTUELL: NEIN"
TEXT[3_ERR_LVL]="AKTUELL: JA"
#Write 2 bash
TEXT[1_drag_drop_bash]="ZIEHE DAS SCRIPT/DIE DATEI MIT POBIERAK IN DAS TERMINAL: "
TEXT[1_write_bash]="AB JETZT KANNST DU DEN BEFEHL VERWENDEN"
TEXT[2_write_bash]="BASH DIREKT IM TERMINAL"
#separated
TEXT[1_drag_drop]="ZIEHE DIE DATEI MIT DER LISTE IN DAS TERMINAL:"
TEXT[1_info]="NACH DEM DOWNLOAD WIRD DER ORDNER MIT DEN TRACKS GEOEFFNET"

about(){
clear
    echo -e "${YELLOW}"
    cat <<'EOF'
                                                ++++---->    POBIERAK    <----++++
    DAS PROGRAMM BASIERT AUF DEM YOUTUBE-DLP-PROJEKT [ https://github.com/yt-dlp/yt-dlp ], DER FORTSETZUNG VON YOUTUBE-DL.
    ES ENTHAELT EINE SAMMLUNG VON BEFEHLEN UND FUNKTIONEN, DIE DAS HERUNTERLADEN VON VIDEOS UND MUSIK VON YT VEREINFACHEN UND AUTOMATISIEREN.
    DIESES SCRIPT IST EIN TERMINAL-WRAPPER MIT VORBEREITETEN AUSWAHLFELDERN.
                                            FUER DEN KORREKTEN BETRIEB DES SCRIPTS WERDEN BENOETIGT:
        -   yt-dlp              HAUPTPROGRAMM
        -   python-is-python3   PYTHON-UNTERSTUETZUNG, DIE VON YT-DLP VERWENDET WIRD
        -   ffmpeg              BIBLIOTHEKEN ZUM KONVERTIEREN HERUNTERGELADENER DATEIEN
    BEIM START PRUEFT DAS SCRIPT, OB EIN USB-DATENTRAEGER EINGEHAENGT IST UND OB DER BENUTZER SCHREIBRECHTE DARAUF HAT.
    WENN ALLES IN ORDNUNG IST, IST DAS ZIEL FUER DOWNLOADS DER EXTERNE DATENTRAEGER; ANDERNFALLS WIRD DER HOME-ORDNER DES BENUTZERS VERWENDET.
    DANKE AN MC FUER DIE MOTIVATION, DIESES SCRIPT ZU SCHREIBEN, UND AN KAGAN FUER DEN HINWEIS AUF DIE AKTUALISIERUNG ;)
                                    NEBEN DER PRAKTISCHEN NUTZUNG SPART ES AUCH GELD ;)    GRUESSE 600
EOF
    echo -e "${NC}"
}
