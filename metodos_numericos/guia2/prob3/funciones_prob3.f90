module funciones
    use parametros
    implicit none

! Cuando definio funciones, uso contains

contains

!Funcion del problema 3

    function f_p3(x) result(y)
        real(pr), intent(in) :: x
        real(pr)             :: y

        y = x**3 - 2.0_pr * x + 2.0_pr
    end function f_p3

end module funciones
