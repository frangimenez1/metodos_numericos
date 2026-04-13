program prob_18
    ! Importamos una herramienta especial de Fortran para manejar números enteros gigantes.
    ! EXPLICACIÓN: Lo usaremos en el inciso c) porque los factoriales crecen rapidísimo.
    use iso_fortran_env, only: int64

    implicit none

    ! ========================================================================
    ! INCISO B: "Realice los cálculos en simple precisión" [cite: 121]
    ! ========================================================================
    ! Como el inciso b) nos exige esto explícitamente, creamos nuestra constante 'pr'.
    ! 'kind(1.0)' le dice a la computadora: "Usa la misma memoria que usas para un
    ! número decimal normal (32 bits)". Todo el código usará esto.
    integer, parameter :: pr = kind(1.0)


    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: n, k, n_max

    ! ========================================================================
    ! INCISO C (Parte 1): "Guarde en un vector de números enteros, las factoriales
    ! hasta 2n_max+1, siendo n_max=8" [cite: 125]
    ! ========================================================================
    ! 1. Como n_max es 8, entonces 2*(8)+1 = 17. Tenemos que calcular hasta 17!
    ! 2. El factorial de 17 es 355.687.428.096.000.
    ! 3. ¡EL PROBLEMA!: Un 'integer' normal en Fortran explota si pasa los 2 mil millones.
    ! POR ESO: Declaramos el vector usando 'int64' (entero de 64 bits), para que tenga
    ! memoria suficiente para guardar ese número monstruoso sin dar error.
    ! Declaramos de 0 a 17 porque matemáticamente existe el 0! (cero factorial).
    integer(int64), dimension(0:17) :: fact

    ! Variables para guardar el resultado de nuestras sumas y el valor analítico
    real(kind=pr) :: x, verdadero_valor, termino
    real(kind=pr) :: suma_directa, suma_inversa


    ! ========================================================================
    ! INCISO A: "Resuelva el problema para x=0.1" [cite: 120]
    ! ========================================================================
    ! Le asignamos 0.1 a la variable 'x'.
    ! Le ponemos '_pr' al final para cumplir con el inciso b (simple precisión).
    x = 0.1_pr
    n_max = 8

    ! Calculamos el valor real usando la calculadora interna de Fortran para luego comparar
    verdadero_valor = sin(x)


    ! ========================================================================
    ! INCISO C (Parte 2): Llenar el vector con un "do" [cite: 125]
    ! ========================================================================
    ! La guía nos dio una pista: "(Ayuda1: Utilice un "do" para ello)"[cite: 125].
    ! Por definición matemática, el factorial de cero es 1.
    fact(0) = 1_int64

    do k = 1, 17
        ! La guía dio otra pista: "(Ayuda2: preste atención a si está trabajando
        ! con enteros o con reales)"[cite: 125].
        ! POR ESO: Usamos int(k, int64) para decirle a Fortran: "Convierte el iterador 'k'
        ! en un entero gigante antes de multiplicarlo, para no mezclar tamaños de memoria".
        fact(k) = fact(k-1) * int(k, int64)
    end do


    ! ========================================================================
    ! PREPARACIÓN PARA EL INCISO G: "vaya guardando en un archivo (llamado
    ! seno.dat) los sucesivos pasos..." [cite: 129]
    ! ========================================================================
    ! Como nos pide guardar datos de la suma que vamos a hacer, OBLIGATORIAMENTE
    ! tenemos que abrir el archivo ANTES de empezar el bucle de suma.
    open(unit=10, file='seno.dat', status='replace')


    ! ========================================================================
    ! INCISO D: "Calcule la suma desde 0 hasta n_max de los términos en orden directo" [cite: 126]
    ! ========================================================================
    suma_directa = 0.0_pr

    ! Bucle en orden directo (empieza en 0, va subiendo de a 1 hasta n_max)
    do n = 0, n_max

        ! En la fórmula de Taylor, el exponente y el factorial son impares: (2n+1)
        k = 2*n + 1

        ! --- TRADUCCIÓN DE LA FÓRMULA DE TAYLOR A CÓDIGO ---
        ! Fórmula: (-1)^n / (2n+1)! * x^(2n+1)
        ! 1. Numerador: (-1.0_pr)**n -> Usamos -1 REAL para que la división no falle.
        ! 2. Denominador: real(fact(k), pr) -> Como nos advirtió la Ayuda 2 del inciso c,
        !    fact(k) es un número ENTERO. Si dividimos un Real por un Entero, Fortran
        !    hace desastres. POR ESO usamos la función real() para convertir el factorial
        !    en un número con coma temporalmente solo para hacer esta división.
        ! 3. Multiplicamos por x elevado a la k.

        termino = ((-1.0_pr)**n) / real(fact(k), pr) * (x**k)

        ! Acumulamos
        suma_directa = suma_directa + termino

        ! INCISO G (continuación): "... los sucesivos pasos de la suma y el error cometido
        ! (la diferencia con el verdadero valor)"[cite: 129].
        ! POR ESO: Escribimos en el canal 10 (el archivo seno.dat) el paso actual 'n',
        ! la suma que llevamos, y calculamos la diferencia restando el verdadero_valor.
        write(10, *) n, suma_directa, abs(suma_directa - verdadero_valor)

    end do

    ! Ya terminamos de cumplir el inciso g, así que cerramos el archivo por seguridad.
    close(10)


    ! ========================================================================
    ! INCISO E: "Calcule la suma de los términos en orden inverso
    ! (es decir, desde n_max hasta 0)" [cite: 127]
    ! ========================================================================
    suma_inversa = 0.0_pr

    ! Para ir al revés, OBLIGATORIAMENTE le agregamos un '-1' al final del 'do'.
    ! Le dice a la máquina: empieza en 8, termina en 0, dando pasos de -1.
    do n = n_max, 0, -1

        k = 2*n + 1

        ! La fórmula matemática del término es exactamente la misma que arriba
        termino = ((-1.0_pr)**n) / real(fact(k), pr) * (x**k)

        suma_inversa = suma_inversa + termino

    end do


    ! ========================================================================
    ! INCISO F: "Muestre por pantalla el resultado de ambas sumas y el
    ! verdadero valor de sin(x)" [cite: 128]
    ! ========================================================================
    write(*,*) 'Verdadero valor de sin(0.1): ', verdadero_valor
    write(*,*) 'Resultado de la suma Directa:', suma_directa
    write(*,*) 'Resultado de la suma Inversa:', suma_inversa

    ! Calculamos e imprimimos el error final para poder responder el inciso h)
    write(*,*) 'Error final suma Directa:    ', abs(suma_directa - verdadero_valor)
    write(*,*) 'Error final suma Inversa:    ', abs(suma_inversa - verdadero_valor)

end program prob_18
