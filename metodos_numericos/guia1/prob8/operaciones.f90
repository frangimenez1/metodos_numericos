! --- SOLUCIÓN AL PROBLEMA 8: JERARQUÍA Y TIPOS DE DATOS ---

program operaciones
! SINTAXIS: Inicia el bloque principal de ejecución.

    implicit none
    ! REGLA DE ORO: Bloquea la asignación implícita de variables.

    ! --- DEFINICIÓN DE PRECISIÓN (Agregado para rigor científico) ---
    integer, parameter :: pr = kind(1.0)
    ! SINTAXIS: Crea una constante 'pr' que almacena la clase de precisión simple.

    ! --- DECLARACIÓN DE VARIABLES ---
    real(kind=pr) :: A, B, C, D, E, F, G
    ! SINTAXIS ESTRICTA: Declaramos las 7 variables obligando a que utilicen la precisión 'pr'.
    ! REGLA: Los dos puntos '::' separan los atributos de la lista de variables.

    ! --- ASIGNACIÓN Y CÁLCULOS (LA TRAMPA DEL EJERCICIO) ---

    A = 5 / 2 + 20 / 6
    ! REGLA CRÍTICA EN FORTRAN (División Entera):
    ! Cuando Fortran ve que divides dos números enteros (sin punto decimal), realiza OBLIGATORIAMENTE una "división entera". Trunca los decimales, NO redondea.
    ! Ejecución de la máquina: 5 / 2 = 2 (pierde el 0.5). 20 / 6 = 3 (pierde el 0.333...). Luego, 2 + 3 = 5. El resultado en 'A' será 5.0000.

    B = 4 * 6 / 2 - 15 / 2
    ! SINTAXIS: Se respeta el orden de precedencia (multiplicación y división antes que resta).
    ! Máquina: (24 / 2) - (15 / 2) -> 12 - 7 (división entera de 15/2) -> 5.0000.

    C = 5 * 15 / 2 / (4 - 2)
    ! REGLA SINTÁCTICA: Los paréntesis '()' fuerzan la máxima prioridad de ejecución.
    ! Máquina: Resuelve primero (4-2). Luego (75 / 2) / 2 -> 37 / 2 -> 18.0000.

    D = 1 + 1 / 4
    ! Máquina: División entera 1 / 4 = 0. Luego 1 + 0 = 1.0000.

    E = 1. + 1 / 4
    ! REGLA DE TIPADO MIXTO: Fortran evalúa los términos por separado.
    ! Máquina: '1/4' son enteros, resulta en 0. Luego, la suma '1. + 0'. Al haber un número real ('1.'), convierte el 0 a real. Resultado: 1.0000.

    F = 1 + 1. / 4
    ! REGLA DEL PUNTO FLOTANTE: El '1.' le indica al compilador que es un número real.
    ! Máquina: Al haber un real en la división, realiza una "división real". 1.0 / 4 = 0.25. Luego le suma el entero 1 convertido a real. Resultado: 1.2500.

    G = 1. + 1. / 4.
    ! SINTAXIS: Todos los números incluyen el punto decimal explícito. Todos son procesados como reales desde el inicio. Resultado: 1.2500.

    ! --- SALIDA FORMATEADA AVANZADA ---
    write (*, "('El resultado de las operaciones es:' / &
                '----------------------------------' / &
                'A = 5 / 2 + 20 / 6 es             ', F8.4 / &
                'B = 4 * 6 / 2 - 15 / 2 es         ', F8.4 / &
                'C = 5 * 15 / 2 / (4 - 2) es       ', F8.4 / &
                'D = 1 + 1/4 es                    ', F8.4 / &
                'E = 1. + 1/4 es                   ', F8.4 / &
                'F = 1 + 1./4 es                   ', F8.4 / &
                'G = 1. + 1./4. es                 ', F8.4)") A, B, C, D, E, F, G

    ! ANÁLISIS SINTÁCTICO RIGUROSO DE ESTE BLOQUE:
    ! 1. '(*, "...")': El segundo parámetro de 'write' no es un '*', es una cadena de formato estricta entre comillas dobles.
    ! 2. '&' (Ampersand): REGLA OBLIGATORIA. En Fortran 90+, colocar un '&' al final de la línea le indica al compilador que la instrucción no terminó y continúa en el siguiente renglón físico.
    ! 3. '/' (Barra diagonal): Dentro de una cadena de formato, el '/' significa OBLIGATORIAMENTE "insertar un salto de línea" (Enter).
    ! 4. 'F8.4': Descriptor de formato estricto para números reales.
    !    - 'F': Significa Punto Flotante (Float).
    !    - '8': Es el ancho total mínimo reservado en la pantalla (contando el signo, el punto y los decimales).
    !    - '.4': Exige imprimir OBLIGATORIAMENTE 4 cifras decimales.
    ! 5. ')': Cierra la cadena de formato.
    ! 6. 'A, B...': Las variables, separadas por coma, se inyectan en orden en cada aparición de 'F8.4'.

    Stop
    ! SINTAXIS: Cese de ejecución.

end program operaciones
