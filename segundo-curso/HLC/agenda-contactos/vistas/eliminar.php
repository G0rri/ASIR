<?php
// Incluir el archivo de funciones
require '../funciones.php';

// Definir la ruta al archivo de datos
$archivoDatos = '../data/contactos.json';
$directorioImagenes = '../uploads/';

// Verifica si se recibió un ID como parámetro en la URL
if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit;
}

$id = $_GET['id'];
$contactos = leerContactos($archivoDatos);

// Busca el contacto por ID
$contacto = null;
foreach ($contactos as $index => $item) {
    if ($item['id'] === $id) {
        $contacto = $item;
        $posicion = $index;
        break;
    }
}

// Si no se encuentra el contacto, redirige al índice
if (!$contacto) {
    header("Location: index.php");
    exit;
}

// Si se confirmó la eliminación
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Elimina la imagen asociada si existe
    if (!empty($contacto['imagen'])) {
        eliminarImagen($directorioImagenes, $contacto['imagen']);
    }
    // Elimina el contacto del array
    array_splice($contactos, $posicion, 1);
    guardarContactos($archivoDatos, $contactos);

    // Redirige al índice después de eliminar
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Eliminar Contacto</title>
        <link rel="stylesheet" href="../style_center.css">
    </head>
    <body>
        <div class='circle xxlarge shade1'></div>
        <div class='circle xlarge shade2'></div>
        <div class='circle large shade3'></div>
        <div class='circle mediun shade4'></div>
        <div class='circle small shade5'></div>
        </div>
        <header>
                <!-- Título de la página -->
                <h1>Eliminar Contacto</h1>
                <nav>
                    <!-- Botones de navegación -->
                    <a href="agregar.php" class="button">Agregar Contacto</a>
                    <a href="galeria.php" class="button button-secondary">Galería de Imágenes</a>
                </nav>
        </header>
        <main>
            <!-- Formulario para eliminar un contacto -->
            <form action="" method="post">
                <p>¿Estás seguro de eliminar el contacto <strong><?= htmlspecialchars($contacto['nombre']) ?></strong>?</p>
                <div class="form-buttons">
                    <button type="submit" name="eliminar" class="button button-delete">Eliminar</button>
                    <a href="index.php" class="button button-secondary">Cancelar</a>
                </div>
            </form>
        </main>
    </body>
</html>
