program prob2
    ! ========================================================================
    ! 1. IMPORTACIÓN DE MÓDULOS (La base de la organización)
    ! ========================================================================
    ! Traemos la precisión 'pr' y la constante 'MAX_ITE'[cite: 1].
    use parametros
    ! Traemos el polinomio f(x) definido para este problema[cite: 12].
    use funciones
    ! Traemos las dos herramientas: 'biseccion_p2' y 'secante'.
    use metodos

    implicit none

    ! --- DECLARACIÓN DE VARIABLES ---
    ! Usamos 'pr' para asegurar las 12 cifras significativas pedidas[cite: 4].
    real(pr) :: tol_x, tol_f
    real(pr) :: raiz_bis, raiz_sec
    integer  :: it_bis, it_sec

    ! ========================================================================
    ! 2. CONFIGURACIÓN DE TOLERANCIAS (Inciso B y C)
    ! ========================================================================
    ! "determinar la raíz con un error relativo de 10^-6 o menos en x
    ! y un error absoluto de 10^-8 o menos en f".
    tol_x = 1.0e-6_pr
    tol_f = 1.0e-8_pr

    write(*,*) "--- RESOLVIENDO PROBLEMA 2 ---"
    write(*,*) "Intervalo de busqueda: [0.0 : 0.8]"
    write(*,*) "---------------------------------------"

    ! ========================================================================
    ! 3. EJECUCIÓN DEL INCISO B: MÉTODO DE BISECCIÓN
    ! ========================================================================
    ! Como el inciso b) pide bisección[cite: 13], llamamos a su subrutina.
    ! Le pasamos 'f_p2' por el enchufe de la interfaz.
    call biseccion_p2(f_p2, 0.0_pr, 0.8_pr, tol_x, tol_f, raiz_bis, it_bis)

    ! Imprimimos los resultados que pide la guía[cite: 5, 6].
    write(*,*) "METODO DE BISECCION:"
    write(*,*) "  > Raiz encontrada: ", raiz_bis
    write(*,*) "  > Iteraciones:     ", it_bis
    write(*,*) " "

    ! ========================================================================
    ! 4. EJECUCIÓN DEL INCISO C: MÉTODO DE LA SECANTE
    ! ========================================================================
    ! El inciso c) pide el método de la secante[cite: 14].
    ! Usamos los mismos límites del intervalo [0, 0.8] como puntos iniciales p0 y p1.
    call secante(f_p2, 0.0_pr, 0.8_pr, tol_x, tol_f, raiz_sec, it_sec)

    write(*,*) "METODO DE LA SECANTE:"
    write(*,*) "  > Raiz encontrada: ", raiz_sec
    write(*,*) "  > Iteraciones:     ", it_sec
    write(*,*) "---------------------------------------"

    ! ========================================================================
    ! 5. CONCLUSIÓN (Respuesta a la pregunta final)
    ! ========================================================================
    ! "¿Cuántas iteraciones se necesitan con cada método?".
    if (it_sec < it_bis) then
        write(*,*) "CONCLUSION: El metodo de la Secante fue mas veloz."
        write(*,*) "Ahorro ", it_bis - it_sec, " iteraciones respecto a Biseccion."
    end if

end program prob2
