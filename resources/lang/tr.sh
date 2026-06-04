declare -A TEXT
#check internet

TEXT[internet_on]="Internet baglantisi aktif"
TEXT[internet_title]="Internet baglantisi"
TEXT[internet_off]="Internet baglantisi yok."
TEXT[internet_check]="Ag baglantini kontrol et ve tekrar den"

# Pobierak update
TEXT[pob_update_title]="Pobierak guncellemesi"
TEXT[pob_update_curl_missing]="curl kurulu degil.\n\nPobierak guncellemeleri kontrol edilemiyor."
TEXT[pob_update_remote_error]="GitHub uzerinden uzak Pobierak surumu okunamadi."
TEXT[pob_update_available]="Pobierak'in daha yeni bir surumu mevcut."
TEXT[pob_update_installed]="Kurulu surum"
TEXT[pob_update_latest]="En yeni surum"
TEXT[pob_update_changelog]="Degisiklik listesi"
TEXT[pob_update_question]="Simdi guncellemek istiyor musun?"
TEXT[pob_update_skipped]="Pobierak guncellemesi atlandi."
TEXT[pob_update_download_failed]="Indirme basarisiz oldu.\n\nPobierak guncellenmedi."
TEXT[pob_update_done]="Pobierak guncellendi."
TEXT[pob_update_old]="Eski surum"
TEXT[pob_update_new]="Yeni surum"
TEXT[pob_update_restart]="Script simdi yeniden baslatilacak."
TEXT[pob_update_current]="Pobierak guncel"
TEXT[pob_update_no_changelog]="Degisiklik listesi mevcut degil."

#menu
TEXT[pob_version]="Pobierak surumu"
TEXT[1_opt]="ISTEDIGIN KADAR TEKIL LINK INDIR"
TEXT[2_opt]="BIR DOSYADAKI LINKLERDEN SARKILARI INDIR"
TEXT[3_opt]="TUM OYNATMA LISTESINI INDIR"
TEXT[4_opt]="TUM KANALI INDIR"
TEXT[5_opt]="VIDEO INDIR"
TEXT[6_opt]="LISTEDEN VIDEO VEYA MUZIK VIDEOLARI INDIR"
TEXT[7_opt]="VIDEO & MP3 PARCASI INDIR"
TEXT[8_opt]="---> YOUTUBE-DLP KURULUMU <---"
TEXT[9_opt]="DONUSTURME KUTUPHANELERINI VE YOUTUBE-DLP'YI GUNCELLE"
TEXT[10_opt]="POBIERAK'I KONSOLA KUR"
TEXT[11_opt]="TOR VE DELUGE KUR"
TEXT[12_opt]="CIKIS"
TEXT[13_opt]="HAKKINDA"
TEXT[14_opt]="YT-DLP HATALARINI GOSTER"
TEXT[15_opt]="POBIERAK ICIN DIL SEC"
TEXT[20_option]="Secenek sec:"
#yt-dlp info
TEXT[1_if_latest]="Kurulu surum"
TEXT[2_if_latest]="yt-dlp yolu"
TEXT[3_if_latest]="En yeni surum"
TEXT[4_if_latest]="yt-dlp guncel."
TEXT[1_ytdlp_update]="YT-DLP'nin daha yeni bir surumu mevcut."
TEXT[2_ytdlp_update]="9. secenegi kullan, aksi halde indirme islemi dogru calismayabilir."
#USB_INF
TEXT[1_usb_inf]="!!!! HARICI USB SISTEME BAGLANMAMIS :( !!!!"
TEXT[2_usb_inf]="HEDEF KAYIT KLASORU"
TEXT[3_usb_inf]="DISKTEKI BOS ALAN:"
TEXT[4_usb_inf]="USB ADINDA BOSLUK VAR !!!. HEDEF KAYIT YERI:"
TEXT[5_usb_inf]="(YEREL DISK). DISKTEKI BOS ALAN: "
TEXT[6_usb_inf]="USB'YI KAYIT YERI OLARAK KULLANMAK ISTIYORSAN ADINI BOSLUKSUZ OLARAK DEGISTIR !"
TEXT[7_usb_inf]="HARICI USB SISTEME DOGRU SEKILDE BAGLANMIS ;)."
#repeating functions
TEXT[1_set_dir]="DOSYALARIN KAYDEDILECEGI KLASOR ADINI GIR"
TEXT[1_set_sing_link]="TAM ADRESI GIR (YT LINKI). IPTAL ETMEK ICIN q YAZ VE ENTER'A BAS: "
TEXT[1_set_song_quality]="MP3 HANGI KALITEDE INDIRILSIN: 128K veya 320K ? GECERLI BIR DEGER GIR: "
TEXT[2_set_song_quality]="GECERLI BIR DEGER GIR: 128K VEYA 320K"
TEXT[3_set_song_quality]="MP3 HANGI KALITEDE INDIRILSIN: 128K veya 320K ? GECERLI BIR DEGER GIR: "
#Playlist function
TEXT[1_playlist_func]="TUM OYNATMA LISTESINI INDIRMEK ICIN LISTE KIMLIGI GEREKLIDIR"
TEXT[2_playlist_func]="OYNATMA LISTESI KIMLIGI, YANDAKI ORNEK LINKTE YESIL OLARAK ISARETLENMISTIR: "
TEXT[3_playlist_func]="TARAYICINDAKI ADRESTEN OYNATMA LISTESI KIMLIGINI GIR: "
#Channel function
TEXT[1_channel_func]="TUM KANALI INDIRMEK ICIN LINKTE channel BOLUMUNU ICEREN BIR LINK GEREKLIDIR"
TEXT[2_channel_func]="YOUTUBE KANALININ TAM LINKINI GIR, ORNEK:"
TEXT[3_channel_func]="SAG TARAFA, TARAYICIDAN channel BOLUMUNU ICEREN LINKI YAPISTIR: "
#Err function
TEXT[1_ERR_LVL]="HATA RAPORLAMA YES/NO ? : "
TEXT[2_ERR_LVL]="SU ANDA: HAYIR"
TEXT[3_ERR_LVL]="SU ANDA: EVET"
#Write 2 bash
TEXT[1_drag_drop_bash]="POBIERAK'I ICEREN SCRIPT/DOSYAYI TERMINALE SURUKLE VE BIRAK: "
TEXT[1_write_bash]="BUNDAN SONRA SU KOMUTU KULLANABILIRSIN"
TEXT[2_write_bash]="DOGRUDAN TERMINALDE BASH"
#separated
TEXT[1_drag_drop]="LISTEYI ICEREN DOSYAYI TERMINALE SURUKLE VE BIRAK:"
TEXT[1_info]="INDIRME BITTIKTEN SONRA PARCALARIN OLDUGU KLASOR ACILACAK"

