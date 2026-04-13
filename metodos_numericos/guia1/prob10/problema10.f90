! --- SOLUCIÓN AL PROBLEMA 10: OPERADORES LÓGICOS Y FUNCIONES INTRÍNSECAS ---

program problema_10
! SINTAXIS: Inicio del bloque del programa ejecutable.

    implicit none
    ! REGLA DE ORO OBLIGATORIA: Desactiva el tipado implícito para forzar la declaración manual de las variables.

    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: num1
    ! SINTAXIS ESTRICTA:
    ! 1. 'integer': Declara un espacio en memoria para números enteros (sin punto decimal).
    ! 2. '::' (Doble dos puntos): REGLA SINTÁCTICA. Separa el tipo de dato de la variable.

    ! --- ENTRADA DE DATOS ---
    write(*,*) 'Ingresar un numero'
    ! SINTAXIS: Imprime en la consola (*, salida estándar) con formato libre (*). El texto literal DEBE ir entre comillas.

    read(*,*) num1
    ! SINTAXIS: Lee desde el teclado (*, entrada estándar) con formato libre (*) y almacena en 'num1'.

    ! --- EVALUACIÓN LÓGICA Y ESTRUCTURA CONDICIONAL ---
    if (mod(num1, 2) == 0 .and. mod(num1,5) == 0) then
    ! ANÁLISIS SINTÁCTICO RIGUROSO DE ESTA LÍNEA CRÍTICA:
    ! 1. 'if (...) then': La condición general a evaluar DEBE ir entre paréntesis '()', seguida OBLIGATORIAMENTE por la palabra 'then' para abrir el bloque.
    ! 2. 'mod(num1, 2)': 'mod' es una función intrínseca de Fortran que calcula el módulo (el resto de la división).
    !    - REGLA: Como toda función, sus argumentos DEBEN ir entre paréntesis y separados por una coma ','.
    ! 3. '==': SINTAXIS ESTRICTA. Es el operador relacional de igualdad. (En Fortran antiguo se usaba '.eq.', pero '==' es el estándar moderno).
    !    - OJO: No confundir con el operador de asignación '=' (un solo igual).
    ! 4. '.and.': REGLA SINTÁCTICA OBLIGATORIA. Es el operador lógico "Y". DEBE llevar estrictamente un punto ANTES y un punto DESPUÉS. Si omites los puntos (escribiendo solo 'and'), el compilador buscará una variable llamada 'and' y arrojará un error de sintaxis.

        write(*,*) num1, 'es multiplo de 2 y de 5'
        ! SINTAXIS: Al imprimir, la variable 'num1' y el texto literal DEBEN estar separados por una coma.

    else if (mod(num1,2) == 0 .and. mod(num1,5) /= 0) then
    ! SINTAXIS ESTRICTA:
    ! 1. 'else if': Evalúa esta nueva condición SÓLO si la primera fue falsa.
    ! 2. '/=': REGLA SINTÁCTICA. Es el operador relacional moderno para "distinto de" o "no es igual a". (Reemplaza al antiguo '.ne.').

        write(*,*) num1, 'es multiplo de 2'

    else if (mod(num1,5) == 0 .and. mod(num1,2) /= 0) then
    ! SINTAXIS: Se evalúa si las dos condiciones anteriores fueron falsas.

        write(*,*) num1, 'es multiplo de 5'

    else
    ! SINTAXIS: Palabra reservada que atrapa cualquier caso que haya sobrevivido a todos los filtros anteriores (es decir, el resto no es cero en ninguno de los dos casos). No lleva condición.

        write(*,*) num1, 'no es multiplo ni de 2 ni de 5'

    end if
    ! REGLA SINTÁCTICA CRÍTICA: Cierre OBLIGATORIO del bloque de control 'if'.

    stop
    ! SINTAXIS: Detiene la ejecución.

end program problema_10
! SINTAXIS: Cierre obligatorio del bloque 'program'.
