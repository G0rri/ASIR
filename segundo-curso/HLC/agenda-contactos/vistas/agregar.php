<?php
// Incluir el archivo de funciones
require '../funciones.php';

// Definir la ruta al archivo de datos
$archivoDatos = '../data/contactos.json';

// Verificar si el formulario fue enviado
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Leer los contactos del archivo de datos
    $contactos = leerContactos($archivoDatos);

    // Crear un nuevo contacto con los datos del formulario
    $nuevoContacto = [
        'id' => uniqid(),
        'nombre' => $_POST['nombre'],
        'telefono' => $_POST['telefono'],
        'email' => $_POST['email'],
        'imagen' => subirImagen($_FILES['imagen'], '../uploads'),
        'password' => empty($_POST['password']) ? generarPassword() : $_POST['password']
    ];

    // Agregar el nuevo contacto a la lista de contactos
    $contactos[] = $nuevoContacto;

    // Guardar los contactos actualizados en el archivo de datos
    guardarContactos($archivoDatos, $contactos);

    // Redirigir al usuario a la página principal
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agregar Contacto</title>
        <!-- Enlace a la hoja de estilos -->
        <link rel="stylesheet" href="../style_left.css">
        <script>
            // Función para generar una contraseña aleatoria
            function generarPassword() {
                const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()';
                let password = '';
                for (let i = 0; i < 8; i++) {
                    password += caracteres.charAt(Math.floor(Math.random() * caracteres.length));
                }
                document.getElementById('password').value = password;
            }
        </script>
    </head>
    <body>
        <div class='ripple-background'>
        <div class='circle xxlarge shade1'></div>
        <div class='circle xlarge shade2'></div>
        <div class='circle large shade3'></div>
        <div class='circle mediun shade4'></div>
        <div class='circle small shade5'></div>
        </div>
        <header>
            <!-- Título de la página -->
            <h1>Agregar Contacto</h1>   
        </header>
        <main>
            <!-- Formulario para agregar un nuevo contacto -->
            <form action="agregar.php" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Nombre" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono</label>
                    <input type="tel" id="telefono" name="telefono" placeholder="Teléfono" required>
                </div>
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" placeholder="Email">
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="text" id="password" name="password" placeholder="Contraseña (opcional)">
                    <button type="button" onclick="generarPassword()" class="button">Generar Contraseña</button>
                </div>
                <div class="form-group">
                    <label for="imagen">Foto</label>
                    <input type="file" id="imagen" name="imagen" accept="image/*">
                </div>
                <button type="submit" name="guardar" class="button button-green">Guardar</button>
            </form>
            <br>
            <!-- Enlace para volver al listado de contactos -->
            <a href="index.php" class="button">Volver al Listado</a>
        </main>
        <footer>
            <!-- Contenido del pie de página -->
            <p>© 2025 Agenda de Contactos. Todos los derechos reservados.</p>
        </footer>
    </body>
</html>
