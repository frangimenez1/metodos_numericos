! --- SOLUCIÓN AL PROBLEMA 5 ---

program hola_mundo
! SINTAXIS: 'program' es una palabra reservada (keyword) obligatoria para iniciar el bloque principal de ejecución.
! REGLA: Le sigue un nombre identificador ('hola_mundo'). Este nombre DEBE empezar con una letra y NO puede contener espacios (usamos guión bajo '_').

    implicit none
    ! REGLA DE ORO DE TUS PROFESORES: Como bien dijiste, desactiva el tipado implícito (la regla heredada de versiones muy antiguas de Fortran que asignaba tipos según la letra inicial).
    ! SINTAXIS OBLIGATORIA: Si se usa, DEBE ser estrictamente la primera instrucción dentro del 'program', antes de cualquier declaración de variables o código ejecutable.

    write(*,*) 'Hola mundo'
    ! SINTAXIS ESTRICTA DE ESCRITURA:
    ! 1. 'write': Comando para emitir datos hacia un dispositivo.
    ! 2. '()': Los paréntesis son OBLIGATORIOS y contienen la "lista de control de entrada/salida".
    ! 3. Primer '*': Indica el canal o unidad lógica de salida. El asterisco significa "unidad de salida estándar" (tu pantalla/terminal).
    ! 4. ',' (coma): SINTAXIS OBLIGATORIA. Separa los parámetros de configuración dentro del comando write.
    ! 5. Segundo '*': Indica el formato. El asterisco significa "formato libre" (list-directed formatting); le decimos al compilador que él decida cuántos espacios dejar y cómo presentar el dato, sin que nosotros armemos una máscara rígida.
    ! 6. 'Hola mundo': REGLA SINTÁCTICA. Cualquier texto literal que quieras que aparezca tal cual, DEBE ir encerrado entre comillas simples (' ') o dobles (" "). Si omites las comillas, Fortran pensará que Hola y mundo son variables.

    STOP
    ! SINTAXIS: Comando ejecutable que detiene inmediata y completamente la ejecución del programa.
    ! NOTA DE BUENA PRÁCTICA: En Fortran moderno (90 en adelante), poner 'STOP' justo antes del 'END' es redundante porque el programa se detiene naturalmente al alcanzar el final. Sin embargo, es sintácticamente 100% correcto usarlo.

END PROGRAM hola_mundo
! REGLA SINTÁCTICA ESTRICTA: Todo bloque abierto con 'program' DEBE cerrarse obligatoriamente con la sentencia 'end program'.
! REGLA OPCIONAL PERO RECOMENDADA: Añadir el nombre del programa al final ('hola_mundo') ayuda al compilador a verificar que estás cerrando el bloque correcto (muy útil cuando el código tiene miles de líneas).
