! --- MODULO DE FUNCIONES (Lógica de cálculo) ---
module funciones
    use parametros
    ! REGLA SINTÁCTICA CRÍTICA: La instrucción 'use' DEBE ser la primera línea dentro del módulo.
    ! Le permite a este archivo conocer qué es 'pr' sin tener que definirlo de nuevo.

    implicit none

contains
! REGLA SINTÁCTICA: 'contains' es un separador obligatorio.
! Indica que lo que viene a continuación son los subprogramas (funciones o subrutinas) que pertenecen a este módulo.

    function potencia(x, n)
    ! SINTAXIS: Define una función que devuelve un valor.
    ! REGLA: El resultado de la función se devuelve a través de una variable interna que DEBE llamarse igual que la función ('potencia').

        real(pr), intent(in) :: x
        integer, intent(in) :: n
        ! SINTAXIS DE SEGURIDAD (intent):
        ! 'intent(in)': Atributo que le dice al compilador que estas variables son de SOLO LECTURA.
        ! Si intentaras modificar 'x' dentro de la función, el compilador daría un error. Es una excelente práctica de programación.

        real(pr) :: potencia
        ! SINTAXIS: Aquí declaras el tipo de dato que va a devolver la función.

        potencia = x ** n
        ! SINTAXIS: Operador de potencia (doble asterisco).

        return
        ! SINTAXIS: Instrucción que indica que el control vuelve al programa que llamó a la función.

    end function potencia
    ! SINTAXIS: Cierre del bloque de la función.

end module funciones
