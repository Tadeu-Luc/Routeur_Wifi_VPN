CONFIGURATION DES REDIRECTIONS DES RESEAUX

echo "net.ipv4.ip_forward=1" > etc/systctl.d/NAT.conf

TESTER QUE LA COMMANDE EST PASSE

sysctl -p /etc/sysctl.d/NAT.conf

OU

nano /etc/sysctl.d/NAT.conf
