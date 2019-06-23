CONFIGURATION PARE-FEU

iptables -t filter -A INPUT -p tcp --dport 6542 -j ACCEPT  //pare feu 1

iptables -t nat POSTROUTING -o eth0 -j MASQUERADE   //pare feu 2

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eh0 -j MASQUERADE   //pare feu 3



RENDRE LES REGLES PERMANENTES

iptables-save > /etc/iptables.rules   //pare feu 4



TEST PARE FEU

iptables -L

