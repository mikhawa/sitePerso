<?php

// mapping de la table commentaire
class commentaire
{
    /*
     * Attributs
     */
    private $idcommentaire;
    private $commenttitre;
    private $commenttext;
    private $commentdate;
    private $actif;

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

    public function getIdcommentaire(): int
    {
        return $this->idcommentaire;
    }

    public function setIdcommentaire(int $idcommentaire): void
    {
        $this->idcommentaire = $idcommentaire;
    }

    public function getCommenttitre(): string
    {
        return $this->commenttitre;
    }

    public function setCommenttitre(string $commenttitre): void
    {
        $this->commenttitre = $commenttitre;
    }

    public function getCommenttext(): string
    {
        return $this->commenttext;
    }

    public function setCommenttext(string $commenttext): void
    {
        $this->commenttext = $commenttext;
    }

    public function getCommentdate(): string
    {
        return $this->commentdate;
    }

    public function setCommentdate(string $commentdate): void
    {
        $this->commentdate = $commentdate;
    }

    public function getActif(): int
    {
        return $this->actif;
    }

    public function setActif(int $actif): void
    {
        $this->actif = $actif;
    }


}