<!DOCTYPE html>
<html>
  <body>

  <h3>1. Imprima los primeros 10 números naturales usando el bucle while.</h3>
    <?php  
      $i = 1;

      while ($i < 11) {
        echo $i, "-";
        $i++;
      } 
    ?>

  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>2. Lo mismo en orden inverso.</h3>
    <?php
      $i = 10;

      while ($i > 0) {
        echo $i, "-";
        $i--;
      } 
    ?> 

  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>3. Imprima los primeros 10 números naturales usando el bucle for.</h3>
    <?php
      for ($i = 1; $i < 11; $i++) {
        echo $i, "-";
      } 
    ?> 

  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>4. Lo mismo en orden inverso.</h3>
    <?php
      for ($i = 10; $i > 0; $i--) {
        echo $i, "-";
      } 
    ?> 

  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>5. Ingrese un número e imprima su tabla de multiplicar.</h3>
  <form action="#5" method="POST">
    Numero de multiplicar: <input type="number" name="multiplicar">
    <input type="submit" value="Generar tabla">
    </form>
    <?php
    if(empty($_POST["multiplicar"])) {
      $multiplicar = 0;
    } else {
      $multiplicar = $_POST["multiplicar"];
    }

    echo "Tabla de multiplicar: ", $multiplicar;
    echo "<br>";

    for ($i = 1; $i <= 10; $i++){
      echo $multiplicar, " x", $i, " =", $i * $multiplicar;
      echo "<br>";
    }
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>6. Ingrese números hasta que el usuario escriba 0 (cero). Luego imprima el conteo y la suma de los
  números.</h3>
    <?php
      session_start(); // Iniciar la sesión para almacenar los números ingresados

      // Verificar si ya hay números guardados en la sesión
      if (!isset($_SESSION['numeros'])) {
          $_SESSION['numeros'] = []; // Inicializar el array si no existe
      }
      
      // Procesar el formulario al enviar un número
      if (isset($_POST['numero'])) {
          $numero = $_POST['numero'];
          
          // Si el número ingresado es 0, se calcula el conteo y la suma
          if ($numero == 0) {
              $conteo = count($_SESSION['numeros']);
              $suma = array_sum($_SESSION['numeros']);
              
              echo "Conteo de números ingresados: " . $conteo . "<br>";
              echo "Suma de números ingresados: " . $suma . "<br>";
              
              // Reiniciar la sesión para permitir nuevos ingresos
              session_destroy();
          } else {
              // Agregar el número a la sesión
              $_SESSION['numeros'][] = $numero;
          }
      }
      ?>
      
      <h3>Ingrese números (escriba 0 para finalizar):</h3>
      <form action="" method="POST">
          <input type="number" name="numero" required>
          <input type="submit" value="Agregar número">
      </form>
      
      <?php
      // Mostrar los números ingresados hasta el momento
      if (!empty($_SESSION['numeros'])) {
          echo "Números ingresados: " . implode(", ", $_SESSION['numeros']) . "<br>";
      }
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>7. Imprima el siguiente patrón.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>8. Imprima el siguiente patrón.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>9. Imprima el siguiente patrón.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>10. Imprima el siguiente patrón.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>11. Ingrese un número y calcule la suma de todos los números desde 1 hasta un número determinado.
  Por ejemplo, si el usuario ingresó 10, la salida debería ser 55 (1+2+3+4+5+6+7+8+9+10).</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>12. Dada una lista de números = [7, 8, 12, 29, 75, 150, 180, 145, 525, 50] imprima aquellos que son
  divisibles por 4 o por 5.</h3>
    <?php
     
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>13. Lo mismo pero detener el ciclo si un número no es mayor que su predecesor.</h3>
    <?php
     
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>14. Ingrese un número y verifique si es un número primo o no.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>15. Ingrese dos números y calcule su máximo común divisor (MCD) utilizando un bucle while.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>16. Dado un número ingresado por el usuario, imprima todos sus divisores.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>17. Cree un programa que imprima la secuencia de Fibonacci hasta un número ingresado por el
  usuario.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>18. Ingrese una lista de números y calcule la media, el máximo y el mínimo de los valores ingresados.</h3>
    <?php
      
    ?> 
    
  <br>
  <br>
  <br>
  <br>
  <br>

  <h3>19. Escriba un programa que cuente el número de vocales en una palabra ingresada por el usuario.</h3>
    <?php
      
    ?> 

<br>
  <br>
  <br>
  <br>
  <br>

  <h3>20. Ingrese un número y calcule el factorial de ese número usando un bucle for.</h3>
    <?php
      
    ?> 
    
  </body>
</html>
