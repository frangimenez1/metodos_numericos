    ! --- PROGRAMA PRINCIPAL: MULTIPLICACION DINAMICA ---

program prob_14
    use parametros
    use subrutinas
    ! SINTAXIS: Importa las definiciones de precision y la subrutina de calculo.
    implicit none

    integer :: n, i, j

    ! --- DECLARACION DE ARREGLOS DINAMICOS ---
    real(pr), dimension(:,:), allocatable :: matriz
    real(pr), dimension(:), allocatable   :: vector, resultado
    ! SINTAXIS ESTRICTA:
    ! 1. 'dimension(:,:)': Indica que es un arreglo de rango 2 (matriz). Los ':' actuan como placeholders porque no sabemos el tamaño aun.
    ! 2. 'allocatable': REGLA SINTÁCTICA CRÍTICA. Le dice al compilador que este arreglo NO tiene memoria asignada todavía. Se reservará en tiempo de ejecución.

    ! 1. Preguntar el valor de N
    write(*,*) 'Ingrese el tamano N para la matriz y el vector:'
    read(*,*) n

    ! 2. ASIGNACION DE MEMORIA
    allocate(matriz(n,n))
    allocate(vector(n))
    allocate(resultado(n))
    ! SINTAXIS 'allocate': Comando que pide al Sistema Operativo una cantidad 'n' de memoria.
    ! REGLA: Si intentas usar los arreglos ANTES de esta linea, el programa fallará con un error de segmentación.

    ! 3. Inicializar la matriz (Triangular superior con 3 en diagonal y 1 arriba)
    do i = 1, n
        do j = 1, n
            if (i == j) then
                matriz(i,j) = 3.0_pr
            else if (i < j) then
                matriz(i,j) = 1.0_pr
            else
                matriz(i,j) = 0.0_pr
            end if
        end do
    end do

    ! 4. Inicializar el vector (Posiciones pares=2, impares=3)
    do i = 1, n
        if (mod(i, 2) == 0) then
            vector(i) = 2.0_pr
        else
            vector(i) = 3.0_pr
        end if
    end do

    ! 5. LLAMADA A LA SUBRUTINA
    call multiplicar_mat_vec(n, matriz, vector, resultado)
    ! SINTAXIS 'call': REGLA OBLIGATORIA. Las subrutinas no se asignan (como res = sub...), se invocan mediante esta palabra clave.
    ! REGLA DE ARGUMENTOS: Deben coincidir en tipo, rango y orden con la definicion del modulo.

    ! 6. Imprimir el vector resultado
    write(*,*) 'El vector resultado de la multiplicacion es:'
    do i = 1, n
        write(*,*) resultado(i)
    end do

    ! 7. LIBERACION DE MEMORIA
    deallocate(matriz, vector, resultado)
    ! SINTAXIS 'deallocate': REGLA DE ORO. Libera la memoria utilizada. Es fundamental en programas cientificos que corren por horas para no agotar la RAM del sistema (Memory Leaks).

end program prob_14
