<?php


namespace Database\Tabelle;

abstract class TTable {
    protected $pdo = null;
    protected $schema ='';
    protected $tableName = '';

    public function __construct($pdo, $schema, $tableName) {
        $this->pdo = $pdo;
        $this->schema = $schema;
        $this->tableName = $tableName;
    }

    public function creaTabella(string $stmt) {
        try {
            $this->pdo->prepare($stmt)->execute();

        } catch (PDOException $e) {
            die($e->getMessage());
        }
    }

    public function leggiSchema(): string {
        return $this->schema;
    }

    public function leggiNomeTabella(): string {
        return $this->$tableName;
    }

    abstract public function creaRecord(array $incarico): string ;

    abstract public function modificaRecord(array $incarico): bool;

    abstract public function cancellaRecord(string $id): bool;

    abstract public function ricerca(array $daCercare): string;

    public function __destruct() {
        unset($this->pdo);
    }
}