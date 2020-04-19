<?php

// mapping de la table rubrique
class rubrique
{
    /*
     * Attributs
     */
    private $idrubrique;
    private $rubriqueslug;
    private $rubriquetitre;
    private $rubriquedesc;
    private $rubriqueordre;

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


    public function getIdrubrique(): int
    {
        return $this->idrubrique;
    }

    public function setIdrubrique(int $idrubrique): void
    {
        $this->idrubrique = $idrubrique;
    }

    public function getRubriqueslug(): string
    {
        return $this->rubriqueslug;
    }

    public function setRubriqueslug(string $rubriqueslug): void
    {
        $this->rubriqueslug = $rubriqueslug;
    }

    public function getRubriquetitre(): string
    {
        return $this->rubriquetitre;
    }

    public function setRubriquetitre(string $rubriquetitre): void
    {
        $this->rubriquetitre = $rubriquetitre;
    }

    public function getRubriquedesc(): string
    {
        return $this->rubriquedesc;
    }

    public function setRubriquedesc(string $rubriquedesc): void
    {
        $this->rubriquedesc = $rubriquedesc;
    }

    public function getRubriqueordre(): int
    {
        return $this->rubriqueordre;
    }

    public function setRubriqueordre(int $rubriqueordre): void
    {
        $this->rubriqueordre = $rubriqueordre;
    }


}