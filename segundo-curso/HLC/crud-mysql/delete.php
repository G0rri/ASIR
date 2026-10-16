<?php
// delete.php
include 'db.php';

$id = $_GET['id'];
$sql = "DELETE FROM contacts WHERE id=$id";

if ($conn->query($sql) === TRUE) {
    header("Location: index.php");
    exit();
} else {
    echo "Error al eliminar: " . $conn->error;
}
?>
