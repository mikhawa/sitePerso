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
### Création du virtualhost
On le fera pointer vers le dossier public de notre projet:

![alt text](https://raw.githubusercontent.com/mikhawa/sitePerso/master/datas/screenshot-localhost_8080-2020.04.16-13_06_17.png " virtualhost")     

ce qui donne (chez moi) : http://siteperso:8080/ vers le dossier public, et donc vers le contrôleur frontal


### Création de notre premier modèle

Nous allons créé notre premier modèle, MyPDO, qui est une classe enfant de la classe native PDO

    model/MyPDO.php
    ...
    class MyPDO extends PDO
    {
    
        // constructeur de MyPDO (appelé lors d'un new MyPDO())
        public function __construct($dsn, $username = null, $passwd = null, $options = null, $product = null)
        {
            // on copie le constructeur de PDO (le parent)
            parent::__construct($dsn, $username, $passwd, $options);
    
            // et on si la constante MODE passée à $product venant de config.php vaut "dev" 
            // (mode développement) -> Surcharge du constructeur
            if ($product === "dev") {
                // affichage des erreurs SQL uniquement en développement
                $this->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
            }
        }
    }
Ce fichier n'est pas encore appelé par notre contrôleur frontal    

### Création de l'autoload
Cet autoload "maison", va chercher une classe inconnue appelée dans notre code dans le dossier model/..nomdeclasse.php

Nous allons ajouter ce chargeur dans le contrôleur frontal:

    public/index.php
    ...
    /*
     * autoload pour nos modèles, si un nom de classe
      n'existe pas, il va chercher automatiquement le nom de
      la classe transformée en fichier .php (nom de la
      classe == nom du fichier !), cela permet de charger
      les fichiers que lorsque c'est nécessaire
     */
     
    spl_autoload_register(function ($class) {
        require '../model/' . $class . '.php';
    });
    
### Connexion à la DB grâce à MyPDO
On utilise un try catch pour gérer les erreurs et on appelle grâce à notre autoload la class MyPDO se trouvant dans model/MyPDO.php

    public/index.php
    ...
    // essai de connexion try
    try {
        /* $db_connect contient la connexion, on passe la 
        constante MODE pour afficher ou non les erreurs SQL
         suivant qu'on soit en dev ou en prod */
        $db_connect = new MyPDO('mysql:host=' . DB_HOST . ';dbname=' 
        . DB_NAME . ';port=' . DB_PORT . ';charset=' . DB_CHARSET,
            DB_LOGIN,
            DB_PWD,
            null,
            MODE);
    // si il y a une erreur on la capture dans $e
    } catch (PDOException $e) {
        // on affiche nos problèmes de connexion
        echo 'Message d\'erreur : ' . $e->getMessage();
        echo '<br>';
        echo 'Code d\'erreur : ' . $e->getCode();
        // on arrête le script
        die();
    } 
On devrait avoir une erreur ici, vu que le nom de la DB est fausse dans config.php

    Message d'erreur : SQLSTATE[HY000] [1049] Base 'michaeldbpitz' inconnue
    Code d'erreur : 1049
On va donc corriger la valeur dans config.php et config.php.exemple !

    define("DB_NAME","michadbpitz");
Nous devrions avoir une page vide: tout va bien !

### Mapping des tables
Nous allons transformer chaque table de la base de données (sauf les tables créées pour les many to many) en class dans notre dossier model

Je vais décomposer le premier mapping (transformation de nos tables en objets): droit

### droit.php

    model/droit.php
    ...
    class droit
    {
    
    }
Nous créons donc un fichier qui porte le même nom que la classe qu'il contient (voir l'autoload). La déclaration d'une classe se faita avec le mot clef: class. Contrairement aux fonctions, il n'y a pas de () avant les {}

Création des attributs

    model/droit.php
    ...
    class droit
    {
        /* attributs, parfois nommés propriétés
           ce sont nos variables de la classe,
           dans notre cas ils vont reprénsenter les
           champs de notre base de donnée. Nous
           leurs donneront les mêmes noms.
           Ils seront mis en visibilité private, ils ne
           peuvent être lu qu'à l'intérieur de cette
           classe
        */
        private $iddroit;
        private $droitname;
        private $droitdesc;
    
    }

Nous n'avons pas besoin de constantes de classe dans ce fichier.

Création du constructeur qui sera appelée lors de son instanciation ($a = new droit())


    model.droit.php
    ...
    /*
         * Les constantes se trouveront ici,
         * elles ne sont pas nécessaires
         * lors d'un mapping d'une table
         */
    
        /*
         * Les méthodes, ce sont les fonctions appartenant à la classe
         */
    
        // Les constructeurs sont toujours public et 
        // appelés de l'extérieur lorsque l'on fait un "new droit()"
    
        public function __construct()
        {
    
        }

