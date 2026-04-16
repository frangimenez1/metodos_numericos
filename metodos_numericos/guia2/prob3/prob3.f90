program prob3
    use parametros
    use funciones
    use metodos
    implicit none

    !Como el programa tiene que tener un error relativo en x menor a 10^-6 y un error absoluto en u(x) menor a 10^-8. Entonces tengo que defnir las variables: tol_x, tol_f, err_x_final, err_f_final, iter_res

    !Tolerancias de entrada
    real(pr) :: tol_x, tol_f

    !Variables para almacenar lo que devuelven las subrutinas
    real(pr) :: raiz_res      ! Aca se va a almacenar pN
    integer  :: iter_res      ! Aca se va a almacenar el número de iteraciones
    real(pr) :: err_x_final   ! Aca se va a almacenar el error relativo final en x


    ! Variable para el cálculo final en y
    real(pr) :: err_f_final   ! Aca calculamos |u(pN)|


    !Entonces por el enunciado que dice que el programa tiene que tener un error relativo en x menor a 10^-6 y un error absoluto en u(x) menor a 10^-8.\
    tol_x = 1.0e-6_pr
    tol_f = 1.0e-8_pr



    write(*,*) "=========================================================="
    write(*,*) "       COMPARACION DE METODOS - PROBLEMA 3"
    write(*,*) "       u(x) = x^3 - 2x + 2 | Intervalo: [-2, -0.8]"
    write(*,*) "=========================================================="
    write(*,*) ""

   ! --- EJECUCIÓN: MÉTODO DE BISECCIÓN ---

    ! Llamo a la subrutina con sus 8 argumentos.
    call biseccion_p2(f_p3, -2.0_pr, -0.8_pr, tol_x, tol_f, raiz_res, iter_res, err_x_final)

    ! Calculo el error absoluto en f evaluando la raíz encontrada
    err_f_final = abs(f_p3(raiz_res))

    ! Muestro resultados en pantalla
    write(*,*) "    METODO: BISECCION"
    write(*,*) "    Iteraciones realizadas: ", iter_res
    write(*,*) "    Aproximacion final pN:  ", raiz_res
    write(*,*) "    Error relativo en x:    ", err_x_final
    write(*,*) "    Error absoluto |u(pN)|: ", err_f_final
    write(*,*) ""

    ! --- EJECUCIÓN: MÉTODO DE LA SECANTE ---

    ! Uso los límites del intervalo [-2, -0.8] como puntos p0 y p1.
    call secante(f_p3, -2.0_pr, -0.8_pr, tol_x, tol_f, raiz_res, iter_res, err_x_final)

    err_f_final = abs(f_p3(raiz_res))

    write(*,*) "    METODO: LA SECANTE"
    write(*,*) "    Iteraciones realizadas: ", iter_res
    write(*,*) "    Aproximacion final pN:  ", raiz_res
    write(*,*) "    Error relativo en x:    ", err_x_final
    write(*,*) "    Error absoluto |u(pN)|: ", err_f_final
    write(*,*) ""

    ! --- EJECUCIÓN: MÉTODO DE REGULA FALSI ---

    call regula_falsi(f_p3, -2.0_pr, -0.8_pr, tol_x, tol_f, raiz_res, iter_res, err_x_final)

    err_f_final = abs(f_p3(raiz_res))

    write(*,*) ">>> METODO: REGULA FALSI"
    write(*,*) "    Iteraciones realizadas: ", iter_res
    write(*,*) "    Aproximacion final pN:  ", raiz_res
    write(*,*) "    Error relativo en x:    ", err_x_final
    write(*,*) "    Error absoluto |u(pN)|: ", err_f_final
    write(*,*) "=========================================================="

end program prob3
