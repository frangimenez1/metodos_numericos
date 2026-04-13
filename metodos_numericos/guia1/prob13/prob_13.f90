! --- PROGRAMA PRINCIPAL (Punto de entrada) ---
program prob_13
    use parametros
    use funciones
    ! REGLA SINTÁCTICA: Los 'use' van antes de 'implicit none'.
    ! Al usar 'funciones', el programa principal sabe que existe 'potencia' y cómo debe llamarla.

    implicit none

    real(pr) :: x
    integer :: i
    ! SINTAXIS: Usamos 'pr' que viene del módulo 'parametros'.

    write(*,*) 'Ingrese un numero real:'
    read(*,*) x

    ! --- USO DE FORMATOS EXPLÍCITOS ---
    write(*, '("Las 5 primeras potencias naturales de ", F4.0, " son:")') x
    ! ANÁLISIS DE SINTÁCTICO DEL FORMATO:
    ! 1. ' "..." ': El texto literal dentro del formato va entre comillas (si el formato usa comillas simples, el texto usa dobles).
    ! 2. 'F4.0': Descriptor de campo. 'F' para real, '4' espacios de ancho total, '0' decimales.

    write(*,*) '--------------------------------------------------'

    do i = 1, 5
        ! SINTAXIS DEL BUCLE: Variable 'i' desde 1 hasta 5 inclusive.

        write(*, '(F4.0, " ^ ", I1, " = ", F8.0)') x, i, potencia(x, i)
        ! ANÁLISIS DE SINTÁCTICO:
        ! 1. 'potencia(x, i)': Llamada a la función externa. Se le pasan los "argumentos verdaderos".
        ! 2. 'I1': Descriptor para un entero de 1 dígito de ancho.
        ! 3. 'F8.0': Reserva 8 espacios para el resultado final.
    end do

end program prob_13
