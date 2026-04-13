module funciones
    use parametros
    implicit none

contains

    ! ========================================================================
    ! INCISO A: "encontrar la solución positiva de la ecuación x^2 - 1 = 0"
    ! ========================================================================
    function f_a(x) result(y)
        ! SINTAXIS DE SEGURIDAD: El atributo 'intent(in)' es obligatorio.
        ! Garantiza que el método de bisección que usará esta función NO pueda
        ! modificar accidentalmente el valor de 'x' que le estamos pasando para evaluar.
        real(pr), intent(in) :: x

        ! SINTAXIS: La variable de salida se define con 'result(y)' en la firma.
        real(pr) :: y

        ! REGLA DE LITERALES: Usamos '1.0_pr' y no el entero '1'. Si restamos un
        ! entero a un real, la computadora hace un "casting" implícito que puede
        ! introducir basura numérica en el último bit de la mantisa.
        y = x**2 - 1.0_pr
    end function f_a


    ! ========================================================================
    ! INCISO B: "encontrar la menor solución positiva de la ecuación 2x=tan(x)"
    ! ========================================================================
    ! Matemáticamente, para buscar raíces debemos igualar a cero: f(x) = 2x - tan(x)
    function f_b(x) result(y)
        real(pr), intent(in) :: x
        real(pr) :: y

        ! SINTAXIS: 'tan()' es una función matemática intrínseca de Fortran.
        ! REGLA: El operador '*' es obligatorio; no podemos escribir '2x'.
        y = 2.0_pr * x - tan(x)
    end function f_b


    ! ========================================================================
    ! INCISO C: "encontrar una aproximación a la raíz de 3 ... Note que es la
    ! raíz positiva de la ecuación f(x) = x^2 - 3"
    ! ========================================================================
    function f_c(x) result(y)
        real(pr), intent(in) :: x
        real(pr) :: y
        y = x**2 - 3.0_pr
    end function f_c

end module funciones
