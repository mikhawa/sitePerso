<?php
/*
 * Ceci est notre Contrôleur Frontal, toutes les requêtes entrantes comme sortantes passent par ce fichier (sécurité)
 */

/*
 * Appel de nos dépendances
 */

// fichier de configuration
require_once "../config.php";

/*
 * autoload pour nos modèles, si un nom de classe n'existe pas, il va chercher automatiquement le nom de la classe transformée en fichier .php (nom de la classe == nom du fichier !), cela permet de charger les fichiers que lorsque c'est nécessaire
 */
spl_autoload_register(function ($class) {
    require '../model/' . $class . '.php';
});


/*
 * créons une connexion PDO avec son enfant MyPDO (appelé grâce à l'autoload)
 */

// essai de connexion try
try {
    // $db_connect contient la connexion, on passe la constante MODE pour afficher ou non les erreurs SQL suivant qu'on soit en dev ou en prod
    $db_connect = new MyPDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';port=' . DB_PORT . ';charset=' . DB_CHARSET,
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
