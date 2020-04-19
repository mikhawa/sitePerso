<?php

// mapping de la table utilisateur
class utilisateur
{
    /*
     * Attributs
     */
    private $idutilisateur;
    private $thelogin;
    private $thepwd;
    private $thename;
    private $thesurname;
    private $themail;
    private $thedateinscription;
    private $theprivatekey;
    private $actif;
    private $droit_iddroit;

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
    public function getIdutilisateur(): int
    {
        return $this->idutilisateur;
    }

    public function setIdutilisateur(int $idutilisateur): void
    {
        $this->idutilisateur = $idutilisateur;
    }

    public function getThelogin(): string
    {
        return $this->thelogin;
    }

    public function setThelogin(string $thelogin): void
    {
        $this->thelogin = $thelogin;
    }

    public function getThepwd(): string
    {
        return $this->thepwd;
    }

    public function setThepwd(string $thepwd): void
    {
        $this->thepwd = $thepwd;
    }

    public function getThename(): string
    {
        return $this->thename;
    }

    public function setThename(string $thename): void
    {
        $this->thename = $thename;
    }

    public function getThesurname(): string
    {
        return $this->thesurname;
    }

    public function setThesurname(string $thesurname): void
    {
        $this->thesurname = $thesurname;
    }

    public function getThemail(): string
    {
        return $this->themail;
    }

    public function setThemail(string $themail): void
    {
        $this->themail = $themail;
    }

    public function getThedateinscription(): string
    {
        return $this->thedateinscription;
    }

    public function setThedateinscription(string $thedateinscription): void
    {
        $this->thedateinscription = $thedateinscription;
    }

    public function getTheprivatekey(): string
    {
        return $this->theprivatekey;
    }

    public function setTheprivatekey(string $theprivatekey): void
    {
        $this->theprivatekey = $theprivatekey;
    }

    public function getActif(): int
    {
        return $this->actif;
    }

    public function setActif(int $actif): void
    {
        $this->actif = $actif;
    }

    public function getDroitIddroit(): int
    {
        return $this->droit_iddroit;
    }

    public function setDroitIddroit(int $droit_iddroit): void
    {
        $this->droit_iddroit = $droit_iddroit;
    }

}