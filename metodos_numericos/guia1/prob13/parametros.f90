! --- MODULO DE PARAMETROS (Arquitectura de datos) ---
module parametros
! SINTAXIS: 'module' crea un espacio de nombres global.
! REGLA: El nombre del módulo ('parametros') debe ser único en todo el proyecto.

    implicit none
    ! REGLA: Se coloca inmediatamente después del nombre del módulo para que afecte a todo su contenido.

    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS ESTRICTA:
    ! 1. 'integer': Tipo de dato para el selector de precisión.
    ! 2. 'parameter': Atributo OBLIGATORIO para indicar que 'pr' es una constante de compilación. No puede cambiar su valor durante la ejecución.
    ! 3. '::': Doble dos puntos obligatorio por el uso del atributo 'parameter'.
    ! 4. 'kind(1.0)': Función que devuelve el identificador numérico de la precisión simple.

end module parametros
! SINTAXIS: Cierra el contenedor del módulo.
