! --- MODULO DE SUBRUTINAS ---
module subrutinas
    use parametros
    implicit none

contains

    subroutine multiplicar_mat_vec(n, mat, vec, res)
    ! SINTAXIS: 'subroutine' define un bloque de codigo ejecutable que se invoca con 'call'.
    ! REGLA: Los argumentos (n, mat, vec, res) se llaman "argumentos ficticios".

        integer, intent(in) :: n
        real(pr), dimension(n,n), intent(in) :: mat
        real(pr), dimension(n), intent(in)   :: vec
        ! SINTAXIS DE SEGURIDAD 'intent(in)':
        ! Indica que la matriz y el vector son de entrada; la subrutina tiene prohibido modificarlos.

        real(pr), dimension(n), intent(out)  :: res
        ! SINTAXIS 'intent(out)':
        ! Indica que este arreglo es donde se guardara el resultado. Al entrar a la subrutina, su contenido es indefinido.

        integer :: i, j ! Variables locales para los bucles

        ! --- LOGICA DE MULTIPLICACION MATRIZ-VECTOR ---
        ! Inicializamos el vector resultado en cero antes de acumular
        res = 0.0_pr

        do i = 1, n
            do j = 1, n
                ! REGLA MATEMATICA: res(i) = sumatoria(mat(i,j) * vec(j))
                res(i) = res(i) + mat(i,j) * vec(j)
            end do
        end do

    end subroutine multiplicar_mat_vec
    ! SINTAXIS: Cierre obligatorio del bloque de la subrutina.

end module subrutinas
