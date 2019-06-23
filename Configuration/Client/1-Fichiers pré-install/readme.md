Avant la création du routeur nous allons stocker, le fichier de configuration du wifi pour pouvoir le restituer au cas où nous voudrions le remettre.
-----
```shell
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.sav 
```
>Le point sav ne sert que pour être enlever en cas de problème ou de retour en arrière


Création d"un dossier pour que le script raspap puisse écrire dessus ensuite.
-----

```shell
sudo cp /dev/null /etc/wpa_supplicant/wpa_supplicant.conf
```
>null est un fichier vide qui permettra la copie du script de Raspap dedans

