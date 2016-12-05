# Getting password from user
echo 'First of all choose a password'
read password

# Building php script
echo -e "\nBuilding php script"
sed "s/\$thepw = \"password\";/\$thepw = \"$password\";/g" homemadedns/index.php > homemadedns/index.php

# Getting url from user
echo -e '\nNow update the homemadedns (in lowercase) folder on your website, then press [ENTER]'
read
echo 'Now insert the url of the folder you have just uploaded on your website'
echo "for example: \"http://www.aldodaquino.com/homemmadedns/\" (do not forget the http://)"
read url

# Building the bash script
echo -e '\nBuilding bash script...'
echo '# Configs' > HomemadeDNS.sh
echo "baseurl=\"$url\"" >> HomemadeDNS.sh
echo "password=\"$password\"" >> HomemadeDNS.sh
echo '# End Configs' >> HomemadeDNS.sh
echo 'ip=$(curl -s http://ipecho.net/plain)' >> HomemadeDNS.sh
echo 'url=$baseurl"?pw="$password"&set&ip="$ip' >> HomemadeDNS.sh
echo 'curl -s -stderr error.log $url' >> HomemadeDNS.sh
echo 'echo ""' >> HomemadeDNS.sh
echo 'OK.'

# Executing bash script
echo -e '\nExecuting bash script...'
chmod +x HomemadeDNS.sh
./HomemadeDNS.sh

# Adding the crontab job
echo -e '\nAdding cronetab job...'
crontab -l | grep -vE "HomemadeDNS.sh" > cronfile
echo "*/5 * * * * $(pwd)/HomemadeDNS.sh" >> cronfile
crontab cronfile
rm cronfile
echo 'OK. Finished!'
echo -e "\nNow open your browser and navigate to:"
echo "\"$url?pw=$password\" to be redirected to your homemade web server"
echo "\"$url?pw=$password&get\" to get the url of your device"