about(){
clear
    echo -e "${YELLOW}"
    cat <<'EOF'
                                                ++++---->    POBIERAK    <----++++
    PROGRAM, YOUTUBE-DLP PROJESINE [ https://github.com/yt-dlp/yt-dlp ] DAYANIR; YOUTUBE-DL'NIN DEVAMIDIR.
    YT'DEN VIDEO VE MUZIK INDIRME SURECINI BASITLESTIREN VE OTOMATIKLESTIREN KOMUTLAR VE FONKSIYONLAR ICERIR.
    BU SCRIPT, HAZIR SECIM ALANLARI OLAN BIR TERMINAL WRAPPER'DIR.
                                            SCRIPTIN DOGRU CALISMASI ICIN GEREKENLER:
        -   yt-dlp              ANA PROGRAM
        -   python-is-python3   YT-DLP TARAFINDAN KULLANILAN PYTHON DESTEGI
        -   ffmpeg              INDIRILEN DOSYALARI DONUSTURMEK ICIN KUTUPHANELER
    BASLANGICTA SCRIPT, USB SURUCUNUN BAGLI OLUP OLMADIGINI VE KULLANICININ YAZMA IZNI OLUP OLMADIGINI KONTROL EDER.
    HER SEY YOLUNDAYSA, INDIRME HEDEFI HARICI DISKTIR; AKSI TAKDIRDE KULLANICININ HOME KLASORU KULLANILIR.
    BU SCRIPTI YAZMA MOTIVASYONU ICIN MC'YE VE GUNCELLEMEYI HATIRLATTIGI ICIN KAGAN'A TESEKKURLER ;)
                                    PRATIK OLMASININ YANI SIRA PARA DA TASARRUF ETTIRIR ;)    SELAMLAR 600
EOF
    echo -e "${NC}"
}
