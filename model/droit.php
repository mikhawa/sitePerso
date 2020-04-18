<?php

// mapping de la table "droit"
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

    /*
     * Les constantes se trouveront ici,
     * elles ne sont pas nécessaires
     * lors d'un mapping d'une table
     */

    /*
     * Les méthodes, ce sont les fonctions appartenant à la classe
     */

    // Les constructeurs sont toujours public et appelés de l'extérieur lorsque l'on fait un "new droit()"

    public function __construct()
    {

    }


}