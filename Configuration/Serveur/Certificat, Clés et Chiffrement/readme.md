Création Serveur OpenVPN
---
OpenVPN se basant sur une base SSL à besoin de celui-ci pour fonctionner, vous allez donc vérifier que l'installation de ce paquet est bien présent sur le raspberry (ou alors l'installer) 
```shell
apt-get install openssl
```
<br>


Une fois que Openssl est fonctionnel, il faudra installer openvpn :
```shell
apt-get install openvpn
```
<br>


Ce qu'il reste à faire est de créer le certificat, les fichiers du serveur, client et le chiffrage de ses fichiers
<br>


![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/Cl%C3%A9%20utilit%C3%A9.png)
>Utilités des différents fichiers.
<br>





Certificat Master (ca)
------


Avant de créer notre certificat, vous allez devoir créer un fichier pour contenir les fichiers de création du certificat.
```shell
mkdir /etc/openvpn/easy-rsa/
```

Vous allez copier les dossiers du fichier exemple de easy rsa vers le fichier de votre serveur:
```shell
cp /usr/share/doc/openvpn/examples/easy-rsa/2.0/* /etc/openvpn/easy-rsa/
```
<br>



Allez dans le dossier que vous avez créé:
```shell
cd /usr/share/easy-rsa 
```
<br>



Vous allez maintenant nettoyer le dossier en executant la commande :
```shell
./clean-all
```
<br>



Une fois le nettoyage fait, vous pourrez rentrer la commande:
```shell
./build-ca 
```
<br>


![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/ca.png)
>Vous aurez le choix de remplir ou non les differentes informations (vous pouvez aussi les passer).
<br>
<br>


Création certifcat et clé Serveur
----
Une fois le fichier du certificat master créé, nous allons avoir besoin de créer un certificat et une clé pour notre serveur.

Vous allez maintenant créer via le fichier de script le serveur:
```shell
./build-key-server nom_choisi_pour_le_serveur
```
>Le nom n'a pas d'importance (il faudra juste le signifié quand on vous le demandera). 
<br>

![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/Serveur.png)
>Vous aurez le choix de remplir ou non les differentes informations (vous pouvez aussi les passer).
<br>

Le script se présente comme celui du certificat master a une différence.
<br>


![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/cl%C3%A9%20serveur.png)
>Vous aurez à remplir cette partie avec un mots de passe.
Pour génerer des mots de passes sécurisés:
>https://www.lastpass.com/fr         
>https://www.motdepasse.xyz/       
>https://www.dashlane.com/fr/features/password-generator
<br>

Il faudra que vous autorisiez en validant avec "yes" quand la phrase "Sign the certificate ? " sera proposer.
<br>
<br>

