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

// Busca el contacto por su ID
$contacto = null;
foreach ($contactos as $index => $item) {
    if ($item['id'] === $id) {
        $contacto = $item;
        $posicion = $index;
        break;
    }
}

// Si el contacto no existe, redirige al índice
if (!$contacto) {
    header("Location: index.php");
    exit;
}

// Procesa el formulario de edición
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['guardar'])) {
    // Actualiza los datos del contacto
    $contactos[$posicion]['nombre'] = $_POST['nombre'];
    $contactos[$posicion]['telefono'] = $_POST['telefono'];
    $contactos[$posicion]['email'] = $_POST['email'];
    $contactos[$posicion]['password'] = $_POST['password'];

    // Procesa la nueva imagen si se subió una
    if (!empty($_FILES['imagen']['name'])) {
        // Elimina la imagen antigua si existe
        if (!empty($contacto['imagen'])) {
            eliminarImagen($directorioImagenes, $contacto['imagen']);
        }

        // Sube la nueva imagen
        $nuevaImagen = subirImagen($_FILES['imagen'], $directorioImagenes);
        if ($nuevaImagen) {
            $contactos[$posicion]['imagen'] = $nuevaImagen;
        }
    }

    // Guarda los contactos actualizados en el archivo JSON
    guardarContactos($archivoDatos, $contactos);

    // Redirige al índice después de guardar los cambios
    header("Location: index.php");
    exit;
}

// Generar una nueva contraseña
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['generar_password'])) {
    $nuevaPassword = generarPassword();
    $contacto['password'] = $nuevaPassword;
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar Contacto</title>
        <!-- Enlace a la hoja de estilos -->
        <link rel="stylesheet" href="../style_center.css">
    </head>
    <body>
        <header>
            <!-- Título de la página -->
            <h1>Editar Contacto</h1>
        </header>
        <main>
            <!-- Formulario para editar el contacto -->
            <form action="editar.php?id=<?= urlencode($id) ?>" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" value="<?= htmlspecialchars($contacto['nombre']) ?>" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono</label>
                    <input type="tel" id="telefono" name="telefono" value="<?= htmlspecialchars($contacto['telefono']) ?>" required>
                </div>
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" value="<?= htmlspecialchars($contacto['email']) ?>">
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="text" id="password" name="password" value="<?= htmlspecialchars($contacto['password']) ?>">
                    <button type="submit" name="generar_password" class="button">Generar Contraseña</button>
                </div>
                <div class="form-group">
                    <label for="imagen">Imagen Actual</label>
                    <?php if (!empty($contacto['imagen'])): ?>
                        <img src="../uploads/<?= htmlspecialchars($contacto['imagen']) ?>" alt="Imagen de <?= htmlspecialchars($contacto['nombre']) ?>" class="thumbnail">
                    <?php else: ?>
                        <p>No hay imagen cargada.</p>
                    <?php endif; ?>
                    <label for="imagen">Cambiar Imagen</label>
                    <input type="file" id="imagen" name="imagen" accept="image/*">
                </div>
                <button type="submit" name="guardar" class="button">Guardar Cambios</button>
                <a href="eliminar.php?id=<?= urlencode($id) ?>" class="button button-delete">Eliminar Contacto</a>
                <a href="index.php" class="button button-secondary">Cancelar</a>
            </form>
        </main>
        <footer>
            <!-- Contenido del pie de página -->
            <p>© 2025 Agenda de Contactos. Todos los derechos reservados.</p>
        </footer>
    </body>
</html>
