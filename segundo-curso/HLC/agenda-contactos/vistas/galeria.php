<?php
// Incluir el archivo de funciones
require '../funciones.php';

// Definir la ruta al archivo de datos
$archivoDatos = '../data/contactos.json';

// Leer los contactos del archivo de datos
$contactos = leerContactos($archivoDatos);
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Galería de Imágenes</title>
        <!-- Enlace a la hoja de estilos -->
        <link rel="stylesheet" href="../style_center.css">
    </head>
    <body>
        <header>
            <!-- Título de la página -->
            <h1>Galería de Imágenes</h1>
        </header>
        <main>
            <?php if (!empty($contactos)): ?>
                <!-- Contenedor de la galería -->
                <div class="gallery-horizontal">
                    <?php foreach ($contactos as $contacto): ?>
                        <?php if (!empty($contacto['imagen'])): ?>
                            <!-- Elemento de la galería -->
                            <div class="gallery-item">
                                    <!-- Mostrar la imagen del contacto -->
                                    <img src="../uploads/<?= htmlspecialchars($contacto['imagen']) ?>" alt="Foto de <?= htmlspecialchars($contacto['nombre']) ?>">
                                </a>
                                <!-- Mostrar el nombre del contacto -->
                                <p><?= htmlspecialchars($contacto['nombre']) ?></p>
                            </div>
                        <?php endif; ?>
                    <?php endforeach; ?>
                </div>
            <?php else: ?>
                <!-- Mensaje cuando no hay imágenes para mostrar -->
                <p>No hay imágenes para mostrar en la galería.</p>
            <?php endif; ?>
            <nav>
            <!-- Botón de navegación para volver al listado -->
            <a href="index.php" class="button">Volver al Listado</a>
        </nav>
        </main>
        
        <footer>
            <!-- Contenido del pie de página -->
            <p>© 2025 Agenda de Contactos. Todos los derechos reservados.</p>
        </footer>
    </body>
</html>
