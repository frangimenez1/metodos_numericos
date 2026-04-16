module metodos
    use parametros
    !Despues de traer los modulos que quiero usar, pongo el implicit none y despues el contains
    implicit none

contains

    !Metodo de biseccion
    subroutine biseccion_p2(funcion_elegida, a_in, b_in, tol_x, tol_f, raiz_final, iteraciones, err_x_out)

        interface
            function funcion_elegida(x) result(res)
                import :: pr
                implicit none
                real(pr), intent(in) :: x
                real(pr)             :: res
            end function funcion_elegida
        end interface

        real(pr), intent(in)  :: a_in, b_in, tol_x, tol_f
        real(pr), intent(out) :: raiz_final
        integer,  intent(out) :: iteraciones
        real(pr), intent(out) :: err_x_out  ! ACA ALMACENO LOS DATOS DE SALIDA PARA EL ERROR EN X

        real(pr) :: a, b, p, fa, fb, fp, err_rel_x, err_abs_f
        integer  :: iter

        a = a_in
        b = b_in
        fa = funcion_elegida(a)
        fb = funcion_elegida(b)

        if (fa * fb > 0.0_pr) then
            write(*,*) "Error en Biseccion: El intervalo no encierra una raiz."
            return
        end if

        ! Abro el archivo específico para este método
        open(unit=11, file='salida_bisec.dat', status='replace')

        iter = 0
        do while (iter < MAX_ITE)
            iter = iter + 1

            p = a + (b - a) / 2.0_pr
            fp = funcion_elegida(p)

            ! Errores (Uso las fórmulas del Problema 1 para bisección)
            err_abs_f = abs(fp)
            err_rel_x = abs(b - a) / abs(a + b)

            ! Escibo en archivo (Inciso a: i, pi, f(pi), Ea, Er)
            write(11, '(I5, 4E20.12)') iter, p, fp, err_abs_f, err_rel_x

            if (err_rel_x <= tol_x .and. err_abs_f <= tol_f) exit

            if (fa * fp < 0.0_pr) then
                b = p
                fb = fp
            else
                a = p
                fa = fp
            end if
        end do

        close(11)

        ! PONGO LOS DATOS EN LAS VARIABLES DE SALIDA PARA EL PROGRAMA PRINCIPAL
        raiz_final  = p
        iteraciones = iter
        err_x_out   = err_rel_x  ! Guardo el último error calculado

    end subroutine biseccion_p2

    !----------------------------------------------------------------------------------------------
    !----------------------------------------------------------------------------------------------

    !Metodo de la secante

    subroutine secante(funcion_elegida, p0_in, p1_in, tol_x, tol_f, raiz_final, iteraciones, err_x_out)

        interface
            function funcion_elegida(x) result(res)
                import :: pr
                implicit none
                real(pr), intent(in) :: x
                real(pr)             :: res
            end function funcion_elegida
        end interface

        real(pr), intent(in)  :: p0_in, p1_in, tol_x, tol_f
        real(pr), intent(out) :: raiz_final
        integer,  intent(out) :: iteraciones
        real(pr), intent(out) :: err_x_out  ! ACA ALMACENO LOS DATOS DE SALIDA PARA EL ERROR EN X

        real(pr) :: p0, p1, p, q0, q1, fp, err_rel_x, err_abs_f
        integer  :: iter

        p0 = p0_in
        p1 = p1_in
        q0 = funcion_elegida(p0)
        q1 = funcion_elegida(p1)

        ! Abro el archivo específico para este método
        open(unit=12, file='salida_secan.dat', status='replace')

        iter = 0
        do while (iter < MAX_ITE)
            iter = iter + 1

            p = p1 - q1 * (p1 - p0) / (q1 - q0)
            fp = funcion_elegida(p)

            ! Errores de la secante
            err_abs_f = abs(fp)
            err_rel_x = abs(p - p1) / abs(p)

            ! Escribo en archivo (Inciso a)
            write(12, '(I5, 4E20.12)') iter, p, fp, err_abs_f, err_rel_x

            if (err_rel_x <= tol_x .and. err_abs_f <= tol_f) exit

            p0 = p1
            q0 = q1
            p1 = p
            q1 = fp
        end do

        close(12)

        ! PONGO LOS DATOS A LAS VARIABLES DE SALIDA PARA EL PROGRAMA PRINCIPAL
        raiz_final  = p
        iteraciones = iter
        err_x_out   = err_rel_x

    end subroutine secante

    !------------------------------------------------------------------------------------------------
    !------------------------------------------------------------------------------------------------




    !Medotodo regula fasi

    subroutine regula_falsi(funcion_elegida, a_in, b_in, tol_x, tol_f, raiz_final, iteraciones, err_x_out)

    !ETAPA 2: DEFINO VARIABLES Y LE DOY SUS CARACTERISTICAS

    !Como tengo que la primer variable de la subrutina va a contener una funcion, entonces uso el interface

    interface

        function funcion_elegida(x) result(res)

        !Esto me dice que estoy creando la interface para la variable funcion_elegida que esta en la subrutina, entonces tengo que decirle la precision, que variables se van a usar, cuales son in, cuales son out. ADEMAS, COMO COMO VOY A DEFINIR Y TRATAR CON VARIABLES, USO IMPLICIT NONE

            import :: pr
            implicit none
            real(pr), intent(in) :: x
            real(pr)             :: res

        end function

        end interface

        ! Ahora si, definos las otras variables de la subrutina
        !Lo que defino como los extremos de los intervalos, siempre son real(pr), intent(in), la raiz final siempre es real(pr), intent(out), y siempre el numero de iteraciones es entero, integer, intent(out)

        real(pr), intent(in) :: a_in, b_in, tol_x, tol_f
        real(pr), intent(out) :: raiz_final
        integer, intent(out) :: iteraciones
        real(pr), intent(out) :: err_x_out ! ACA ALMACENO LOS DATOS DE SALIDA PARA EL ERROR EN X

        !Defino las variables locales, las que van a almacenar los cambios que vayan teniendo las variables intent(in) para que asi se vayan achicando los intervalos dividiendolos por 2 en el caso de la biseccion, en la secante es mover los extremos mirando cuanto te moviste desde el intento anterior y asi


        real(pr) :: a, b, p, p_viejo, fa, fb, fp, error_rel_x, error_abs_f
        integer :: iter


        ! Le asigno las variables de la subrutina

        a = a_in
        b = b_in
        fa = funcion_elegida(a)
        fb = funcion_elegida(b)

        !Siempre despues de definir las variables que son las que van a permitir que se muevan los extremos de los intervalos, lo que hago es comprobar si entre los intervalos existe una raiz, entonces veo si hay un cambio de signo evaluando la funcion en los dos extremos, si hay cambio de signo hay raiz, y si no hay cambio de signo, entonces no hay raiz

        if(fa*fb > 0.0_pr) then
            write(*,*) 'Error: No hay raices en el intervalo'
            return
        end if

        !INCISO A: CREACION DEL ARCHIVO CON 5 COLUMNAS
        !Crear un archvio que contenga cinco columnas para todas las iteraciones: i, p_i, f(p_i), E_a (Eror absoluto), E_r (Error relativo) con 12 cifras (uso pr)

        open(unit=13, file='salida_regula.dat', status='replace')

        !PASO 1: Marco que el numero de iteraciones este en 0 a la hora de empezar
        iter = 0
        p_viejo = a !Pongo esto para que asi en la primer vuelta, empice tomando al extremo a como el punto viejo y poder calcular el error relativo en la primer vuelta

        !PASO 2:Me aseguro de que el numero de iteraciones siempre sea menor a un numero MAXIMO DE ITERACIONES para que asi si no encuentra nada, no continue infinitimante buscando

        do while (iter < MAX_ITE)
            iter = iter + 1

            !PASO 3: Pongo la formula del metodo que estoy usando, en este caso es de regula fasi, que es como la de la secante, pero usando los extremos a y b

            p = b - fa * (b-a) / (fb - fa) !Este es el punto entre los dos extremos del intervalo
            fp = funcion_elegida(p) !Esta es la funcion evaluada en ese punto p entre los extremos de los intervalos


            !PASO 4: CALCULO DE ERRORES

            !Error rabsoluto en f: E_a = |u(p_i)|: RECORDAR Error absoluto es en el eje y, entonces por eso es el valor absoluto de la funcion evaluada en un punto p entre los dos extremos, que el enunciado me hace ponerlo como i.

            error_abs_f = abs(fp)

            !Eror relativo en x estimado: |p_nuevo - p_viejo| / |p_nuevo| Si la diferencia entre donde estoy parado p_nuevo y donde esatba antes p_viejo es casio 0, entonces significa que el metodo ya no se esta moviendo, osea encontro la raiz

            !Uso esta definicion general para que sea justa la comparacion entre metodos

            ! CUIDADO CON ESTO: Si el bucle arranca y estoy en la vuelta 1 (iter = 1), la maquina calcula la formula de regula falsi por primera vez y encuentra el primer p, ahora tiene que calcular el eror, entonces intenta aplciar la formula abs(p-p_viejo) / abs(p) PERO HAY UN PROBLEMA, como es la priemer vuelta no existe un punto anterior, entonces no hay un p_viejo, entonces tengo que hacer lo siguiente

            if (iter == 1) then
                error_rel_x = 1.0_pr !Caso unico por ser la primera vuelta

            else !Apartir de la segunda vuelta, que use la formula formal
                error_rel_x = abs(p-p_viejo) / abs(p)

            end if


            !Escritura del inciso a) '5 columnas,........... con 12 cifras significativas para los reales'
            !Las 5 columnas se refiere a como se va a ver el texto dentro del archivo salida_regula.dat


            write(13,'(I5, 4E20.12)') iter, p, fp, error_abs_f, error_rel_x

            !13: Archivo del open unit=13
            !I5: I = Integer (entero), 5 = significa 'Reserva exactamente 5 espacios de ancho' en el archvio de texto
            !4E20.12: 4(El multiplicador) = significa, 'repeti el formato que sigue 4 veces' Como ya imprimi iter con I5, me queda 4 variables (p,fp, err_abs, err_real) Para asi no tener que definir E20.12 para cada uno de esos 4
            !E: E es la notacion cientifa
            !20 Ancho total: Este dice 'La columna va a ocupar un ancho de 20 caracteres en el archivo de texto'
            !.12 = cifras decimales, osea 12 cifras despues de la coma


            !Criterio de Detencion

            if (error_rel_x < tol_x .and. error_abs_f < tol_f) exit

            !Esto me dice, si la distancia en la que estoy parado ahora (el error) es < que la distancia maxima que me permiten tolerar (tol) entonces significa que llegue al destino, entonces sali del bucle (exit)


            !Actualizo ahora los extremos del intervalo
            if (fa * fp < 0.0_pr) then !Si la funcion evaluada en el extremo a es menor a la funcion evaluada en el punto p entonces
                b = p !el extremo p se convierte ahora en mi neuvo extremo b
                fb = fp !la funcion evaluado en el extremo b pasa a ser mi funcion evaluada en el extremo p
            else !sino pasa que fa * fp < 0.0_pr entonces
                a = p !p pasa a ser el nuevo punto de extremo
                fa = fp
            end if

            p_viejo = p !Con esto estoy guardando el p actual para la proxima el error en la siguiente uelta

        end do

        close(13) !Cierro el archvio 13 que habia abierto con el open unit

        !PONGO LOS DATOS A LAS VARIABLES DE SALIDA PARA EL PROGRAMA PRINCIPAL

        raiz_final = p
        iteraciones = iter
        err_x_out = error_rel_x

    end subroutine regula_falsi

end module metodos