>Comme il est écrit, il faut refaire le certificat tous les 10 ans (le mieux étant de faire toujours une veille sur les problèmes de craquage du hachage (le hachage en SHA-2 reste très sécurisé car il est trop long de trouver un mot de passe codé mais les technologies avance et par exemple un ordinateur quantique n’aura pas ce problème car il peut effectuer 21000 calculs par secondes et le SHA-2 est chiffré en 2256 donc la clé de déchiffrement sera vite retrouvé).

_Informations sur création la clé master et serveur :_

>https://openvpn.net/community-resources/setting-up-your-own-certificate-authority-ca/
<br>
<br>


Création de certificat et clé Client
-----
Le fichier du serveur étant prêt, il faudra créer celui du client.
Entrez cette commande:
```shell
./build-key nom_du_client
```
<br>


Cela vous remettra sur une page similaire que lors de la création serveur, remplissez donc les informations comme sur le fichier du serveur.

Cela vous créera un fichier nommé nom_du_client1.crt et  un autre nommé nom_du_client1.key dans le dossier /etc/opnevpn/easy-rsa/keys.

<br>
<br>
<br>


Chiffrage Algorithme d'échange de clefs de Diffie Hellman
---
Vous allez maintenant chiffrer les informations, pour cela vous allez utiliser un script disponible dans le dossier :

```shell
./build-dh
```
<br>
<br>

Tls-auth (optionnel)
---
Afin de renforcer notre sécurité (protection contre attaque DOS, scanning de port ...) nous allons générer la clef ta (tls-auth)

Vous devrez aller dans le dossiers où vos fichiers ce situe:
```shell
cd keys/
```
<br>
Pour générer la clé ta, tapez la commande :

```shell
openvpn --genkey --secret ta.key
```
<br>


Configuration serveur
-----
Pour configurer le serveur, il va falloir extraire un fichier samples des fichiers installés installer par Openvpn:
```shell
cp /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz /etc/openvpn/
```
Une fois ce fichier extrait, nous allons le modifié pour le faire devenir comme celui-ci
```shell
cd /etc/openvpn
nano server.conf
```
<br>



Le fichier se présente comme cela, modifiez donc les paramètres en focntion de ce que vous voulez
<br>


```shell
#Numéro du port utilisé
port 6542
#Protocole de communication
proto tcp
#Type d'interface (pont ou interface)
dev tun
#Utile pour ne pas avoir de lenteur avec certains clients
sndbuf 0
rcvbuf 0
#Emplacement du certificat master
ca ca.crt
#emplacement du certificat du serveur
cert server.crt
#emplacement de la clé du serveur
key server.key
#Emplacement du fichier de chiffrage Diffie-Hellman
dh dh.pem
auth SHA512
#Utilisation du TLS sur le serveur.
tls-auth ta.key 0
topology subnet
#Plage réseau donnée au serveur VPN avec son masque de sous réseau
server 10.8.0.0 255.255.255.0
#Permet la redirection du flux de données
push "redirect-gateway def1 bypass-dhcp"
#utilisation de différents DNS
push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.220.220"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.8.4"
#temps de vie avant la fermeture des communications
keepalive 10 120
#type de chiffrage des données
cipher AES-256-CBC
#pas d'utilisateur et groupe particuliers pour l'utilisation du VPN
user nobody
group nogroup
#Sert a rendre la connexion persistante
persist-key
persist-tun
#fichier de log
status openvpn-status.log
#niveau de verbosité
verb 3
crl-verify crl.pem
```


Demarrez ensuite le service OpenVPN:
```shell
/etc/init.d/openvpn start
```
<br>



Pour voir que cela a bien fonctionner, tapez dans un autre invite de commande:
```shell
ip a
```
Si vous voyez votre interface Tun, cela veut dire que cela a fonctionné.

<br>
<br>


Configuration client
------

Pour créer notre fichier client, on va avoir besoin de la même mainère que le serveur dasn les samples que Openvpn a pu installer. Tapez donc la commande :
```shell
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/
```
Une fois ce fichier extrait, nous allons le modifié pour le faire devenir comme celui-ci
```shell
cd /etc/openvpn
nano client.conf
```
<br>

On change donc dedans :
<br>
_La certification Master_:
```shell
ca /etc/openvpn/ca.crt
```
<br>



_La certification Serveur_:
```shell
cert /etc/openvpn/server.crt
```
<br>


_La clé de chiffrement serveur_:
```shell
key /etc/openvpn/server.key
```
<br>

Si vous avez fait la phase optionnelle mettez votre TLS dans le fichier de configuration :
<br>
![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/TLS%20AUTHENTIFICATION.png)
>Comme celle-ci dessus.
<br>
<br>




Attention au fichier créer en .ovpn si vous souhaitez executer la commande pour directement vous connecter (auth-user pass) il faut que votre fichier de configuration soit en .conf pour que l'authentification soit prise en compte.
<br>
<br>


Sur votre client, vous devriez avoir ceci lors de vos tests:
<br>
![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/img/OpenVPN/connexion%20client.png)
>Si vous avez "Initialization Sequence Compilation", cela signifie que la connexion est effective (il faut laisser la page ouverte pour que le VPN reste actif).
