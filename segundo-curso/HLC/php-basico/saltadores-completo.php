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
    ["nombre" => "Sofia", "apellido" => "Torres", "ranking" => 2750, "nacionalidad" => "Venezolana"],
    ["nombre" => "Andres", "apellido" => "Martinez", "ranking" => 2600, "nacionalidad" => "Ecuatoriana"],
    ["nombre" => "Clara", "apellido" => "Jimenez", "ranking" => 2450, "nacionalidad" => "Paraguaya"],
    ["nombre" => "Fernando", "apellido" => "Gonzalez", "ranking" => 2850, "nacionalidad" => "Boliviana"],
    ["nombre" => "Isabel", "apellido" => "Ramirez", "ranking" => 2500, "nacionalidad" => "Chilena"],
    ["nombre" => "Pablo", "apellido" => "Hernandez", "ranking" => 2650, "nacionalidad" => "Costarricense"],
    ["nombre" => "Lucia", "apellido" => "Reyes", "ranking" => 2550, "nacionalidad" => "Salvadoreña"],
    ["nombre" => "Esteban", "apellido" => "Cruz", "ranking" => 2700, "nacionalidad" => "Nicaragüense"]
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
            background-color: #4CAF50; /* Color de fondo de las cabeceras */
            color: white; /* Color del texto en la cabecera */
        }
        tr:nth-child(odd) {
            background-color: #f9f9f9; /* Colorea las filas impares con un color gris claro */
        }
        tr:nth-child(even) {
            background-color: #ffffff; /* Color de fondo de las filas pares */
        }
    </style>
</head>
<body>

<h2>Actividad 1</h2>

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
        // Aquí iría el código que genera y ordena los saltadores
        foreach ($saltadores as $index => $saltador) {
            echo "<tr>";
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
<br>
<br>
<br>

<h2>Actividad 2</h2>

<?php
// Inicializamos variables para el mejor salto
$mejorSalto1 = null;
$mejorSalto2 = null;
$mejorSalto3 = null;

// Recorremos los saltadores para encontrar los mejores saltos
foreach ($saltadores as $saltador) {
    if ($mejorSalto1 === null || $saltador['salto1'] > $mejorSalto1['puntos']) {
        $mejorSalto1 = [
            'nombre' => strtoupper($saltador['nombre']),
            'apellido' => strtoupper($saltador['apellido']),
            'puntos' => $saltador['salto1']
        ];
    }
    
    if ($mejorSalto2 === null || $saltador['salto2'] > $mejorSalto2['puntos']) {
        $mejorSalto2 = [
            'nombre' => strtoupper($saltador['nombre']),
            'apellido' => strtoupper($saltador['apellido']),
            'puntos' => $saltador['salto2']
        ];
    }
    
    if ($mejorSalto3 === null || $saltador['salto3'] > $mejorSalto3['puntos']) {
        $mejorSalto3 = [
            'nombre' => strtoupper($saltador['nombre']),
            'apellido' => strtoupper($saltador['apellido']),
            'puntos' => $saltador['salto3']
        ];
    }
}

// Imprimimos el resultado
echo "El saltador \"{$mejorSalto1['nombre']} {$mejorSalto1['apellido']}\" hizo el mejor salto 1 obteniendo: {$mejorSalto1['puntos']} puntos. '<br>'";
echo "El saltador \"{$mejorSalto2['nombre']} {$mejorSalto2['apellido']}\" hizo el mejor salto 2 obteniendo: {$mejorSalto2['puntos']} puntos. '<br>'";
echo "El saltador \"{$mejorSalto3['nombre']} {$mejorSalto3['apellido']}\" hizo el mejor salto 3 obteniendo: {$mejorSalto3['puntos']} puntos. '<br>'";
?>

<h2>Actividad 3</h2>

<table>
    <thead>
        <tr>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>SALTO 1</th>
            <th>SALTO 2</th>
            <th>SALTO 3</th>
            <th>TOTAL</th>
            <th>PUESTO</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Ordenamos los saltadores por su puntuación total en la segunda ronda (salto2)
        usort($saltadores, function($a, $b) {
            return $b['salto2'] <=> $a['salto2'];
        });

        foreach ($saltadores as $index => $saltador) {
            echo "<tr>";
            echo "<td>{$saltador['nombre']}</td>";
            echo "<td>{$saltador['apellido']}</td>";
            echo "<td>{$saltador['salto1']}</td>";
            echo "<td>{$saltador['salto2']}</td>";
            echo "<td>{$saltador['salto3']}</td>";
            echo "<td>{$saltador['total']}</td>"; // Asegúrate de que el total se actualice según la segunda ronda
            echo "<td>" . ($index + 1) . "</td>"; // El puesto se muestra según el índice (ordenado por salto2)
            echo "</tr>";
        }
        ?>
    </tbody>
</table>

<h2>Actividad 4</h2>

<table>
    <thead>
        <tr>
            <th>PUESTO</th>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>RANKING</th>
            <th>PAIS (FEDERACIÓN)</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Tomamos los cinco primeros saltadores de la lista ya ordenada
        $topSaltadores = array_slice($saltadores, 0, 5);

        foreach ($topSaltadores as $index => $saltador) {
            echo "<tr>";
            echo "<td>" . ($index + 1) . "</td>"; // El puesto se muestra según el índice
            echo "<td>{$saltador['nombre']}</td>";
            echo "<td>{$saltador['apellido']}</td>";
            echo "<td>{$saltador['ranking']}</td>";
            echo "<td>{$saltador['nacionalidad']}</td>"; // Se asume que 'nacionalidad' es el país o federación
            echo "</tr>";
        }
        ?>
    </tbody>
</table>

<h2>Actividad 5</h2>

<table>
    <thead>
        <tr>
            <th>PUESTO</th>
            <th>NOMBRE</th>
            <th>APELLIDO</th>
            <th>RANKING</th>
            <th>PAIS (FEDERACIÓN)</th>
        </tr>
    </thead>
    <tbody>
        <?php
        // Filtramos los saltadores para excluir a Raúl Capablanca
        $saltadoresFiltrados = array_filter($saltadores, function($saltador) {
            return !($saltador['nombre'] === 'Raúl' && $saltador['apellido'] === 'Capablanca');
        });

        // Ordenamos los saltadores filtrados por su puntuación total
        usort($saltadoresFiltrados, function($a, $b) {
            return $b['total'] <=> $a['total'];
        });

        foreach ($saltadoresFiltrados as $index => $saltador) {
            echo "<tr>";
            echo "<td>" . ($index + 1) . "</td>"; // El puesto se muestra según el índice
            echo "<td>{$saltador['nombre']}</td>";
            echo "<td>{$saltador['apellido']}</td>";
            echo "<td>{$saltador['ranking']}</td>";
            echo "<td>{$saltador['nacionalidad']}</td>"; // Se asume que 'nacionalidad' es el país o federación
            echo "</tr>";
        }
        ?>
    </tbody>
</table>

</body>
</html>
