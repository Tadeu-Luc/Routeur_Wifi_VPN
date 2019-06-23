
OpenVPN autorun du serveur
---
Ces fichiers de configurations permettent de pouvoir démarrer le service openvpn au démarrage du système via le daemon reload.
<br>



_Optionnel:_
---
<br>




Pour que Openvpn se lance automatiqument, nous allons avoir besoin de placer le fichier server.conf dans /etc/openvpn/ (si vous avez suivis la partie 1 sans script alors vous n'avez besoin que de relancé le gestionnaire de service) :
<br>


 ```shell
cp /lieudevotrefichierdeconf/server.conf /etc/openvpn/
```
Dans le script /init.d/openvpn/ :
<br>


 ```shell
 //Variable Globales
 CONFIG_DIR=/etc/openvpn
 
start_vpn () {
    if grep -q '^[	 ]*daemon' $CONFIG_DIR/$NAME.conf ; then
      # daemon already given in config file
      DAEMONARG=
```
on peut voir que le serveur se démarre si un fichier (d'un nom aléatoire) avec une extension .conf se situe dans le fichier /etc/openvpn.




Verification du service init.d


Une fois le fichier server.conf mis dans le dossier /etc/openvpn/
```shell
cp /lieudevotrefichierdeconf/server.conf /etc/openvpn/
```
<br>
<br>


Important :
----
<br>



Pour que le système reconnaise le fichier de configuration de OpenVPN et que celui-ci se démarre automatiquement, vous aurez besoin de relancé le gestionnaire de service (qui prendra en compte le fichier server.conf par défaut):
<br>


```shell
systemctl --system daemon-reload
```
