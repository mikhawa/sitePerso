<?php
/*
 * Classe de connexion à notre base de donnée basée sur PDO
 * extends fait hériter notre nouvelle classe (class MyPDO) d'une classe déjà existante (PDO)
 */

class MyPDO extends PDO
{

    // constructeur de MyPDO (appelé lors d'un new MyPDO())
    public function __construct($dsn, $username = null, $passwd = null, $options = null, $product = null)
    {
        // on copie le constructeur de PDO (le parent)
        parent::__construct($dsn, $username, $passwd, $options);

        // et on si la constante MODE passée à $product venant de config.php vaut "dev" (mode développement) -> Surcharge du constructeur
        if ($product === "dev") {
            // affichage des erreurs SQL uniquement en développement
            $this->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        }
    }


}