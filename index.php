<?php
$dsn = "mysql:host=localhost;dbname=sts_todolist";
$user = "root";
$password = "";

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

try {
    $conn = new PDO($dsn, $user, $password, [
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch(PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}

$route = htmlentities($_GET['q']);
if ($_SERVER['REQUEST_METHOD'] === 'GET') {

    if (isset($_GET['id'])) {
        $id = (int)$_GET['id'];
    }

    switch ($route) {
        case 'lesListes':
            $sql = "SELECT * FROM liste";
            $options = [];
        break;

        case 'lesTaches':
            $sql = "SELECT * FROM tache WHERE ref_liste = :ref_liste";
            $options = ['ref_liste' => $id];
        break;

        case 'laTache':
            $sql = "SELECT * FROM tache WHERE id_tache = :idLaTache";
            $options = ['idLaTache' => $id];
        break;

        case 'laListe':
            $sql = "SELECT * FROM liste WHERE id_liste = :idLaListe";
            $options = ['idLaListe' => $id];
        break;
    }

    $statement = $conn->prepare($sql);
    $statement->execute($options);
    $lists = $statement->fetchAll();
    $conn = null;
    echo json_encode($lists);
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    switch ($route) {
        case 'creerListe':
            $nom = htmlentities($_POST['nom']);
            $description = htmlentities($_POST['description']);
            $sql = "INSERT INTO liste (nom, description) VALUES (:nom, :description)";
            $options = ['nom' => $nom, 'description' => $description];
        break;

        case 'modifierListe':
            $id = (int)$_POST['idListe'];
            $nom = htmlentities($_POST['nom']);
            $description = htmlentities($_POST['description']);
            $sql = "UPDATE liste SET nom = :nom, description = :description WHERE id_liste = :id";
            $options = ['id' => $id, 'nom' => $nom, 'description' => $description];
        break;

        case 'supprimerListe':
            $id = (int)$_POST['idListe'];
            $sql = "DELETE FROM  liste WHERE id_liste = :id";
            $options = ['id' => $id];
        break;

        case 'creerTache':
            $nom = htmlentities($_POST['nom']);
            $description = htmlentities($_POST['description']);
            $niveau = (int)$_POST['niveau'];
            $idListe = (int)$_POST['idList'];

            $sql = "INSERT INTO tache (nom, description, niveau, ref_liste, ref_type) VALUES (:nom, :description, :niveau, :idListe, 5)";
            $options = ['nom' => $nom, 'description' => $description, 'niveau' => $niveau, 'idListe' => $idListe];
        break;

        case 'modifierTache':
            $id = (int)$_POST['idTache'];
            $nom = htmlentities($_POST['nom']);
            $description = htmlentities($_POST['description']);
            $niveau = (int)$_POST['niveau'];
            $sql = "UPDATE tache SET nom = :nom, description = :description, niveau = :niveau WHERE id_tache = :id";
            $options = ['id' => $id, 'nom' => $nom, 'description' => $description, 'niveau' => $niveau];
        break;

        case 'supprimerTache':
            $id = (int)$_POST['idTache'];
            $sql = "DELETE FROM tache WHERE id_tache = :id";
            $options = ['id' => $id];
        break;
    }
    
    $statement = $conn->prepare($sql);
    echo $statement->execute($options);
    $conn = null;
}