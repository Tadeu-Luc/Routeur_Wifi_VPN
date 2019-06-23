Règles de Pare feu et Routage 
-----
Pour utiliser le VPN, nous allons devoir mettre en place des règles dans le pare-feu pour pouvoir faire passer notre connexion sans être bloqué par celui-ci
      
Nous allons tout d'abord utilisez le service iptables (verifiez que vous possédez ce service sur votre machine)    
      
_Pour vérifier_:
```shell
apt-get install iptables
```
<br>
<br>


Nous allons maintenant faire en sorte que le port 6542 soit accepté en entrée et en sortie via le protocole TCP.
```shell
iptables -t filter -A INPUT -p tcp --dport 6542 -j ACCEPT
```
<br>
<br>

Après cela, nous allons authoriser la translation d'adresses via le nat sur l'interface eth0.
```shell
iptables -t nat POSTROUTING -o eth0 -j MASQUERADE
```

<br>
<br>

il faut ensuite faire en sorte que le réseau de notre vpn soit inscrit pour que la translation soit effective.
```shell
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eh0 -j MASQUERADE
```

<br>
<br>

Une fois tous ces paramètres rentrés, il faut les rendre persistant (faire en sorte que ces paramètres soit disponible après un redémarrage).
```shell
iptables-save > /etc/iptables.rules //pare feu 4
```

<br>

Nous allons pour finir tester les paramètres que nous avons rentrés:

```shell
iptables -L
```
![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/Configuration/Client/4-Routage%2C%20R%C3%A8gle%20de%20filtrage/Test%20Pare%20feu.png)
>Cela devrait vous affichez une table comme celle ci-dessus.




