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