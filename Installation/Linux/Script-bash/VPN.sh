echo "Voulez-vous connecter au tunnel VPN eixa6 ? [oui ou non]"
read resultat
if [ $resultat = "oui" ]
then
        openvpn --config /home/pi/Documents/Openvpn/Test.ovpn
         for i in "seq 1 86400"
        echo "sa fonctionne"
else
        echo "Vous avez decidé de rester sur votre connexion internet classique"
fi

