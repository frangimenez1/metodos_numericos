! --- MODULO DE PARAMETROS ---
module parametros
    implicit none
    ! REGLA: Define la precision simple (kind=4 o similar) de forma global.
    integer, parameter :: pr = kind(1.0)
end module parametros
