#Imane Ourraoui 18316  
#2023 
# Application mobile DressForU


DressForU est une application mobile conçue pour gérer et présenter une collection de robes. Elle permet aux utilisateurs de voir les détails des robes, de mettre à jour les informations sur les robes et de supprimer des robes de la collection.

## Caractéristiques

- Afficher les détails de la robe:** Les utilisateurs peuvent afficher les détails d'une robe spécifique, y compris son nom, son prix, sa matière et sa taille.

- Mettre à jour la robe:** Les utilisateurs peuvent modifier les informations relatives à la robe, telles que son nom, son prix, sa matière et sa taille.

- Supprimer une robe:** Les utilisateurs peuvent supprimer des robes .

## Technologies utilisées

- Flutter : Une boîte à outils d'interface utilisateur pour la construction d'applications compilées nativement pour le mobile, le web et le bureau à partir d'une base de code unique.

- Paquets HTTP : Utilisé pour effectuer des requêtes HTTP à l'API afin de récupérer et de mettre à jour les données de la robe.

## Point d'arrivée de l'API

L'application communique avec l'API DressForU pour récupérer et mettre à jour les données relatives aux robes. Le point de terminaison de l'API pour les détails de la robe est `http://pat.infolab.ecam.be:60848/dress/{dressId}`.

## Getting Started
1. Clonez ce dépôt sur votre machine locale à l'aide de la commande suivante :
git clone https://github.com/imane316/DressForU.git

2. Naviguez jusqu'au répertoire du projet :
cd DressForU

3. Installez les dépendances nécessaires à l'aide de Flutter :
flutter pub get

4. Exécutez l'application sur un émulateur ou un appareil physique :
flutter run