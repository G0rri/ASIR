<?php

/**
 * Lee los contactos almacenados en un archivo JSON.
 * @param string $archivo Ruta del archivo JSON.
 * @return array Lista de contactos como un array asociativo.
 */
function leerContactos($archivo) {
    if (!file_exists($archivo)) {
        return []; // Devuelve un array vacío si el archivo no existe.
    }
    $datos = file_get_contents($archivo);
    return json_decode($datos, true) ?? []; // Devuelve el array decodificado o vacío si hay error.
}

/**
 * Guarda los contactos en un archivo JSON.
 * @param string $archivo Ruta del archivo JSON.
 * @param array $contactos Lista de contactos a guardar.
 */
function guardarContactos($archivo, $contactos) {
    file_put_contents($archivo, json_encode($contactos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

/**
 * Genera una contraseña aleatoria.
 * @param int $longitud Longitud de la contraseña (por defecto 8).
 * @return string Contraseña generada.
 */
function generarPassword($longitud = 8) {
    $caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()';
    return substr(str_shuffle($caracteres), 0, $longitud);
}

/**
 * Sube un archivo de imagen al servidor y devuelve su nombre único.
 * @param array $archivo Datos del archivo subido ($_FILES).
 * @param string $directorio Carpeta donde se guardará la imagen.
 * @return string|null Nombre del archivo subido o null si falla.
 */
function subirImagen($archivo, $directorio) {
    if ($archivo['error'] !== UPLOAD_ERR_OK) {
        return null; // Devuelve null si hay errores en la subida.
    }

    // Verifica si el archivo es una imagen válida.
    $tipoPermitido = ['image/jpeg', 'image/png', 'image/gif'];
    if (!in_array($archivo['type'], $tipoPermitido)) {
        return null;
    }

    // Genera un nombre único para la imagen.
    $nombreArchivo = uniqid() . "_" . basename($archivo["name"]);
    $rutaDestino = $directorio . "/" . $nombreArchivo;

    // Mueve el archivo al directorio de destino.
    if (move_uploaded_file($archivo["tmp_name"], $rutaDestino)) {
        return $nombreArchivo;
    }
    return null;
}

/**
 * Elimina una imagen del servidor.
 * @param string $directorio Carpeta donde está almacenada la imagen.
 * @param string $nombreArchivo Nombre del archivo a eliminar.
 */
function eliminarImagen($directorio, $nombreArchivo) {
    $rutaArchivo = $directorio . "/" . $nombreArchivo;
    if (file_exists($rutaArchivo)) {
        unlink($rutaArchivo); // Elimina el archivo si existe.
    }
}

/**
 * Busca un contacto por su ID.
 * @param array $contactos Lista de contactos.
 * @param string $id Identificador del contacto.
 * @return array|null Contacto encontrado o null si no existe.
 */
function buscarContactoPorID($contactos, $id) {
    foreach ($contactos as $contacto) {
        if ($contacto['id'] === $id) {
            return $contacto;
        }
    }
    return null; // Devuelve null si no encuentra el contacto.
}

/**
 * Actualiza un contacto existente en la lista.
 * @param array $contactos Lista de contactos.
 * @param string $id Identificador del contacto a actualizar.
 * @param array $nuevosDatos Nuevos datos del contacto.
 * @return array Lista de contactos actualizada.
 */
function actualizarContacto($contactos, $id, $nuevosDatos) {
    foreach ($contactos as $index => $contacto) {
        if ($contacto['id'] === $id) {
            $contactos[$index] = array_merge($contacto, $nuevosDatos);
            break;
        }
    }
    return $contactos;
}

/**
 * Elimina un contacto por su ID.
 * @param array $contactos Lista de contactos.
 * @param string $id Identificador del contacto a eliminar.
 * @return array Lista de contactos actualizada.
 */
function eliminarContacto($contactos, $id) {
    foreach ($contactos as $index => $contacto) {
        if ($contacto['id'] === $id) {
            array_splice($contactos, $index, 1);
            break;
        }
    }
    return $contactos;
}
?>
