Mettre en place une règle de routage
--

Pour mettre en place une règle de routage sur notre serveur, il suffit de lui rajouter la route à son interface.

```shell
ip route add IP.DU.RESEAU.X/24 dev Interface
```



![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/Installation-serveur/Routage/2019-05-16%2011_01_48-Invite%20de%20commandes.png)

```shell
1er Ping (avant routage)
Ping 192.168.0.254 
Echec
La communication entre les deux réseaux ne passent pas via les interfaces de notre serveur.
```
```shell
2ème Ping (après routage)
Ping 192.168.0.254 
Réussite
La communication entre les deux réseaux passent via les interfaces de notre serveur car le routage est effectif.
```


![alt text](https://github.com/Eixa6Info/eixa6_vpn/blob/master/Installation-serveur/Routage/2019-05-16-105443_1920x1080_scrot.png)
>Règle de routage créer sur notre serveur.
