declare -A TEXT

#check internet
TEXT[internet_on]="Polaczenie internetowe jest aktywne"
TEXT[internet_title]="Polaczenie internetowe"
TEXT[internet_off]="Brak polaczenia z internetem."
TEXT[internet_check]="Sprawdz siec i sprobuj ponownie."


# Pobierak update
TEXT[pob_update_title]="Aktualizacja Pobieraka"
TEXT[pob_update_curl_missing]="curl nie jest zainstalowany.\n\nNie mozna sprawdzic aktualizacji Pobieraka."
TEXT[pob_update_remote_error]="Nie mozna odczytac zdalnej wersji Pobieraka z GitHub."
TEXT[pob_update_available]="Dostepna jest nowsza wersja Pobieraka."
TEXT[pob_update_installed]="Zainstalowana wersja"
TEXT[pob_update_latest]="Najnowsza wersja"
TEXT[pob_update_changelog]="Lista zmian"
TEXT[pob_update_question]="Czy chcesz zaktualizowac teraz?"
TEXT[pob_update_skipped]="Aktualizacja Pobieraka pominieta."
TEXT[pob_update_download_failed]="Pobieranie nie powiodlo sie.\n\nPobierak nie zostal zaktualizowany."
TEXT[pob_update_done]="Pobierak zostal zaktualizowany."
TEXT[pob_update_old]="Stara wersja"
TEXT[pob_update_new]="Nowa wersja"
TEXT[pob_update_restart]="Skrypt zostanie teraz uruchomiony ponownie."
TEXT[pob_update_current]="Pobierak jest aktualny"
TEXT[pob_update_no_changelog]="Brak dostepnej listy zmian."


#menu
TEXT[pob_version]="Wersja pobieraka"
TEXT[1_opt]="SCIAGNIJ ILE CHCESZ POJEDYNCZYCH LINKOW"
TEXT[2_opt]="SCIAGNIJ PIOSENKI Z LINKOW ZNAJDUJACYCH SIE W PLIKU"
TEXT[3_opt]="SCIAGNIJ CALA PLAYLISTE"
TEXT[4_opt]="SCIAGNIJ CALY KANAL"
TEXT[5_opt]="SCIAGNIJ FILM"
TEXT[6_opt]="SCIAGNIJ FILMY LUB TELEDYSKI Z LISTY"
TEXT[7_opt]="SCIAGNIJ FILM & SCIEZKE MP3"
TEXT[8_opt]="---> INSTALACJA YOUTUBE-DLP <---"
TEXT[9_opt]="UPGRADE BIBLIOTEK DO KONWERTOWANIA ORAZ YOUTUBE-DLP"
TEXT[10_opt]="INSTALUJ POBIERAKA W KONSOLI"
TEXT[11_opt]="INSTALL TOR AND DELUGE"
TEXT[12_opt]="EXIT"
TEXT[13_opt]="ABOUT"
TEXT[14_opt]="POKAZ BLEDY YT-DLP"
TEXT[15_opt]="WYBIERZ JEZYK DLA POBIERAKA"
TEXT[20_option]="Select option:"

#yt-dlp info
TEXT[1_if_latest]="Zainstalowana wersja"
TEXT[2_if_latest]="Sciezka yt-dlp"
TEXT[3_if_latest]="Najnowsza wersja"
TEXT[4_if_latest]="yt-dlp jest aktualny."
TEXT[1_ytdlp_update]="Dostepna nowsza wersja YT-DLP."
TEXT[2_ytdlp_update]="Uzyj opcji 9, inaczej proces sciagania moze nie dzialac poprawnie."


