module funciones
    use parametros
    implicit none

contains

    ! ========================================================================
    ! DEFINICIÓN DEL POLINOMIO DEL PROBLEMA 2
    ! ========================================================================
    ! "Dado el siguiente polinomio: f(x) = -20x^6 - 3x^5 + 18x^4 - 10x^3 - 8x^2 + 3x + 2" [cite: 12]
    function f_p2(x) result(y)
        real(pr), intent(in) :: x
        real(pr) :: y

        ! SINTAXIS: Escribimos todos los coeficientes como reales (añadiendo .0_pr)
        ! para evitar conversiones mixtas con el exponente entero.
        y = -20.0_pr*x**6 - 3.0_pr*x**5 + 18.0_pr*x**4 - 10.0_pr*x**3 - 8.0_pr*x**2 + 3.0_pr*x + 2.0_pr
    end function f_p2

end module funciones
