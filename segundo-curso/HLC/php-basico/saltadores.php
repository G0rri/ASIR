<?php
// Función para generar puntuaciones aleatorias de los jueces
function generarPuntuaciones() {
    // Creamos un array vacío donde se almacenarán las puntuaciones de los jueces
    $puntuaciones = [];
    
    // Generamos 5 puntuaciones aleatorias, que estarán entre 0 y 10 con intervalos de 0.5
    for ($i = 0; $i < 5; $i++) {
        // mt_rand(0, 20) genera un número entre 0 y 20, luego lo dividimos por 2 para obtener intervalos de 0.5
        // round(..., 1) redondea el número a un decimal
        $puntuaciones[] = round(mt_rand(0, 20) / 2, 1); 
    }
    
    // Ordenamos las puntuaciones de menor a mayor
    sort($puntuaciones);
    
    // Eliminamos la puntuación más baja (primer elemento del array)
    array_shift($puntuaciones);
    
    // Eliminamos la puntuación más alta (último elemento del array)
    array_pop($puntuaciones);
    
    // Sumamos las puntuaciones restantes y la retornamos
    return array_sum($puntuaciones);
}

// Función para calcular el total de un salto multiplicado por el grado de dificultad
function calcularTotal($puntuacion, $dificultad) {
    // Retornamos el producto de la puntuación y la dificultad
    return $puntuacion * $dificultad;
}

// Datos de los 8 saltadores, con su nombre, apellido, ranking y nacionalidad
$saltadores = [
    ["nombre" => "Raúl", "apellido" => "Capablanca", "ranking" => 2780, "nacionalidad" => "Cubana"],
    ["nombre" => "Ana", "apellido" => "Pérez", "ranking" => 2500, "nacionalidad" => "Mexicana"],
    ["nombre" => "Juan", "apellido" => "García", "ranking" => 2650, "nacionalidad" => "Española"],
    ["nombre" => "Carlos", "apellido" => "Rodríguez", "ranking" => 2700, "nacionalidad" => "Colombiana"],
    ["nombre" => "Laura", "apellido" => "Martínez", "ranking" => 2550, "nacionalidad" => "Argentina"],
    ["nombre" => "Miguel", "apellido" => "López", "ranking" => 2900, "nacionalidad" => "Chilena"],
    ["nombre" => "Julia", "apellido" => "Suárez", "ranking" => 2400, "nacionalidad" => "Peruana"],
    ["nombre" => "David", "apellido" => "Fernández", "ranking" => 2800, "nacionalidad" => "Uruguaya"]
];

// Iteramos sobre cada saltador para asignarles puntuaciones y grados de dificultad
foreach ($saltadores as $key => $saltador) {
    // Generamos las puntuaciones para 3 saltos distintos
    $saltadores[$key]['salto1'] = generarPuntuaciones();
    $saltadores[$key]['salto2'] = generarPuntuaciones();
    $saltadores[$key]['salto3'] = generarPuntuaciones();
    
    // Generamos un grado de dificultad único para cada salto
    // Para el salto 1
    $saltadores[$key]['dificultad1'] = round(rand(0, 10) / 10, 1);
    
    // Generamos el grado de dificultad del salto 2 asegurándonos de que no sea igual al salto 1
    do {
        $saltadores[$key]['dificultad2'] = round(rand(0, 10) / 10, 1);
    } while ($saltadores[$key]['dificultad2'] == $saltadores[$key]['dificultad1']);
    
    // Generamos el grado de dificultad del salto 3 asegurándonos de que no sea igual a los saltos 1 ni 2
    do {
        $saltadores[$key]['dificultad3'] = round(rand(0, 10) / 10, 1);
    } while ($saltadores[$key]['dificultad3'] == $saltadores[$key]['dificultad1'] || $saltadores[$key]['dificultad3'] == $saltadores[$key]['dificultad2']);
    
    // Calculamos el total de cada salto multiplicado por su respectivo grado de dificultad
    // Se hace la suma de los 3 saltos (cada uno multiplicado por su dificultad)
    $saltadores[$key]['total'] = calcularTotal($saltadores[$key]['salto1'], $saltadores[$key]['dificultad1']) +
                                 calcularTotal($saltadores[$key]['salto2'], $saltadores[$key]['dificultad2']) +
                                 calcularTotal($saltadores[$key]['salto3'], $saltadores[$key]['dificultad3']);
}

// Ordenamos los saltadores por su puntuación total en orden descendente (de mayor a menor)
usort($saltadores, function($a, $b) {
    return $b['total'] <=> $a['total'];
});

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Competición de Trampolín</title>
    <style>
        /* Estilos para la tabla */
        table {
            width: 100%;
            border-collapse: collapse; /* Hace que las celdas de la tabla se unan sin espacio */
        }
        th, td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd; /* Añade un borde gris claro */
        }
        th {
            background-color: #f2f2f2; /* Color de fondo de las cabeceras */
        }
        tr:nth-child(odd) {
            background-color: #f9f9f9; /* Colorea las filas impares con un color gris claro */
        }
    </style>
</head>
<body>

<h2>Listado de Puntuaciones - Competición de Trampolín</h2>

<table>
    <thead>
        <tr>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>RANKING</th>
            <th>SALTO 1</th>
            <th>SALTO 2</th>
            <th>SALTO 3</th>
            <th>TOTAL</th>
            <th>PUESTO</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Mostramos la tabla con las puntuaciones de los saltadores
        foreach ($saltadores as $index => $saltador) {
            echo "<tr>";
            // Imprimimos los datos de cada saltador en una fila de la tabla
            echo "<td>{$saltador['nombre']}</td>";
            echo "<td>{$saltador['apellido']}</td>";
            echo "<td>{$saltador['ranking']}</td>";
            echo "<td>{$saltador['salto1']}</td>";
            echo "<td>{$saltador['salto2']}</td>";
            echo "<td>{$saltador['salto3']}</td>";
            echo "<td>{$saltador['total']}</td>";
            echo "<td>" . ($index + 1) . "</td>"; // El puesto se muestra según el índice (ordenado por puntuación)
            echo "</tr>";
        }
        ?>
    </tbody>
</table>

</body>
</html>