#USB_INF
TEXT[1_usb_inf]="!!!! ZEWNETRZNY USB NIE JEST ZAMONTOWANY W SYSTEMIE :( !!!!"
TEXT[2_usb_inf]="DOCELOWY FOLDER ZAPISU TO"
TEXT[3_usb_inf]="ILOSC MIEJSCA NA DYSKU:"
TEXT[4_usb_inf]="NAZWA USB ZAWIERA SPACJE !!!. DOCELOWE MIEJSCE ZAPISU TO:"
TEXT[5_usb_inf]="(DYSK LOKALNY). ILOSC MIEJSCA NA DYSKU: "
TEXT[6_usb_inf]="JESLI CHCESZ UZYWAC USB JAKO MIEJSCE ZAPISU ZMIEN JEGO NAZWE NA BEZ SPACJI !"
TEXT[7_usb_inf]="ZEWNETRZNY USB JEST PRAWIDLOWO ZAMONTOWANY W SYSTEMIE ;)."

#repeating functions
TEXT[1_set_dir]="PODAJ NAZWE FOLDERU W KTORYM MAJA BYC ZACHOWANE PLIKI"
TEXT[1_set_sing_link]="PODAJ CALY ADRES (LINK Z YT). ABY PRZERWAC WPISZ q I ENTER: "
TEXT[1_set_song_quality]="W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: "
TEXT[2_set_song_quality]="WPROWADZ POPRAWNA WARTOSC 128K LUB 320K"
TEXT[3_set_song_quality]="W JAKIEJ JAKOSCI CHCESZ ZACIAGNAC MP3: 128K lub 320K ? WPISZ POPRAWNA WARTOSC: "

#Playlist function
TEXT[1_playlist_func]="W CELU SCIAGNIECIA CALEY PLYLISTY NIEZBEDNY JEST JEJ IDENTYFIKATOR"
TEXT[2_playlist_func]="IDENTYFIKATOR PLAYLISTY ZOSTAL ZAZNACZONY NA ZIELONO W PRZYKLADOWYM LINKU OBOK: "
TEXT[3_playlist_func]="PODAJ IDENTYFIKATOR PLAYLISTY Z ADRESU W SWOJEJ PRZEGLĄDARCE: "

#Channel function
TEXT[1_channel_func]="W CELU SCIAGNIECIA CALEGO KANALU  NIEZBEDNY JEST LINK ZAWIERAJACY CZLON channel W LINKU"
TEXT[2_channel_func]="PODAJ CALY LINK DO KANALU YOUTUBE, PRZYKLAD:"
TEXT[3_channel_func]="PO PRAWEJ WKLEJ LINK Z PRZEGLADARKI ZAWIERAJACY CZLON channel W LINKU: "

#Err function
TEXT[1_ERR_LVL]="RAPORTOWANIE BLEDOW YES/NO ? : "
TEXT[2_ERR_LVL]="AKTUALNIE: NIE"
TEXT[3_ERR_LVL]="AKTUALNIE: TAK"

#Write 2 bash
TEXT[1_drag_drop_bash]="PRZECIAGNIJ I UPUSC SKRYPT/PLIK ZAWIERAJACY POBIERAKA DO TERMINALA: "
TEXT[1_write_bash]="OD TERAZ MOZESZ UZYC KOMENDY"
TEXT[2_write_bash]="BASH BEZPOSREDIO W TERMINALU"

#separated
TEXT[1_drag_drop]="PRZECIAGNIJ I UPUSC PLIK (DRAG & DROP) Z LISTA DO TERMINALA:"
TEXT[1_info]="PO ZAKONCZENIU POBIERANIA ZOSTANIE OTWARTY FOLDER Z KAWALKAMI"



about(){

clear
    echo -e "${YELLOW}"
    cat <<'EOF'
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
    
    DZIEKI DLA MC ZA MOTYWACJE DO NAPISANIA TEGO SKRYPTU ORAZ DLA KAGAN ZA WSPOMNIENIE O AKTUALIZACJI ;)
                                    POZA JEGO PRAKTYCZNOSCIA IDZIE ROWNIEZ OSZCZEDNOSC KASY ;)    POZDRO 600

EOF
echo -e "${NC}"
}
