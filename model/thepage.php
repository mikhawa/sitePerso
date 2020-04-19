<?php

// mapping de la table thepage
class thepage
{
    /*
     * Attributs
     */
    private $idthepage;
    private $theslug;
    private $thetitle;
    private $thetext;
    private $thedate;
    private $actif;
    private $utilisateur_idutilisateur;

    /*
     * Méthodes
     */

    // Constructeur
    public function __construct(array $donnees)
    {
        $this->hydrate($donnees);
    }

    // Méthode privée d'hydratation
    private function hydrate(array $data): void
    {
        foreach ($data as $key => $value)
        {
            $method = 'set'.ucfirst($key);
            if (method_exists($this, $method))
            {
                $this->$method($value);
            }
        }
    }

    /*
    * Mutators - Getters and Setters
    */

    public function getIdthepage(): int
    {
        return $this->idthepage;
    }

    public function setIdthepage(int $idthepage): void
    {
        $this->idthepage = $idthepage;
    }

    public function getTheslug(): string
    {
        return $this->theslug;
    }

    public function setTheslug(string $theslug): void
    {
        $this->theslug = $theslug;
    }

    public function getThetitle(): string
    {
        return $this->thetitle;
    }

    public function setThetitle(string $thetitle): void
    {
        $this->thetitle = $thetitle;
    }

    public function getThetext(): string
    {
        return $this->thetext;
    }

    public function setThetext(string $thetext): void
    {
        $this->thetext = $thetext;
    }

    public function getThedate(): string
    {
        return $this->thedate;
    }

    public function setThedate(string $thedate): void
    {
        $this->thedate = $thedate;
    }

    public function getActif(): int
    {
        return $this->actif;
    }

    public function setActif(int $actif): void
    {
        $this->actif = $actif;
    }

    public function getUtilisateurIdutilisateur(): int
    {
        return $this->utilisateur_idutilisateur;
    }

    public function setUtilisateurIdutilisateur(int $utilisateur_idutilisateur): void
    {
        $this->utilisateur_idutilisateur = $utilisateur_idutilisateur;
    }

}