Création des getters et setters (mutators), ce sont les méthodes permettant de manipuler, modifier et supprimer nos attributs. Elles sont publiques on peut les utiliser hors de la classe. Cette première version n'est pas encore "parfaitement"' optimisée pour notre table. Vous remarquerez qu'ils portent le même nom que les attributs avec get ou set devant le nom mis en majuscule.

Exemple : $iddroit donne getIddroit() et setIddroit() 

      model/droit.php
      ...
      /* Les méthodes de type getters (récupère une valeur) et les setters (change une valeur)
          permettent de changer/récupérer les attributs avec un contôle sur les données
          on peut les mettre en publique car nos attributs sont privés
          */
      
          // on récupère l'id, si il est un integer
          public function getIddroit(): int
          {
              return $this->iddroit;
          }
      
          // on introduit un id, si il est un integer,
          // void exprime qu'il n'y a pas de retour (procédure)
          public function setIddroit(int $iddroit): void
          {
              $this->iddroit = $iddroit;
          }
      
          // on récupère le nom, il doit être un string
          public function getDroitname(): string
          {
              return $this->droitname;
          }
      
          // on introduit un nom, il doit être un string,
          // void exprime qu'il n'y a pas de retour (procédure)
          public function setDroitname(string $droitname): void
          {
              $this->droitname = $droitname;
          }
      
          // on récupère la description, elle doit être un string
          public function getDroitdesc(): string
          {
              return $this->droitdesc;
          }
      
          // on introduit la description, elle d oit être un string
          // void exprime qu'il n'y a pas de retour (procédure)
          public function setDroitdesc(string $droitdesc): void
          {
              $this->droitdesc = $droitdesc;
          }      
#### Les modifications de sécurités se font dans les setters !         
##### Modification de setIddroit()
Pour qu'il colle avec les besoins de notre table, j'utilise une condition ternaire.

    model/droit.php
    ...
    public function setIddroit(int $iddroit): void
        {
            // si int vaut 0 (après échec de conversion) OU est négatif
            // (ne colle pas avec unsigned), la variable vaut NULL, sinon
            // elle vaut le paramètre passé
            $this->iddroit = (empty($iddroit)||$iddroit<0)? NULL : $iddroit;
        }         
##### Modification de setDroitname()
On accepte les chaînes de caractères de moins de 60 caractères encodées en entités html sans espaces avant/après et sans tags. Si le texte est trop long, on met la valeur à NULL, ce qu'interdit SQL dans notre champs (NN -> Not Null)

    public function setDroitname(string $droitname): void
        {
            // on va éviter les attaques en préparant
            // l'insertion probable dans une base de donnée
            $this->droitname = htmlspecialchars(strip_tags(trim($droitname)),ENT_QUOTES);
            // si le nom du droit converti à plus de 60
            // caractères (voir ce champs dans la table),
            // on refuse de changer la valeur
            $this->droitname = (strlen($this->droitname)>60)? NULL : $this->droitname;
        }
! on pourrait désencoder les entités html dans le getDroitname(), mais c'est généralement pas nécessaire.          
##### Modification de setDroitdesc()
identique que le précendent sauf que le champs peut être NULL, si ça dépasse les 300 caractères je laisserai SQL m'envoyer l'erreur TOO LONG

    public function setDroitdesc(string $droitdesc): void
        {
            // ce champs peut être null, on va juste protégér contre les tags, espaces et entités html
            // si il dépasse les 300 caractères, on aura donc une erreur SQL en innodb, je ne le traîte pas
            // comme setDroitname(), c'est un choix dans le gestion des erreurs
            $this->droitdesc = htmlspecialchars(strip_tags(trim($droitdesc)),ENT_QUOTES);
    
        }
#### L'hydratation
Hydrater un objet revient à assigner des valeurs à ses attributs en utilisant les setters

On va créer une méthode (fonction) hydrate() qui, une fois mise dans le constructeur, nous servira à gérer les données de manière automatique et sécurisées.       

Pour en savoir plus je vous conseil fortement la lecture de cette partie du tuto (excellent pour l'OO en PHP): https://openclassrooms.com/fr/courses/1665806-programmez-en-oriente-objet-en-php/1666289-manipulation-de-donnees-stockees

    model/droit.php
    ....
    // Méthode privée d'hydratation (procédure)
        private function hydrate(array $data): void
        {
            foreach ($data as $key => $value)
            {
                // On récupère le nom du setter correspondant à l'attribut.
                $method = 'set'.ucfirst($key);
    
                // Si le setter correspondant existe.
                if (method_exists($this, $method))
                {
                    // On attribue la valeur gâce au setter.
                    $this->$method($value);
                }
            }
        }
Cette méthode s'attend à recevoir un tableau associatif        
        