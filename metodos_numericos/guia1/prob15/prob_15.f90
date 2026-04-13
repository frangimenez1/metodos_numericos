! --- SOLUCIÓN AL PROBLEMA 15: LECTURA/ESCRITURA DE ARCHIVOS Y ESTADÍSTICA ---

program prob_15
! SINTAXIS: Inicia el bloque ejecutable.

    implicit none
    ! REGLA DE ORO: Declaración manual estricta.

    ! --- DEFINICIÓN DE PRECISIÓN (Agregado para rigor) ---
    integer, parameter :: pr = kind(1.0)

    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: n, i
    real(kind=pr), dimension(:), allocatable :: x
    ! SINTAXIS ESTRICTA: Vector dinámico 'x' forzado a precisión 'pr'.
    real(kind=pr) :: suma_x, promedio, suma_varianza, desviacion

    ! 1. ENTRADA ESTÁNDAR
    write(*,*) 'Ingrese el numero de datos a procesar:'
    read(*,*) n

    ! 2. ASIGNACIÓN DINÁMICA
    allocate(x(n))
    ! REGLA: OBLIGATORIO pedir la memoria RAM antes de intentar guardar datos en 'x'.

    ! 3. APERTURA Y LECTURA DE ARCHIVO EXTERNO
    open(unit=10, file='datos1.dat', status='old', action='read')
    ! ANÁLISIS SINTÁCTICO RIGUROSO DE 'OPEN':
    ! 1. 'open()': Comando para abrir un flujo de comunicación (stream) con el disco duro. Argumentos separados por comas.
    ! 2. 'unit=10': REGLA CRÍTICA. Le asignas un número entero (canal) a este archivo. Fortran usará este '10' de ahora en adelante para referirse a él. (Se aconseja usar números mayores a 9, ya que 5 y 6 suelen estar reservados para teclado y pantalla).
    ! 3. 'file='datos1.dat'': El nombre exacto del archivo. DEBE ir entre comillas.
    ! 4. 'status='old'': Atributo de seguridad. Le dice al compilador "este archivo YA DEBE EXISTIR". Si no existe, el programa aborta y no crea uno en blanco por error.
    ! 5. 'action='read'': Atributo de seguridad. Bloquea el archivo en modo "solo lectura". Si intentas hacer un 'write' en la unidad 10, dará error.

    do i = 1, n
        read(10, *) x(i)
        ! SINTAXIS DE LECTURA DE ARCHIVO:
        ! A diferencia de 'read(*,*)' (teclado), aquí usamos 'read(10, *)'.
        ! Le ordenamos: "Lee desde el canal 10 (datos1.dat), con formato libre (*), y guárdalo en la posición i del vector".
        ! REGLA: Cada vez que se ejecuta un 'read', Fortran lee una línea del archivo y automáticamente avanza a la siguiente.
    end do

    close(10)
    ! SINTAXIS ESTRICTA: 'close' libera el canal de comunicación.
    ! REGLA DE ORO: NUNCA dejes un archivo abierto. Consume recursos del OS y puede corromperse.

    ! 4. CÁLCULO DEL PROMEDIO
    suma_x = 0.0_pr
    ! SINTAXIS: Inicialización con precisión.
    do i = 1, n
        suma_x = suma_x + x(i)
    end do
    promedio = suma_x / real(n, pr)
    ! SINTAXIS: Casting expl
