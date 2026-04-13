module parametros
    implicit none

    ! ========================================================================
    ! JUSTIFICACIÓN MATEMÁTICA PARA LA DOBLE PRECISIÓN
    ! ========================================================================
    ! El Problema 1 de la Guía 2 exige explícitamente en su salida:
    ! "con 12 cifras significativas para los reales".
    ! Como vimos en los apuntes sobre errores, la simple precisión (32 bits)
    ! solo garantiza unos 7 dígitos significativos. Para lograr 12,
    ! OBLIGATORIAMENTE debemos usar doble precisión (64 bits).
    !
    ! SINTAXIS ESTRICTA: 'kind(1.d0)' le dice al compilador que asigne
    ! el tamaño de memoria correspondiente a un número 'double' a la constante 'pr'.
    integer, parameter :: pr = kind(1.d0)

end module parametros
