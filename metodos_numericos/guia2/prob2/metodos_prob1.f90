module metodos
    use parametros
    implicit none

contains

    ! ========================================================================
    ! SUBRUTINA 1: MÉTODO DE BISECCIÓN (Inciso B)
    ! ========================================================================
    ! "Encontrar una raíz... utilizando el método de bisección"[cite: 13].
    subroutine biseccion_p2(funcion_elegida, a_in, b_in, tol_x, tol_f, raiz_final, iteraciones)

        ! --- EL "ENCHUFE" (INTERFACE) ---
        ! Como el Problema 2 pide usar este método con un polinomio específico[cite: 12],
        ! la interfaz permite que la subrutina sea genérica y reciba cualquier función.
        interface
            function funcion_elegida(x) result(res)
                import :: pr
                implicit none
                real(pr), intent(in) :: x
                real(pr)             :: res
            end function funcion_elegida
        end interface

        ! --- ARGUMENTOS DE ENTRADA Y SALIDA ---
        ! 'a_in' y 'b_in' definen el "intervalo [0:0.8]" exigido por la guía[cite: 12].
        real(pr), intent(in)  :: a_in, b_in, tol_x, tol_f
        real(pr), intent(out) :: raiz_final
        integer,  intent(out) :: iteraciones

        ! Variables locales (solo viven dentro de esta subrutina)
        real(pr) :: a, b, p, fa, fb, fp, err_rel_x, err_abs_f
        integer  :: iter

        ! --- PREPARACIÓN ---
        ! Hacemos la copia de seguridad: Destino = Origen (Lectura)
        a = a_in
        b = b_in
        fa = funcion_elegida(a)
        fb = funcion_elegida(b)

        ! Verificación del Teorema de Bolzano
        if (fa * fb > 0.0_pr) then
            write(*,*) "Error: El intervalo no encierra una raiz."
            return
        end if

        iter = 0
        ! Iniciamos el bucle. 'MAX_ITE' viene del módulo de parámetros[cite: 23].
        do while (iter < MAX_ITE)
            iter = iter + 1

            ! Cálculo del punto medio
            p = a + (b - a) / 2.0_pr
            fp = funcion_elegida(p)

            ! --- CÁLCULO DE ERRORES EXIGIDOS POR EL PROBLEMA 2 ---
            ! 1. "error relativo de 10^-6 o menos en x"
            err_rel_x = abs(p - a) / abs(p)

            ! 2. "un error absoluto de 10^-8 o menos en f"
            err_abs_f = abs(fp)

            ! --- CRITERIO DE DETENCIÓN ---
            ! Si se cumplen AMBAS condiciones, salimos del bucle ('exit').
            if (err_rel_x <= tol_x .and. err_abs_f <= tol_f) exit

            ! Reducción del intervalo a la mitad
            if (fa * fp < 0.0_pr) then
                b = p
                fb = fp
            else
                a = p
                fa = fp
            end if
        end do

        raiz_final = p
        iteraciones = iter

    end subroutine biseccion_p2


    ! ========================================================================
    ! SUBRUTINA 2: MÉTODO DE LA SECANTE (Inciso C)
    ! ========================================================================
    ! "Encontrar una raíz... utilizando el método de la secante"[cite: 14].
    subroutine secante(funcion_elegida, p0_in, p1_in, tol_x, tol_f, raiz_final, iteraciones)

        ! --- MISMA INTERFAZ (Contrato idéntico para la función) ---
        interface
            function funcion_elegida(x) result(res)
                import :: pr
                implicit none
                real(pr), intent(in) :: x
                real(pr)             :: res
            end function funcion_elegida
        end interface

        ! --- ARGUMENTOS ---
        ! Aquí los llamamos p0_in y p1_in siguiendo la convención matemática
        ! de puntos iniciales para la Secante[cite: 23].
        real(pr), intent(in)  :: p0_in, p1_in, tol_x, tol_f
        real(pr), intent(out) :: raiz_final
        integer,  intent(out) :: iteraciones

        ! Notarás que aquí también uso 'p', 'fp' e 'iter'.
        ! Al ser locales, no tienen nada que ver con los de la Bisección.
        real(pr) :: p0, p1, p, q0, q1, fp, err_rel_x, err_abs_f
        integer  :: iter

        ! --- INICIALIZACIÓN ---
        p0 = p0_in
        p1 = p1_in
        q0 = funcion_elegida(p0)
        q1 = funcion_elegida(p1)

        iter = 0
        do while (iter < MAX_ITE)
            iter = iter + 1

            ! --- FÓRMULA DE LA SECANTE ---
            ! A diferencia de la bisección, este método "salta" hacia la raíz usando una pendiente.
            p = p1 - q1 * (p1 - p0) / (q1 - q0)
            fp = funcion_elegida(p)

            ! --- MISMAS TOLERANCIAS DEL PROBLEMA 2 ---
            ! "error relativo de 10^-6 o menos en x y un error absoluto de 10^-8 o menos en f"
            err_rel_x = abs(p - p1) / abs(p)
            err_abs_f = abs(fp)

            if (err_rel_x <= tol_x .and. err_abs_f <= tol_f) exit

            ! --- ACTUALIZACIÓN DE PUNTOS ---
            ! El punto más viejo (p0) se descarta, el actual (p1) se vuelve el viejo,
            ! y el nuevo punto (p) se vuelve el actual.
            p0 = p1
            q0 = q1
            p1 = p
            q1 = fp
        end do

        raiz_final = p
        iteraciones = iter

    end subroutine secante

end module metodos
