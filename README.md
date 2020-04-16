# sitePerso
Un site personnel en MVC orienté objet fait main, avec objectif de montrer comment commencer un site PHP/MySQL sans framework aux Web-développeurs du CF2m 2020 
### Après la création du projet sur github
Ayant choisi une LICENCE et un fichier README.md, je clone mon projet en local:

    git clone {URL}/sitePerso.git
### Je crée un projet
Je vais utiliser PHPStorm

Je modifie le README.md et je le renvoie:

    # ajout du README.md
    git add README.md
    
    # Sauvegarde de notre travail
    git commit -m"update README.md"
    
    # On envoie le commit sur github, le -u permet de ne plus
    # envoyer notre master avec 'git push' à l'avenir
    git push -u origin master

### création .gitignore
Pour éviter d'envoyer des fichiers dangereux ou inutiles sur le serveur (dans mon cas le dossier .idea/ généré par PHPStorm)

.gitignore


    # PHPStorm
    /.idea
### prévision minimale des fichiers à ajouter au .gitignore
.gitignore

    # PHPStorm
    /.idea 
       
    # mon fichier de configuration  
    config.php
    
    # mes futures bibilothèques externes   
    /vendor

Le future dossier datas devrait aussi être mis dans le .gitignore, mais ça ne vous permettrait pas de consulter mon cheminement    

### Création de la DB en Workbench
dans le dossier datas

Affichage de l'évolution de la création des tables en .png, 1 commit par table

#### Création table "utilisateur"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/01-creation-table-utilisateur.png " 01")
#### Création table "droit"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/02-creation-table-droit.png " 02")
#### Création relation Many to One entre "utilisateur" et "droit"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/03-Relation-Many2One-utilisateur-droit.png " 03")
#### Création table "thepage"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/04-creation-table-thepage.png " 04")
#### Création relation One to Many entre "utilisateur" et "thepage"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/05-Relation-One2Many-utilisateur-thepage.png " 05")
#### Création table "rubrique"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/06-creation-table-rubrique.png " 06")
#### Création relation Many to Many entre "thepage" et "rubrique"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/07-Relation-Many2Many-thepage-rubrique.png " 07")
#### Création table "commentaire"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/08-creation-table-commentaire.png " 08")
#### Création relation Many to Many entre "commentaire" et "utilisateur"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/09-Relation-Many2Many-commentaire-utilisateur.png " 09")
#### Création relation Many to Many entre "commentaire" et "thepage"
![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/10-Relation-Many2Many-commentaire-thepage.png " 10")
#### Modification de "rubrique" 
0 : racine du site
                                
autre numérique: id du parent de la rubrique

![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/11-Modification-de-rubrique-pour-plusieurs-niveau-de-menu.png " 11")

#### Création de la table "fichier"
Qui contiendra n'importe quel type de fichiers uploadés sur le site, que ce soit des images, des pdf, etc....

![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/12-creation-table-fichier.png " 12")

#### 3 relations Many to many entre fichier et les tables 
- commentaire
- utilisateur
- thepage

![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/13-Relation-m2m-fichier-thepage-fichier-commentaire-fichier-utilisateur.png " 13")

### Importation de la DB v1

Importez datas/export-michadbpitz-structure-v1.sql via PHPMyAdmin en désactivant les clefs étrangères (Foreign Keys) 

## Structure MVC
MVC est un design pattern (patron de conception) qui permet de diviser en 3 grands groupes (3 modules aux responsablilités différentes) notre code de l'application web:
1. Un modèle (Model) contient les données à afficher.
2. Une vue (View) contient la présentation de l'interface graphique.
3. Un contrôleur (Controller) contient la logique concernant les actions effectuées par l'utilisateur.

Utilisation (simplifiée)

![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/mvc.png " mvc")

### Création du dossier model
Dans ce dossier on trouvera les fichiers qui gèrent les données, les mappings des tables de la DB, leurs manageurs etc...

### Création du dossier view
Dans ce dossier on trouvera les templates nécessaires à l'affichage des vues de notre site.

J'utiliserai le moteur de template Twig, créé à la base pour Symfony, mais pouvant être utilisé indépendament du framework.

https://twig.symfony.com/

Sa gestion du cache et son mode d'héritage est parfait pour un affichage optimal des vues.

### Création du dossier controller
Dans ce dossier on trouvera les fichiers qui gèrent les routes et font le lien (en dehors du contrôleur frontal se trouvant dans public/index.php) entre les model et les view

### Création du fichier config.php
Nous le metterons à la racine du site, bien qu'un dossier pourrait être créé si nous avions beaucoup de fichiers de configuration

Avant de le créer nous allons vérifier qu'il est dans .gitignore pour éviter son envoi sur github.

Je crée une copie de config.php avec le nom

    config.php.exemple
Je pourrai y laisser la configuration en local, quand je modifierai config.php avec les "vrais" paramètres, ils ne seront donc jamais sur github !! Sécurité avant tout !  

#### Renommez config.php.exemple en config.php pour que ça fonctionne en local chez vous !  

### Création du contrôleur frontal
dans public sous le nom de index.php

    public/index.php

#### Appel des dépendances
Pour le moment, nous n'avons que config.php

    public/index.php
    ...
    // fichier de configuration
    require_once "../config.php";  
      