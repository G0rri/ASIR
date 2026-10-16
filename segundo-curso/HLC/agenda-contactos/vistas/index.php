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
        <title>Agenda de Contactos</title>
        <!-- Enlace a la hoja de estilos -->
        <link rel="stylesheet" href="../stilos.css">
    </head>
    <body>
        <header>
            <!-- Título de la página -->
            <h1>Agenda de Contactos</h1>
            <nav>
                <!-- Botones de navegación -->
                <a href="agregar.php" class="button">Agregar Contacto</a>
                <a href="galeria.php" class="button button-secondary">Galería de Imágenes</a>
            </nav>
        </header>

        <main>
            <!-- Tabla de contactos -->
            <table>
                <thead>
                    <tr>
                        <th>Foto</th>
                        <th>Nombre</th>
                        <th>Teléfono</th>
                        <th>Email</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($contactos as $contacto): ?>
                        <tr>
                            <td>
                                <?php if (!empty($contacto['imagen'])): ?>
                                    <!-- Mostrar la imagen del contacto -->
                                    <img src="../uploads/<?= htmlspecialchars($contacto['imagen']) ?>" alt="Foto de <?= htmlspecialchars($contacto['nombre']) ?>" class="thumbnail">
                                <?php else: ?>
                                    <!-- Imagen por defecto si no hay imagen cargada -->
                                    <img src="assets/default-avatar.png" alt="Sin imagen" class="thumbnail">
                                <?php endif; ?>
                            </td>
                            <td><?= htmlspecialchars($contacto['nombre']) ?></td>
                            <td><?= htmlspecialchars($contacto['telefono']) ?></td>
                            <td><?= htmlspecialchars($contacto['email']) ?></td>
                            <td>
                                <!-- Botones para editar y eliminar el contacto -->
                                <a href="../vistas/editar.php?id=<?= urlencode($contacto['id']) ?>" class="button button-edit">Editar</a>
                                <a href="../vistas/eliminar.php?id=<?= urlencode($contacto['id']) ?>" class="button button-delete">Eliminar</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </main>
        <footer>
            <!-- Contenido del pie de página -->
            <p>© 2025 Agenda de Contactos. Todos los derechos reservados.</p>
        </footer>
    </body>
</html>
