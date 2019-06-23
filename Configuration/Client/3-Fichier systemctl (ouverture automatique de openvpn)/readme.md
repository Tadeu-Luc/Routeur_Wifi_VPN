Autorun de OpenVPN
---
Pour pouvoir démarrer automatiquement openvpn sans avoir de login et mot de passe à rentrer lors de la connexion.
```shell
sudo nano /etc/default/openvpn
```
Décommenter ces lignes pour permettre au fichier d'aller chercher le fichier de configuration à utiliser pour l'autorun du fichier client.
  
```shell
AUTOSTART="all" //1 ere ligne, permet de prendre en compte tous les fichiers de configuration si plusieurs VPN.
```
ou alors
```shell
AUTOSTART="nomdufichierclient" //2 eme ligne, permet de prendre en compte un seul fichier (plus sécurisé), le fichier client est le fichier .conf de /etc/open/nomdeclient.conf.
```

![alt text](https://github.com/Tadeu-Luc/Routeur_Wifi_VPN/blob/master/Configuration/Client/3-Fichier%20systemctl%20(ouverture%20automatique%20de%20openvpn)/Fichier%20autorun%20default.png)


OpenVPN étant un service du système, il permet de se lancer tout seul au démarage, toutefois pour lui faire prendre en compte les nouveaux paramètres rentrés, nous allons relancer le processus et relancer le service.

Relancement du processus:
```shell
systemctl daemon-reload
```
  
Relancement du service OpenVPN:
```shell
sudo service openvpn restart
```
