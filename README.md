# Script-Injection-de-Commande
Script qui permet de trouver le contenu du fichier /.flag du CTF "Injection de commande 3".

Le challenge nous propose de saisir une adresse IP sur une interface web pour faire un ping.  
Il est possible d'injecter des commandes linux dans cette interface après avoir saisi une adresse IP.  
Seuls les messages "La machine est injoignable" et "La machine est joignable" sont affichés en résultat.  
Si le ping renvoie "seq=0", l'interface affichera "La machine est joignable".  
Le contennu du flag est au format "Flag{...}" et se trouve à la racine dans "/.flag"

L'interface nous propose de saisir une adresse IP  \
<img width="445" height="211" alt="ping_réussi" src="https://github.com/user-attachments/assets/f33bbf8c-68ba-402a-a3f0-907f496735e1" />  \
On peut voir qu'injecter des commandes ne renvoie aucun résultat.  \
<img width="445" height="211" alt="ping_réussi_commande" src="https://github.com/user-attachments/assets/805b76bc-1e26-4b14-9e34-53879f4a678a" />  \
Si nous saisissons une mauvaise adresse IP, le programme met 10 secondes avant de renvoyer un échec.  \
<img width="445" height="211" alt="ping_échoué_127.0.0" src="https://github.com/user-attachments/assets/4eece5db-7860-40a9-8f83-4c0d1f674814" />  \
On nous indique dans le code backend que lorsque le code détecte "seq=0",  \
Celui ci affiche "La machine est joignable", meme si le ping échoue.  \
<img width="447" height="217" alt="ping_réussi_127.0.0" src="https://github.com/user-attachments/assets/a52c38e1-a982-4ed3-b2c2-f4f61111c4a9" />


