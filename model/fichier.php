<?php

// mapping de la table fichier
class fichier
{
    /*
     * Attributs
     */
    private $idfichier;
    private $fichiername;
    private $fichiertype;
    private $fichierurl;
    private $fichierdate;
    private $fichieractif;

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

    public function getIdfichier(): int
    {
        return $this->idfichier;
    }

    public function setIdfichier(int $idfichier): void
    {
        $this->idfichier = $idfichier;
    }

    public function getFichiername(): string
    {
        return $this->fichiername;
    }

    public function setFichiername(string $fichiername): void
    {
        $this->fichiername = $fichiername;
    }

    public function getFichiertype(): string
    {
        return $this->fichiertype;
    }

    public function setFichiertype(string $fichiertype): void
    {
        $this->fichiertype = $fichiertype;
    }

    public function getFichierurl(): string
    {
        return $this->fichierurl;
    }

    public function setFichierurl(string $fichierurl): void
    {
        $this->fichierurl = $fichierurl;
    }

    public function getFichierdate(): string
    {
        return $this->fichierdate;
    }

    public function setFichierdate(string $fichierdate): void
    {
        $this->fichierdate = $fichierdate;
    }

    public function getFichieractif(): int
    {
        return $this->fichieractif;
    }

    public function setFichieractif(int $fichieractif): void
    {
        $this->fichieractif = $fichieractif;
    }

}