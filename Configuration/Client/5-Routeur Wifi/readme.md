Création du routeur Wifi
---
Pour faire en sorte de pouvoir créer un point d'accés wifi sur la machine nous allons devoir récuperer les paquets de raspap, raspap est un utilitaire qui permet à l'utilisateur de créer un hotspot wifi sur son rasberry via seulement une interface wifi (et pas seulement un emetteur), il a la particularité de pouvoir s'utiliser avec OpenVPN (et donc de mélanger le réseau local en wifi et le réseau VPN).


```shell
wget -q https://git.io/voEUQ -O /tmp/raspap && bash /tmp/raspap
```
<br>


Page d'administration (post installation)
--
Plusieurs options pour ce connecter à la page d'administration, soit depuis notre rasberry routeur soit en se connectant à l'adresse IP par défaut (10.3.141.1) depuis un poste connecté à la wifi.

La configuration de base étant :

```shell
IP address: 10.3.141.1
Username: admin
Password: secret
DHCP range: 10.3.141.50 to 10.3.141.255
SSID: raspi-webgui
Password: ChangeMe
```

<br>
Rentrez les logins par défaut : admin / secret pour vous retrouvez sur la page d'admnistration.
<br>
Tout ce gère sur une interface web.
<br>

```shell
http://10.3.141.1/index.php?page=wlan0_info
```
<br>

![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/Raspap/2019-05-22%2020_46_52-Raspbian%20WiFi%20Configuration%20Portal.png)
>La page d'acceuil se présente comme ça après s'être authentifié.
<br>

Plage DHCP
--
Sur cette page on intervient sur le fichier DHCP.php (pour les clients du routeur) ainsi que hostapd.php (pour les configurations du serveur), on peut établir la plage DHCP (prendre le réseau de l'interface en compte pour la déterminer). Actuellement la plage d'adresse DHCP est de 10.3.141.50 à 10.3.141.254.
<br>

Lien pour y accéder:
```shell
http://10.3.141.1/index.php?page=dhcpd_conf
```

<br>

![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/Raspap/2019-05-24%2011_48_27-Raspbian%20WiFi%20Configuration%20Portal.png)

Fichier de logs:
--
L'interface propose de voir depuis l'allumage (et toutes les 5 secondes), toutes les actions de l'appareil ainsi que la connection des différents clients (ip, interface, Adresse Mac).
<br>

Lien pour y accéder:
```shell
http://10.3.141.1/index.php?page=hostapd_conf //onglet logfile
```

<br>

![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/Raspap/2019-05-24%2011_50_55-Raspbian%20WiFi%20Configuration%20Portal.png)


<br>

Changement de mots passe :
--
Cette page permet de changer le mot de passe de l'interface web, la page intervient sur le fichier auth.conf .
<br>

Lien pour y accéder:
```shell
http://10.3.141.1/index.php?page=auth_conf
```

<br>

![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/Raspap/2019-05-24%2011_52_19-Raspbian%20WiFi%20Configuration%20Portal.png)

```shell
IP address: 10.3.141.1
Username: admin
Password: secret
DHCP range: 10.3.141.50 to 10.3.141.255
SSID: raspi-webgui
Password: ChangeMe
```
<br>

Activer OpenVPN sur le Raspap
---
Pour faire en sorte que Raspap prenne en compte l'interface TUN et donc le service OpenVPN, nous allons lui attribué dans sa configuration en lui définnisant que OpenVPN est activé sur le routeur.

<br>

Pour cela il faut aller dans les fichiers de configuration de Raspap:



Une fois dans le fichier de configuration, changer la ligne comme ci-dessous (avant / après )

>Avant

```shell
define('RASPI_OPENVPN_ENABLED', false );
```

<br>

>Après

```shell
define('RASPI_OPENVPN_ENABLED', true );
```
<br>


