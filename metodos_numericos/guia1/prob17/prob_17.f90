! --- SOLUCIÓN AL PROBLEMA 17: ACUMULACIÓN DE ERRORES (IEEE 754) ---

program prob_17
! SINTAXIS: Inicio del bloque de ejecución.

    implicit none
    ! REGLA DE ORO: Declaración explícita.

    ! --- DEFINICIÓN ESTRICTA DE PRECISIÓN SIMPLE ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS: Obligamos al uso de precisión simple (Float32). La mantisa tendrá exactamente 24 bits (aprox. 7 decimales significativos).

    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: n, m
    real(kind=pr) :: res_a, res_b, res_c, suma_interna
    real(kind=pr) :: error_parcial_b, error_parcial_c
    real(kind=pr) :: error_relativo_b, error_relativo_c
    ! SINTAXIS: Todo debe operar estrictamente bajo la lupa de la clase 'pr'.

    ! --- A) MULTIPLICACIÓN DIRECTA (Valor Teórico) ---
    res_a = 1000000.0_pr * 0.1_pr
    ! REGLA DE LITERALES (CRÍTICA AQUÍ):
    ! Escribir '0.1' en Fortran es peligroso en cálculo numérico. El número 0.1 NO TIENE una representación exacta en binario (es periódico: 0.000110011...). Al forzar el sufijo '_pr', nos aseguramos de que se cargue en memoria truncado exactamente a los 24 bits que estipula la teoría.

    ! --- PREPARACIÓN DE ARCHIVOS DE SALIDA ---
    open(unit=10, file='errores_b.dat', status='replace')
    open(unit=20, file='errores_c.dat', status='replace')
    ! SINTAXIS: 'status="replace"' es ideal aquí. Si corres el programa varias veces probando cosas, siempre sobreescribirá el archivo limpiando datos viejos.

    ! --- B) SUMA DIRECTA (Acumulación Lineal) ---
    res_b = 0.0_pr
    do n = 1, 1000000

        res_b = res_b + 0.1_pr
        ! LÓGICA DE MÁQUINA: Aquí ocurre el desastre. A medida que 'res_b' crece (por ejemplo, cuando llega a 1000.0), su exponente binario se hace grande. Para sumarle el minúsculo 0.1, el procesador debe "alinear" las comas. Al hacerlo, desplaza los bits del 0.1 hacia la derecha, haciendo que sus últimos dígitos se caigan del límite de los 24 bits de la mantisa. ¡Se pierde información en CADA suma!

        ! Muestreo cada 1000 iteraciones
        if (mod(n, 1000) == 0) then
            error_parcial_b = abs(res_b - (real(n, pr) * 0.1_pr))
            ! SINTAXIS: 'abs()' valor absoluto. 'real(n, pr)' casting explícito para evitar mezclar enteros con flotantes antes de multiplicar.
            write(10, *) n, error_parcial_b
        end if
    end do

    ! --- C) SUMA ANIDADA (Algoritmo de Bloques) ---
    res_c = 0.0_pr
    do m = 1, 1000
        suma_interna = 0.0_pr

        do n = 1, 1000
            suma_interna = suma_interna + 0.1_pr
        end do
        ! LÓGICA DE MÁQUINA: Este bucle interno solo suma hasta 100. El acumulador 'suma_interna' nunca se hace tan monstruosamente grande como para obligar al 0.1 a perder demasiados bits.

        res_c = res_c + suma_interna
        ! LÓGICA DE MÁQUINA: Aquí sumamos fragmentos de ~100 a un acumulador que crece hasta 100,000. Como los órdenes de magnitud son más cercanos, la alineación de mantisas es mucho menos destructiva.

        error_parcial_c = abs(res_c - (real(m * 1000, pr) * 0.1_pr))
        write(20, *) m * 1000, error_parcial_c
    end do

    ! --- CIERRE SEGURO ---
    close(10)
    close(20)

    ! --- CÁLCULO DE ERRORES RELATIVOS ---
    error_relativo_b = abs(res_b - res_a) / res_a
    error_relativo_c = abs(res_c - res_a) / res_a

    ! --- SALIDA POR PANTALLA ---
    write(*,*) '-----------------------------------------'
    write(*,*) 'Valor A (Multiplicacion) :', res_a
    write(*,*) 'Valor B (Suma lineal)    :', res_b
    write(*,*) 'Valor C (Suma en bloques):', res_c
    write(*,*) '-----------------------------------------'
    ! Al compilar y ejecutar, verás que el Error B roza el 1% de desviación, mientras que el Error C es radicalmente menor.
    write(*,*) 'Error relativo en B      :', error_relativo_b * 100.0_pr, ' %'
    write(*,*) 'Error relativo en C      :', error_relativo_c * 100.0_pr, ' %'

end program prob_17
