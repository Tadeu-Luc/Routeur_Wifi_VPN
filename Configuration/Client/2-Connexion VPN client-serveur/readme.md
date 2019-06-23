Installation OpenVPN 
-
Pour pouvoir utiliser la connexion à notre serveur, nous allons devoir installer OpenVPN qui ferra office de point de connexion (via l'interface TUN qui sera connecté dessus).

```shell
apt-get install openvpn
```

Transfert de fichier de configuration
-

Nous allons après cela devoir transferer notre fichier de configuration créer par notre serveur sur le client pour que l'interface TUN sache à qui elle doit se connecter ainsi que les protocoles de transport qu'elle devra prendre en compte (UDP ou TCP), dans notre cas le TCP restera la meilleure solution, car il permet une liasion qui redemandera les informations si elles ont perdu (exemple: le tcp permettra une meilleure utilisation pour les transferts de fichiers ou lors de l'impression car si un paquet est perdu le protocole le renverra contrairement à l'UDP).

![alt text](https://github.com/Tadeu-Luc/Routeur_Wifi_VPN/blob/master/Configuration/Client/2-Connexion%20VPN%20client-serveur/PROTO.jpeg)
>différence TCP et UDP

Utilisez pour cela une clé USB pour chercher votre fichier de configuration sur votre serveur (essayer de ne pas utiliser le réseau pour l'envoi des fichiers de configuration sinon l'opération de sécurisé le VPN n'aura servi à rien).

```shell
cp /etc/openvpn/votrefichier.conf /Media/pi/votrecléusb
```
ou si votre fichier de configuration client est avec l'extension .conf
```shell
cp /etc/openvpn/votrefichier.ovpn /Media/pi/votrecléusb
```



Après cela le mettre dans votre fichier OpenVPN de votre client

```shell
cp /Media/pi/votrecléusb/votrefichier.ovpn /etc/openvpn/
```
Mise en place de l'autorun du fichier de configuration de openvpn
--

Pour la mise en place du démarrage automatique sur le fichier de configuration, il faudra si vous avez utilisé un fichier en .ovpn (classiquement ceux demandés par les autres systèmes d'exploitation tels que Windows ou Android et ceux crées par PIVPN) les transformées en .conf (car le fichier qui l'ouvre au démarrage /etc/default/openvpn ne permet que l'utilisation en .conf).

```shell
nano /etc/openvpn/Fabien.conf
```
Dans ce fichier, il faudra rajouter la ligne : auth-users pass /etc/openvpn/motdepasse.txt pour que lors de la connexion le fichier de configuration sache vers quels fichiers utliser pour s'authentifier.
  
Il faudra alors créer le fichier pour que le script sache où se situe le login / mots de passe.

```shell
nano /etc/openvpn/Fabien.conf
```
Dedans, tapez l'utilisateur en première ligne et le mot de passe en deuxième ligne:
```shell
nomd'utilisateur //1ere ligne du fichier

motsdepasse // 2eme ligne du fichier
```

