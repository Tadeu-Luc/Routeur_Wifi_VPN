CONFIGURATION PARE-FEU

iptables -t filter -A INPUT -p tcp --dport PORT -j ACCEPT  
iptables -t nat POSTROUTING -o eth0 -j MASQUERADE   
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eh0 -j MASQUERADE   



RENDRE LES REGLES PERMANENTES

iptables-save > /etc/iptables.rules  



TEST PARE FEU

iptables -L

