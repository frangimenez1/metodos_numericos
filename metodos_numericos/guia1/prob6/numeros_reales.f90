! --- SOLUCIÓN AL PROBLEMA 6: SUMA DE REALES CON PRECISIÓN CONTROLADA ---

program numeros_reales
! SINTAXIS: Palabra reservada 'program' para definir el punto de entrada del ejecutable.
! REGLA: El nombre 'numeros_reales' no debe coincidir con ninguna variable interna.

    implicit none
    ! REGLA DE ORO: Obliga a la declaración explícita de cada variable para evitar errores de tipado accidental.

    ! --- DEFINICIÓN DE PRECISIÓN (Agregado para cumplir con el estilo de la materia) ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS:
    ! 1. 'integer': Tipo de dato entero[cite: 33].
    ! 2. 'parameter': Atributo que indica que el valor de 'pr' es una constante y no cambiará.
    ! 3. 'kind(1.0)': Función intrínseca que devuelve el número de clase para precisión simple.
    ! REGLA: Usar 'pr' permite cambiar la precisión de TODO el programa cambiando solo esta línea (ej: kind(1.d0) para doble).

    ! --- DECLARACIÓN DE VARIABLES ---
    real(kind=pr) :: num1, num2, suma
    ! SINTAXIS ESTRICTA:
    ! 1. 'real': Keyword para números de punto flotante.
    ! 2. '(kind=pr)': Especificador de precisión. Indica que estas variables usarán la clase definida en 'pr'.
    ! 3. '::': Doble dos puntos obligatorio cuando se usan atributos o especificadores de clase.
    ! 4. ',': Las variables se separan por comas.

    ! --- ENTRADA DE DATOS ---
    write(*,*) 'Escribir 2 numeros'
    ! SINTAXIS:
    ! - 'write': Comando de salida.
    ! - '(*,*)': El primer '*' es la unidad de salida (pantalla). El segundo '*' es el formato libre (list-directed).
    ! - '...': El texto literal DEBE ir entre comillas simples o dobles.

    read(*,*) num1, num2
    ! SINTAXIS:
    ! - 'read': Comando de entrada.
    ! - '(*,*)': Unidad de entrada (teclado) y formato libr.
    ! REGLA: Si el usuario ingresa los números en la misma línea, deben separarse por un espacio o coma. Si no, puede usar la tecla Enter entre ellos.

    ! --- OPERACIÓN ARITMÉTICA ---
    suma = num1 + num2
    ! SINTAXIS:
    ! - '=': Operador de asignación (almacena el valor de la derecha en la dirección de memoria de la izquierda).
    ! - '+': Operador de suma.

    ! --- SALIDA DE RESULTADOS ---
    write(*,*) 'El resultado de la suma es =', suma
    ! REGLA SINTÁCTICA: Para imprimir un texto y una variable juntos, DEBES separarlos con una coma.

    STOP
    ! SINTAXIS: Indica el cese de la ejecución del programa.

end program numeros_reales
! SINTAXIS: Cierre obligatorio del bloque del programa.

	
