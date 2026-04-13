! --- SOLUCIÓN AL PROBLEMA 16: CONVERSIÓN DE BASES NUMÉRICAS ---

program prob_16
! SINTAXIS: Inicia el bloque ejecutable.

    implicit none
    ! REGLA DE ORO: Declaración explícita obligatoria.

    ! --- DECLARACIÓN DE VARIABLES ---
    integer :: num_base10, b, cociente, resto, i, num_digitos

    character(len=1), dimension(100) :: resultado
    ! SINTAXIS ESTRICTA DE CARACTERES:
    ! 1. 'character': Tipo de dato para texto (cadenas alfanuméricas).
    ! 2. '(len=1)': REGLA SINTÁCTICA. Define la longitud estricta de la cadena. Aquí forzamos a que cada casillero del arreglo almacene exactamente UN solo carácter.

    ! 1. ENTRADA DE DATOS Y VALIDACIÓN
    write(*,*) 'Ingrese el numero natural (en base 10):'
    read(*,*) num_base10

    write(*,*) 'Ingrese la base b (entre 2 y 16):'
    read(*,*) b

    ! CONTROL DE EXCEPCIONES:
    if (b < 2 .or. b > 16) then
    ! SINTAXIS: Operador lógico '.or.' (O lógico). Requiere los puntos a los lados.
        write(*,*) 'Error: La base debe estar entre 2 y 16.'
        stop
    end if

    if (num_base10 == 0) then
        write(*,*) 'El resultado en base ', b, ' es: 0'
        stop
    end if

    ! 2. INICIALIZACIÓN
    cociente = num_base10
    num_digitos = 0

    ! 3. BUCLE CONDICIONAL (DO WHILE)
    do while (cociente > 0)
    ! SINTAXIS ESTRICTA 'do while':
    ! A diferencia del 'do' iterativo (con i=1,n), este bucle evalúa una expresión lógica al inicio de cada ciclo.
    ! REGLA: La condición OBLIGATORIAMENTE debe estar entre paréntesis '()'. El bucle se repetirá mientas la condición evalúe a verdadero (.TRUE.).

        resto = mod(cociente, b)
        num_digitos = num_digitos + 1

        ! 4. ESTRUCTURA DE SELECCIÓN MÚLTIPLE (SELECT CASE)
        select case (resto)
        ! SINTAXIS ESTRICTA:
        ! 1. 'select case': Se utiliza en lugar de anidar múltiples 'else if'. Es mucho más rápido para la CPU.
        ! 2. '(resto)': La variable a evaluar DEBE ir entre paréntesis y debe ser de tipo entero, caracter o lógico (no reales).

            case (10)
            ! SINTAXIS: Evalúa si 'resto' es exactamente igual a 10.
                resultado(num_digitos) = 'A'
            case (11)
                resultado(num_digitos) = 'B'
            case (12)
                resultado(num_digitos) = 'C'
            case (13)
                resultado(num_digitos) = 'D'
            case (14)
                resultado(num_digitos) = 'E'
            case (15)
                resultado(num_digitos) = 'F'

            case default
            ! SINTAXIS: Atrapa cualquier valor que no haya coincidido con los 'case' anteriores (es decir, del 0 al 9).

                ! --- ESCRITURA EN ARCHIVO INTERNO (TÉCNICA AVANZADA) ---
                write(resultado(num_digitos), '(I1)') resto
                ! ANÁLISIS SINTÁCTICO RIGUROSO DE ESTA LÍNEA MAGISTRAL:
                ! Normalmente 'write' usa '(*,*)' o '(unidad, formato)' para enviar datos a la pantalla o al disco.
                ! Aquí, el primer argumento NO es un asterisco ni un número, es una VARIABLE ('resultado(num_digitos)').
                ! REGLA: A esto se le llama "Internal File I/O". Fortran usa la variable de texto como si fuera un archivo temporal en la memoria RAM, escribiendo el valor entero de 'resto' dentro del caracter, convirtiendo automáticamente el número en texto.
                ! '(I1)': Descriptor de formato obligatorio (Entero de 1 dígito).

        end select
        ! REGLA CRÍTICA: Todo bloque abierto debe cerrarse con 'end select'.

        cociente = cociente / b
        ! SINTAXIS: División entera automática. (Ej: 15 / 2 dará 7).

    end do
    ! Cierre del bucle 'do while'.

    ! 5. SALIDA DE DATOS SIN AVANCE DE LÍNEA
    write(*,*) 'El numero ', num_base10, ' en base ', b, ' es:'

    do i = num_digitos, 1, -1

        write(*, '(A)', advance='no') resultado(i)
        ! ANÁLISIS SINTÁCTICO DEL FORMATO SIN AVANCE:
        ! 1. '(A)': Formato explícito para cadena de caracteres (Alfanumérico).
        ! 2. 'advance='no'': REGLA SINTÁCTICA CRÍTICA. Para usar esta instrucción, ESTÁ PROHIBIDO usar formato libre (*). DEBES usar un formato explícito (como '(A)').
        ! Le indica a la consola que, tras imprimir la letra, no presione "Enter". Esto permite que el siguiente ciclo imprima la próxima letra inmediatamente a la derecha, pegada a la anterior.

    end do

    write(*,*)
    ! SINTAXIS: Un 'write' vacío imprime un "Enter" en la consola. Necesario para destrabar el cursor después de usar advance='no'.

end program prob_16
