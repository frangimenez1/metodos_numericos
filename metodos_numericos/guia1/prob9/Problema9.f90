! --- SOLUCIÓN AL PROBLEMA 9: ESTRUCTURAS DE CONTROL DE FLUJO ---

program Problema9
! SINTAXIS: Inicio del bloque principal del programa.

    implicit none
    ! REGLA DE ORO: Evita el tipado implícito; todas las variables deben declararse explícitamente.

    ! --- DEFINICIÓN DE PRECISIÓN ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS: 'parameter' define a 'pr' como una constante que almacena la clase de precisión simple.

    ! --- DECLARACIÓN DE VARIABLES ---
    real(kind=pr) :: num1, num2
    ! SINTAXIS ESTRICTA: Declara 'num1' y 'num2' como números de punto flotante usando la precisión 'pr'.
    ! REGLA: Uso obligatorio del doble dos puntos '::' al especificar atributos o el 'kind'.

    ! --- ENTRADA DE DATOS ---
    write(*,*) 'Insertar dos numeros reales'
    ! SINTAXIS: Imprime el texto literal (encerrado en comillas simples) en la salida estándar (pantalla) con formato libre.

    read (*,*) num1, num2
    ! SINTAXIS: Lee desde la entrada estándar (teclado) con formato libre y almacena los valores en 'num1' y 'num2'.

    ! --- ESTRUCTURA DE CONTROL DE FLUJO: IF / ELSE IF / ELSE ---
    if (num1 > num2) then
    ! SINTAXIS ESTRICTA Y REGLAS:
    ! 1. 'if': Palabra reservada que inicia una evaluación condicional.
    ! 2. '(num1 > num2)': REGLA OBLIGATORIA: La condición lógica DEBE estar encerrada entre paréntesis '()'. El operador '>' (mayor que) compara ambos valores. En Fortran clásico se usaba '.gt.', pero '>' es el estándar moderno.
    ! 3. 'then': REGLA OBLIGATORIA: Si la estructura 'if' controla un bloque de código en múltiples líneas (block-if), DEBE llevar la palabra clave 'then' al final de la condición.

        write(*,*) 'El numero mayor es:', num1
        ! SINTAXIS: Si la condición anterior evalúa a verdadero (.TRUE.), se ejecuta este bloque. Recordar la coma ',' para separar el texto de la variable.

    else if (num2 > num1) then
    ! SINTAXIS:
    ! 1. 'else if': Palabra reservada (puede escribirse junta 'elseif') que se evalúa SÓLO SI la condición del 'if' anterior fue falsa (.FALSE.).
    ! 2. '(num2 > num1) then': Misma regla de sintaxis: condición entre paréntesis y 'then' obligatorio.

        write(*,*) 'El numero mayor es:', num2
        ! SINTAXIS: Se ejecuta si '(num2 > num1)' es verdadero.

    else
    ! SINTAXIS:
    ! 1. 'else': Palabra reservada que no lleva condición. Atrapa CUALQUIER otro caso que no haya cumplido con las condiciones previas.
    ! LÓGICA: Si no es mayor el primero, ni es mayor el segundo, por descarte matemático, la única opción restante es que sean iguales.

        write(*,*) 'Los numeros son iguales'
        ! SINTAXIS: Bloque que se ejecuta por el 'else'.

    end if
    ! REGLA SINTÁCTICA CRÍTICA: Toda estructura block-if (que usa 'then') DEBE cerrarse con la instrucción 'end if'. Omitirlo causará un error de compilación.

    stop
    ! SINTAXIS: Detiene la ejecución.
