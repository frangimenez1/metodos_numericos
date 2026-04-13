! --- SOLUCIÓN AL PROBLEMA 12: ACUMULACIÓN DE ERRORES DE REDONDEO ---

program prob_12
! SINTAXIS: Define el bloque principal de ejecución.

    implicit none
    ! REGLA DE ORO: Exige declaración explícita de variables.

    ! --- DEFINICIÓN DE PRECISIÓN ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS: Fija la clase de precisión simple (32 bits, estándar IEEE 754).
    ! REGLA: Fundamental para controlar exactamente cuántos dígitos significativos tiene la mantisa (aprox. 7 decimales en precisión simple)[cite: 2, 4].

    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: n
    ! SINTAXIS: Variable de control para el iterador del bucle.

    real(kind=pr) :: suma_directa, suma_inversa, diferencia
    ! SINTAXIS ESTRICTA: Declaración obligando al compilador a usar la precisión 'pr'.

    ! --- INICIALIZACIÓN ---
    suma_directa = 0.0_pr
    suma_inversa = 0.0_pr
    ! SINTAXIS Y REGLAS DE LITERALES:
    ! Como bien dijiste, esto "limpia" la variable.
    ! REGLA ESTRICTA: Se le concatena '_pr' al literal (0.0) para asegurar que ese cero se cargue en memoria con la misma cantidad de bits que la variable.

    ! --- BUCLE 1: SUMA DIRECTA (De mayor a menor aporte) ---
    ! SINTAXIS ESTRICTA DEL BUCLE DO:
    ! 1. 'do': Palabra reservada que inicia una iteración.
    ! 2. 'n = 1, 10000000': Formato (variable = inicio, fin, [paso]). Si se omite el paso, Fortran asume OBLIGATORIAMENTE un incremento de +1.
    do n = 1, 10000000

        suma_directa = suma_directa + (1.0_pr / real(n, pr))
        ! ANÁLISIS SINTÁCTICO RIGUROSO DE ESTA LÍNEA CRÍTICA:
        ! 1. '1.0_pr': El numerador DEBE ser un número real explícito con sufijo de precisión. (Si pusieras el entero '1', forzarías conversiones mixtas peligrosas).
        ! 2. 'real(n, pr)': FUNCIÓN INTRÍNSECA DE CONVERSIÓN (CASTING). 'n' es un entero, pero la suma exige reales. La función 'real()' toma la variable entera y la convierte en tiempo de ejecución a un número de punto flotante de la clase 'pr'. ¡Esto evita errores de división entera!

    end do
    ! REGLA SINTÁCTICA: Todo 'do' DEBE cerrarse con 'end do'.

    ! --- BUCLE 2: SUMA INVERSA (De menor a mayor aporte) ---
    do n = 10000000, 1, -1
    ! REGLA SINTÁCTICA DEL PASO NEGATIVO:
    ! Al indicar '-1' como tercer parámetro, el bucle comienza en el límite superior y decrementa en 1 por cada ciclo hasta llegar a 1.

        suma_inversa = suma_inversa + (1.0_pr / real(n, pr))

    end do

    ! --- CÁLCULO DE DIFERENCIA (Completando lo pedido en la guía) ---
    diferencia = abs(suma_directa - suma_inversa)
    ! SINTAXIS: 'abs()' es la función intrínseca para obtener el valor absoluto. Argumento entre paréntesis.

    ! --- SALIDA DE DATOS Y CONCLUSIÓN NUMÉRICA ---
    write(*,*) 'Suma de orden normal (1 a 10^7):  ', suma_directa
    write(*,*) 'Suma de orden inverso (10^7 a 1): ', suma_inversa
    write(*,*) 'Diferencia absoluta:              ', diferencia
    ! REGLA: Separación estricta de strings literales y variables numéricas por comas ','.

    write(*,*) '---------------------------------------------------'
    write(*,*) 'EXPLICACION NUMERICA:'
    write(*,*) 'La suma inversa es matematicamente mas precisa.'
    write(*,*) 'En la suma directa, al avanzar, sumamos fracciones'
    write(*,*) 'muy pequeñas (1/10^7) a un acumulador que ya es'
    write(*,*) 'muy grande. Por la longitud finita de la mantisa,'
    write(*,*) 'los digitos se truncan y se pierde informacion.'
    write(*,*) 'La suma inversa acumula los numeros pequeños primero.'

end program prob_12
! SINTAXIS: Cierre del bloque del ejecutable.
