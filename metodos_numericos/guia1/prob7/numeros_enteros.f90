! --- SOLUCIÓN AL PROBLEMA 7 ---

program numeros_enteros
! SINTAXIS: Palabra reservada 'program' seguida del identificador.
! REGLA: El nombre no puede llevar espacios. Inicia el bloque principal de ejecución del código.

    implicit none
    ! SINTAXIS OBLIGATORIA: Desactiva el tipado implícito heredado de versiones antiguas. Fuerza al programador a que toda variable sea declarada explícitamente a continuación.

    ! --- DECLARACIÓN DE VARIABLES ---
    INTEGER :: num1, num2, producto
    ! SINTAXIS ESTRICTA Y REGLAS:
    ! 1. 'INTEGER': Palabra reservada que define el tipo de dato. Le dice a la máquina que asigne espacio en memoria para números sin decimales (típicamente representados internamente en "complemento a dos").
    ! 2. '::' (Doble dos puntos): REGLA SINTÁCTICA. Se usa para separar el tipo de dato (y sus modificadores, si los hubiera) de la lista de variables. Es la forma estándar y segura de declarar en Fortran 90+.
    ! 3. 'num1, num2, producto': Nombres de las variables.
    ! 4. ',' (Coma): SINTAXIS OBLIGATORIA. Para declarar múltiples variables del mismo tipo en una sola línea, DEBEN estar separadas por comas.

    ! --- ENTRADA DE DATOS ---
    WRITE(*,*) 'Ingresar dos numeros'
    ! SINTAXIS ESTRICTA DE SALIDA:
    ! 1. 'WRITE': Instrucción de salida.
    ! 2. '(*,*)': SINTAXIS OBLIGATORIA de control. El primer '*' es la unidad de salida (la consola/pantalla por defecto). La coma ',' separa los argumentos. El segundo '*' indica "formato libre" (dejas que el compilador formatee el texto).
    ! 3. 'Ingresar dos numeros': REGLA OBLIGATORIA. Las cadenas de texto literales DEBEN ir entre comillas simples (' ') o dobles (" ").

    READ(*,*) num1, num2
    ! SINTAXIS ESTRICTA DE ENTRADA:
    ! 1. 'READ': Comando de lectura de entrada estándar.
    ! 2. '(*,*)': Unidad por defecto (teclado) y formato libre. La máquina leerá lo que tipeaste hasta encontrar un retorno de carro (Enter).
    ! 3. 'num1, num2': Lista de variables donde se almacenará la entrada. Separadas OBLIGATORIAMENTE por coma. Fortran esperará que ingreses dos valores separados por un espacio o por la tecla Enter.

    ! --- OPERACIÓN ---
    producto = num1 * num2
    ! SINTAXIS ESTRICTA:
    ! 1. '=': Es el operador de ASIGNACIÓN, no de igualdad matemática. Le ordena a la CPU: "Evalúa la expresión de la derecha y almacena el resultado en el espacio de memoria de la variable de la izquierda".
    ! 2. '*': Operador aritmético obligatorio para la multiplicación.

    ! --- SALIDA DE DATOS ---
    WRITE(*,*) 'El resultado es =', producto
    ! REGLA SINTÁCTICA CRÍTICA: Al mezclar texto literal ('El resultado es =') con el valor de una variable (producto) dentro de un comando 'WRITE', OBLIGATORIAMENTE deben estar separados por una coma ','. Si omites esa coma, el compilador arrojará un error de sintaxis inmediatamente.

    STOP
    ! SINTAXIS: Detiene la ejecución del programa.

END PROGRAM numeros_enteros
! REGLA SINTÁCTICA: Cierra el bloque abierto por 'program'.
! BUENA PRÁCTICA: Poner el nombre al final es opcional, pero evita confusiones del compilador en programas grandes.

