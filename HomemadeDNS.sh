# Configs
baseurl="http://www.aldodaquino.com/homemadedns/"
password="password"
# End Configs
ip=$(curl -s http://ipecho.net/plain)
url=$baseurl"?pw="$password"&set&ip="$ip
curl -s -stderr error.log $url
echo ""
