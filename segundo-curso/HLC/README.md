# 🐘 HLC · Desarrollo web con PHP

Horas de Libre Configuración dedicadas al desarrollo web del lado del servidor con **PHP**: fundamentos del lenguaje, formularios, manejo de datos en JSON y acceso a **MySQL** con el patrón **CRUD**.

## Contenido

| Carpeta | Contenido |
|---|---|
| [`php-basico/`](php-basico/) | Ejercicios de PHP: bucles, formularios, sesiones y un ejercicio completo (competición de saltos) |
| [`agenda-contactos/`](agenda-contactos/) | Agenda de contactos con almacenamiento en **JSON** y subida de imágenes |
| [`crud-mysql/`](crud-mysql/) | CRUD de contactos sobre **MySQL** con Bootstrap |

## PHP básico

- [`actividades.php`](php-basico/actividades.php): 20 ejercicios de control de flujo (bucles `while`/`for`, tablas de multiplicar, sumas, sesiones con `$_SESSION`…).
- [`saltadores.php`](php-basico/saltadores.php) y [`saltadores-completo.php`](php-basico/saltadores-completo.php): **competición de saltos de trampolín**. Genera puntuaciones aleatorias de 5 jueces, descarta la más alta y la más baja, multiplica por el grado de dificultad, ordena a los saltadores por puntuación total y muestra varias tablas (ranking, mejor salto por ronda, *top 5*, ranking excluyendo a un competidor). Datos de saltadores **ficticios**.

```bash
php -S localhost:8000 -t php-basico    # servidor de pruebas de PHP
```

## Agenda de contactos (JSON)

Aplicación CRUD que guarda los contactos en un **fichero JSON** (sin base de datos) y permite subir una foto por contacto.

```
agenda-contactos/
├── funciones.php          # leer/guardar JSON, subir/eliminar imagen, buscar/actualizar/borrar
├── data/contactos.json    # datos (ficticios)
├── uploads/               # imágenes subidas (no versionadas)
├── stilos.css · style_center.css · style_left.css
└── vistas/
    ├── index.php          # listado
    ├── agregar.php        # alta (con imagen y contraseña generada)
    ├── editar.php         # edición
    ├── eliminar.php       # baja
    └── galeria.php        # galería de imágenes
```

Conceptos: `json_encode`/`json_decode`, subida de ficheros con `$_FILES` y `move_uploaded_file` (validando el tipo MIME), nombres únicos con `uniqid()` y generación de contraseñas aleatorias.

## CRUD con MySQL

CRUD clásico de contactos con **mysqli** y maquetado con **Bootstrap** (por CDN).

```
crud-mysql/
├── db.php         # conexión mysqli (localhost / root)
├── schema.sql     # crea la base de datos contacts_db y la tabla contacts
├── index.php      # listado (READ)
├── create.php     # alta (CREATE)
├── edit.php       # edición (UPDATE)
├── update.php     # procesa la edición
└── delete.php     # baja (DELETE)
```

```bash
mysql -u root -p < crud-mysql/schema.sql
php -S localhost:8000 -t crud-mysql
```

## Notas

- Los datos de contactos y saltadores son **ficticios**; las imágenes subidas no se incluyen.
- La conexión usa `root` sin contraseña, propia de un **XAMPP/servidor local** de desarrollo.
- 💡 **Revisión**: el CRUD de MySQL construye las consultas concatenando directamente lo que llega por `$_POST`, lo que es vulnerable a **inyección SQL**. En un proyecto real deben usarse **consultas preparadas** (`mysqli`/PDO con parámetros) y escaparse la salida HTML para evitar XSS.
