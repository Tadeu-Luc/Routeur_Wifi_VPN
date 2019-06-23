<span>CONFIGURATION PARE-FEU</span>

iptables -t filter -A INPUT -p tcp --dport PORT -j ACCEPT  
iptables -t nat POSTROUTING -o eth0 -j MASQUERADE   
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eh0 -j MASQUERADE   



<span>RENDRE LES REGLES PERMANENTES</span>

iptables-save > /etc/iptables.rules  



<span>TEST PARE FEU</span>

iptables -L

