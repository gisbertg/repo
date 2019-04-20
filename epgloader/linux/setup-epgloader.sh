#!/bin/bash
tput clear
echo "###########################################################################################"
echo "###                        EPGloader Installer for Linux                                ###"
echo "###                    --Takealug.de feat. easyEPG Project--                            ###"
echo "###                                Revision 1                                           ###"
echo "###########################################################################################"
echo
echo "Please, enter your Username for Takealug.de"   
read username
echo
echo "and now, enter your Password" 
read password
echo
echo 'Choose your desired Storage Path (like /home/'$USER'/epgloader)'
read location

tput clear
echo "###########################################################################################"
echo "###########################################################################################"
echo "Your Username on Takealug ist          $username                                           "
echo "Your Password ist                      $password                                           "
echo "Your desired Storage Path is           $location                                           "
echo "###########################################################################################"
echo "###########################################################################################"
echo 
echo "Are this Settings Correct ?"
echo "[1] Yes, go on!"
echo "[2] No!"  
read n
case $n in
    1) echo "Ok" ;;
    2) exit;;
    *) invalid option;;
esac
mkdir "$location"
mkdir "$location/settings"

tput clear
echo "###########################################################################################"
echo "###########################################################################################"
echo "Create configuration in $location/settings/settings.ini                                    "
echo "###########################################################################################"
echo "###########################################################################################"
sleep 1
echo "username=$username"> "$location"/settings/settings.ini
echo "password=$password">> "$location"/settings/settings.ini
echo "location=$location">> "$location"/settings/settings.ini
sleep 1
tput clear

echo "###########################################################################################"
echo "###########################################################################################"
echo "Create EPG-Changer in $location/change-epg.sh                                              "
echo "###########################################################################################"
echo "###########################################################################################"
sleep 1
echo '#!/bin/bash'> "$location"/change-epg.sh
echo '. '$location'/settings/settings.ini'>> "$location"/change-epg.sh
echo 'git=$location/settings/git.sh'>> "$location"/change-epg.sh
echo 'curl -L -o $git "https://github.com/DeBaschdi/repo/raw/master/epgloader/linux/git.sh"'>> "$location"/change-epg.sh
echo 'cd $location/settings/'>> "$location"/change-epg.sh
echo 'chmod a+x $git'>> "$location"/change-epg.sh
echo '$git'>> "$location"/change-epg.sh
sleep 1
tput clear

echo "###########################################################################################"
echo "###########################################################################################"
echo "Create epgloader-linux.sh in "$location"/epgloader-linux.sh                                   "
echo "###########################################################################################"
echo "###########################################################################################"
sleep 1
echo '#!/bin/bash'> "$location"/epgloader-linux.sh
echo '. '$location'/settings/settings.ini'>> "$location"/epgloader-linux.sh
echo '. '$location'/settings/source.ini'>> "$location"/epgloader-linux.sh
echo 'filename=$location/guide.tar.gz'>> "$location"/epgloader-linux.sh
echo 'agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:66.0) Gecko/20100101 Firefox/66.0"'>> "$location"/epgloader-linux.sh
echo 'cd "$location/"'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo '## authenticate and save cookies'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo 'curl  --dump-header "$location"/settings/cookie1.txt "https://takealug.de/wordpress/wp-login.php"'>> "$location"/epgloader-linux.sh
echo 'curl  --user-agent "$agent" \'>> "$location"/epgloader-linux.sh
echo '      --dump-header  "$location"/settings/cookie1.txt \'>> "$location"/epgloader-linux.sh
echo '      --cookie "$location"/settings/cookie1.txt --cookie-jar "$location"/settings/cookie1.txt \'>> "$location"/epgloader-linux.sh
echo '      --form log="$username" \'>> "$location"/epgloader-linux.sh
echo '      --form pwd="$password" --form testcookie=1 \'>> "$location"/epgloader-linux.sh
echo '      --form wp-submit="Log In" \'>> "$location"/epgloader-linux.sh
echo '      --form redirect_to="https://takealug.de/wordpress/wp-admin" --form submit=login \'>> "$location"/epgloader-linux.sh
echo '      --form rememberme=forever "https://takealug.de/wordpress/wp-login.php"'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo '## access home page with authenticated cookies and download compressed guide'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo 'curl -L -o "$filename" --cookie "$location"/settings/cookie1.txt https://takealug.de/wordpress/download/"$EPG"/'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo '##extract guide'>> "$location"/epgloader-linux.sh
echo ''>> "$location"/epgloader-linux.sh
echo 'tar xvf "$filename"'>> "$location"/epgloader-linux.sh
echo 'exit'>> "$location"/epgloader-linux.sh
sleep 1
tput clear

chmod a+x $location/epgloader-linux.sh
chmod a+x $location/change-epg.sh
echo "###########################################################################################"
echo "###########################################################################################"
echo "Setup is almost done, run $location/epgloader-linux.sh to download your EPG                "
echo "If you want to choose an other EPG Source, run $location/change-epg.sh                     "
echo "###########################################################################################"
echo "###########################################################################################"
sleep 6
tput clear
echo "###########################################################################################"
echo "###########################################################################################"
echo "                       Starting change-epg.sh in 3 Seconds                                 "
echo "###########################################################################################"
echo "###########################################################################################"
sleep 3
tput clear
$location/change-epg.sh
