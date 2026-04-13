! --- SOLUCIÓN AL PROBLEMA 11: RAÍCES Y ÁLGEBRA CONDICIONAL ---

program prob_11
! SINTAXIS: Identificador del programa principal.

    implicit none
    ! REGLA DE ORO: Evita el tipado automático.

    ! --- DEFINICIÓN DE PRECISIÓN ESTRICTA ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS: Fija la clase de los números reales.

    ! --- DECLARACIÓN DE VARIABLES ---
    real(kind=pr) :: A, B, C
    real(kind=pr) :: discriminante, parte_real, parte_imag, raiz1, raiz2
    ! SINTAXIS: Declaración de las variables bajo la precisión 'pr'.
    ! REGLA: Los dobles dos puntos '::' son obligatorios al asignar la clase.

    ! --- ENTRADA DE DATOS ---
    write(*,*) 'Ingrese los coeficientes A, B y C (separados por espacios):'
    read(*,*) A, B, C

    ! --- CONTROL DE EXCEPCIONES MATEMÁTICAS ---
    if (A == 0.0_pr) then
    ! REGLA DE LITERALES REALES: Fíjate en el '_pr' después del 0.0.
    ! SINTAXIS ESTRICTA: Cuando escribes un número "suelto" (un literal) en Fortran, debes concatenarle el sufijo del parámetro de su clase (ej: 0.0_pr). Esto le asegura a la CPU que ese '0.0' tiene la misma cantidad de bits en memoria que la variable 'A' con la que se está comparando.

        write(*,*) 'Si A es 0, no es un polinomio de segundo grado.'
        stop
        ! SINTAXIS: 'stop' corta la ejecución del programa aquí mismo, evitando que el procesador intente dividir por cero más abajo y cause un error crítico (Floating point exception)[cite: 915].
    end if

    ! --- CÁLCULO DEL DISCRIMINANTE ---
    discriminante = B**2 - 4.0_pr * A * C
    ! SINTAXIS ESTRICTA:
    ! 1. '**': Es el operador de exponenciación. OBLIGATORIO usar dos asteriscos seguidos sin espacios entre ellos[cite: 57].
    ! 2. '4.0_pr': El literal numérico lleva el sufijo de precisión '_pr'.
    ! 3. '*': Operador de multiplicación[cite: 54]. (4AC en papel debe escribirse explícitamente 4 * A * C en código).

    ! --- BIFURCACIÓN DE LÓGICA SEGÚN EL DISCRIMINANTE ---
    if (discriminante >= 0.0_pr) then
    ! SINTAXIS: Operador relacional '>=' (mayor o igual que)[cite: 80]. Condición siempre entre paréntesis '()'.

        ! CASO 1: Raíces reales
        raiz1 = (-B + sqrt(discriminante)) / (2.0_pr * A)
        raiz2 = (-B - sqrt(discriminante)) / (2.0_pr * A)
        ! SINTAXIS DE PRECEDENCIA:
        ! 1. 'sqrt()': Función intrínseca de Fortran para la raíz cuadrada. Su argumento DEBE estar entre paréntesis[cite: 149].
        ! 2. '()': OBLIGATORIO envolver el numerador y el denominador. Si escribieras -B + sqrt(discriminante) / 2.0_pr * A, la computadora primero dividiría la raíz por dos y luego multiplicaría todo por A. ¡Desastre matemático!

        write(*,*) 'Raiz 1 = ', raiz1, ' + i 0.0000'
        write(*,*) 'Raiz 2 = ', raiz2, ' + i 0.0000'
        ! SINTAXIS: Impresión mixta de variables numéricas y texto (la 'i' imaginaria se "falsifica" con un string). Todo separado por comas ','.

    else
        ! CASO 2: Raíces complejas conjugadas
        parte_real = -B / (2.0_pr * A)

        parte_imag = sqrt(-discriminante) / (2.0_pr * A)
        ! LÓGICA SINTÁCTICA: Al estar dentro del bloque 'else', matemáticamente sabemos que 'discriminante' es negativo. El signo '-' antes de la variable invierte su signo a positivo, permitiendo que 'sqrt()' opere sin dar un error de 'Not a Number' (NaN)[cite: 741].

        write(*,*) 'Raiz 1 = ', parte_real, ' + i ', parte_imag
        write(*,*) 'Raiz 2 = ', parte_real, ' - i ', parte_imag

    end if
    ! REGLA CRÍTICA: Cierre obligatorio del bloque condicional abierto por el 'if'.

end program prob_11
