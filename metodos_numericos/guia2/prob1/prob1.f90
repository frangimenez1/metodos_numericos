program prob1
    ! ========================================================================
    ! IMPORTACIÓN DE MÓDULOS (La base de la Programación Modular)
    ! ========================================================================
    ! REGLA SINTÁCTICA: 'use' debe ir antes de 'implicit none'.
    use parametros
    use funciones  ! Traemos TODAS las funciones matemáticas (f_a, f_b, f_c)
    use metodos    ! Traemos la subrutina de cálculo 'biseccion'
    implicit none

    ! --- DECLARACIÓN DE VARIABLES LOCALES ---
    ! SINTAXIS: Usamos 'pr' para forzar la doble precisión en todo el flujo de datos.
    real(pr) :: limite_izq, limite_der, tolerancia
    integer  :: maximo_vueltas
    real(pr) :: res_raiz, res_f
    integer  :: res_vueltas

    ! Configuración general compartida
    tolerancia = 1.0e-5_pr
    maximo_vueltas = 100

    ! ========================================================================
    ! INCISO A (Parte 1): x^2 - 1 = 0 en [0.5, 1.6]
    ! ========================================================================
    limite_izq = 0.5_pr
    limite_der = 1.6_pr

    write(*,*) "--- INCISO A (Intervalo 0.5 a 1.6) ---"

    ! REGLA SINTÁCTICA CRÍTICA PARA INTERFACES:
    ! "Sin paréntesis: Al pasar la función, se usa solo el nombre: call biseccion(f_a, ...),
    ! no call biseccion(f_a(), ...)".
    call biseccion(f_a, limite_izq, limite_der, tolerancia, maximo_vueltas, res_raiz, res_f, res_vueltas)

    ! CUMPLIMIENTO DE SALIDAS EXIGIDAS POR LA GUÍA:
    ! La guía pide estrictamente imprimir en pantalla estas 3 cosas:
    write(*,*) "1. Aproximacion final (pN): ", res_raiz
    write(*,*) "2. Valor final de f(pN):    ", res_f
    write(*,*) "3. Iteraciones realizadas:  ", res_vueltas
    write(*,*) "----------------------------------------"


    ! ========================================================================
    ! INCISO A (Parte 2): "¿Y si se comenzara con el intervalo [0.5, 1.5]...?"
    ! ========================================================================
    limite_izq = 0.5_pr
    limite_der = 1.5_pr

    write(*,*) "--- INCISO A (Intervalo 0.5 a 1.5) ---"
    call biseccion(f_a, limite_izq, limite_der, tolerancia, maximo_vueltas, res_raiz, res_f, res_vueltas)

    write(*,*) "1. Aproximacion final (pN): ", res_raiz
    write(*,*) "2. Valor final de f(pN):    ", res_f
    write(*,*) "3. Iteraciones realizadas:  ", res_vueltas
    write(*,*) "----------------------------------------"


    ! ========================================================================
    ! INCISO B: "encontrar la menor solución positiva de la ecuación 2x=tan(x)...
    ! intervalo [0.8, 1.4]"
    ! ========================================================================
    limite_izq = 0.8_pr
    limite_der = 1.4_pr

    write(*,*) "--- INCISO B: 2x - tan(x) = 0 ---"

    ! SINTAXIS: Reutilizamos la misma subrutina, pero le "enchufamos" la función f_b.
    call biseccion(f_b, limite_izq, limite_der, tolerancia, maximo_vueltas, res_raiz, res_f, res_vueltas)

    write(*,*) "1. Aproximacion final (pN): ", res_raiz
    write(*,*) "2. Valor final de f(pN):    ", res_f
    write(*,*) "3. Iteraciones realizadas:  ", res_vueltas
    write(*,*) "----------------------------------------"


    ! ========================================================================
    ! INCISO C: "encontrar una aproximación a la raíz de 3"
    ! ========================================================================
    ! Nota: La guía no da un intervalo en este inciso, pero en el Problema 5
    ! sugiere [0.0, 2.5] para este mismo cálculo.
    limite_izq = 0.0_pr
    limite_der = 2.5_pr

    write(*,*) "--- INCISO C: x^2 - 3 = 0 (Raiz de 3) ---"

    call biseccion(f_c, limite_izq, limite_der, tolerancia, maximo_vueltas, res_raiz, res_f, res_vueltas)

    write(*,*) "1. Aproximacion final (pN): ", res_raiz
    write(*,*) "2. Valor final de f(pN):    ", res_f
    write(*,*) "3. Iteraciones realizadas:  ", res_vueltas
    write(*,*) "----------------------------------------"

end program prob1
