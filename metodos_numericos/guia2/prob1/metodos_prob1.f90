module metodos
    use parametros
    implicit none

contains

    ! ========================================================================
    ! DEFINICIÓN DE LA SUBRUTINA BÁSICA (El motor del Problema 1)
    ! ========================================================================
    subroutine biseccion(funcion_elegida, a_in, b_in, tol, max_iter, raiz_final, f_final, iteraciones_totales)

        ! ========================================================================
        ! REGLA SINTÁCTICA CRÍTICA: INTERFACES ABSTRACTAS
        ! ========================================================================
        ! Según el apunte, para que esta subrutina reciba "una función
        ! diferente cada vez que se la llama" (como f_a, f_b o f_c), necesitamos
        ! especificar su firma.
        ! Si no usamos el bloque 'interface', el compilador no sabrá qué tipos de
        ! datos entran y salen de 'funcion_elegida', generando un error de seguridad.
        interface
            function funcion_elegida(x) result(res)
                ! SINTAXIS: 'import :: pr' es vital aquí. Le permite a la interfaz
                ! "ver" la constante 'pr' que definimos en el módulo de arriba,
                ! ya que las interfaces actúan como cajas cerradas aisladas del resto.
                import :: pr
                implicit none
                real(pr), intent(in) :: x
                real(pr)             :: res
            end function funcion_elegida
        end interface

        ! --- DECLARACIÓN DE ARGUMENTOS DE ENTRADA Y SALIDA ---
        ! 'intent(in)': Solo lectura. Datos que el usuario nos provee.
        real(pr), intent(in)  :: a_in, b_in, tol
        integer,  intent(in)  :: max_iter

        ! 'intent(out)': Escritura. Donde volcaremos los resultados finales.
        real(pr), intent(out) :: raiz_final, f_final
        integer,  intent(out) :: iteraciones_totales

        ! --- VARIABLES LOCALES DE CÁLCULO ---
        ! Estas variables mueren cuando termina la subrutina.
        real(pr) :: a, b, p, fa, fb, fp, err_abs, err_rel
        integer  :: iter

        ! --- INICIALIZACIÓN ---
        a = a_in
        b = b_in

        ! Invocamos a la función que nos pasaron por argumento para evaluar los extremos
        fa = funcion_elegida(a)
        fb = funcion_elegida(b)

        ! ========================================================================
        ! REGLA MATEMÁTICA DEL MÉTODO DE BISECCIÓN (Teorema de Bolzano)
        ! ========================================================================
        ! Para asegurar que existe al menos una raíz en el intervalo [a, b],
        ! la función debe cruzar el eje X (cambiar de signo).
        ! Si multiplicamos f(a) * f(b) y da mayor a cero, significa que ambos
        ! tienen el mismo signo (+*+ = + o -*- = +). El método fallará.
        if (fa * fb > 0.0_pr) then
            write(*,*) "Error: El intervalo no encierra una raiz."
            raiz_final = 0.0_pr
            return ! 'return' aborta la ejecución de la subrutina instantáneamente.
        end if

        ! ========================================================================
        ! PREPARACIÓN DE SALIDA: "archivo con cinco columnas"
        ! ========================================================================
        ! Abrimos el archivo antes del bucle. Usamos 'status=replace' para que,
        ! si corremos el programa varias veces con distintas funciones, se
        ! sobreescriba el archivo y no se mezclen los datos viejos con los nuevos.
        open(unit=10, file='salida_biseccion.dat', status='replace')

        iter = 0
        ! Bucle iterativo de control general
        do while (iter < max_iter)
            iter = iter + 1

            ! SINTAXIS: Cálculo del punto medio del intervalo
            p = a + (b - a) / 2.0_pr
            fp = funcion_elegida(p)

            ! ========================================================================
            ! CÁLCULO DE ERRORES (Definiciones literales de la guía)
            ! ========================================================================
            ! " |b-a|/2 (error absoluto) "
            err_abs = abs(b - a) / 2.0_pr

            ! " |b-a|/|a+b| (error relativo) "
            err_rel = abs(b - a) / abs(a + b)

            ! ========================================================================
            ! ESCRITURA EN ARCHIVO CON FORMATO ESTRICTO DE 12 CIFRAS
            ! ========================================================================
            ! La guía exige: "con 12 cifras significativas para los reales".
            ! Por esto, ESTÁ PROHIBIDO usar formato libre '(*,*)'.
            ! SINTAXIS DE FORMATO EXPLÍCITO: '(I5, 4E20.12)'
            !   - I5: Reserva 5 espacios en blanco para el número entero (iter).
            !   - 4: Indica que el siguiente formato se repite 4 veces (para p, fp, err_abs, err_rel).
            !   - E20.12: Notación científica (E). Ocupa 20 caracteres de ancho total,
            !             y fuerza a que haya EXACTAMENTE 12 decimales visibles obligatoriamente.
            write(10, '(I5, 4E20.12)') iter, p, fp, err_abs, err_rel

            ! ========================================================================
            ! CRITERIO DE DETENCIÓN (Incisos a, b, c)
            ! ========================================================================
            ! La guía pide detenerse: "con un error (relativo en x y absoluto en y) menor a 10^-5".
            ! SINTAXIS LÓGICA: Evaluamos si AMBOS errores cumplieron la tolerancia usando '.and.'.
            ! 'exit' rompe el bucle 'do while' inmediatamente sin esperar a que cambie 'iter'.
            if (err_abs < tol .and. err_rel < tol) exit

            ! ========================================================================
            ! ACTUALIZACIÓN DEL INTERVALO
            ! ========================================================================
            if (fa * fp < 0.0_pr) then
                ! Si el producto es negativo, el cruce está en la mitad izquierda [a, p].
                ! Movemos el límite derecho 'b' hacia el medio 'p'.
                b = p
                fb = fp
            else
                ! Si no, el cruce está en la mitad derecha [p, b].
                ! Movemos el límite izquierdo 'a' hacia el medio 'p'.
                a = p
                fa = fp
            end if

        end do

        ! REGLA DE ORO DE SISTEMAS: Cerrar el archivo para liberar la RAM.
        close(10)

        ! --- ASIGNACIÓN DE RESULTADOS FINALES ---
        ! Volcamos los últimos valores locales en las variables 'intent(out)'
        ! para que viajen de vuelta al programa principal.
        raiz_final = p
        f_final = fp
        iteraciones_totales = iter

    end subroutine biseccion
end module metodos
