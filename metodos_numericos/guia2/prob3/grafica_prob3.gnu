# PROBLEMA 3

# --- CONFIGURACIÓN GENERAL ---

# Le digo a gnuplot que use ventanas independientes (qt) para no sobreescribir el primer gráfico cuando dibuje el segundo.

set terminal qt 0 size 800,600 font "Arial,11"

# Pongo la grilla de fondo para poder leer mejor los valores.

set grid

# ESCALA SEMILOGARÍTMICA

# La guía pide "Probar usar escala lineal y escala semilogarítmica". ¿Por qué logarítmica? Porque los errores caen de 1.0 a 0.000000001.
# En escala lineal, se ve una línea recta contra el piso.
# El comando 'set logscale y' convierte el eje Y a potencias de 10.
# (Si quiero probar la escala lineal, solo tengo que poner un '#' adelante de esa línea).

set logscale y

# GRÁFICO 1: ERROR ABSOLUTO (Ea)

set title "Problema 3: Iteraciones vs Error Absoluto |u(pN)|"
set xlabel "Número de Iteraciones (N)"
set ylabel "Error Absoluto (Ea)"

# Sintaxis del comando plot:

# 'archivo.dat'  -> De dónde saca los datos.
# using 1:4      -> Usa la Columna 1 (iteraciones) para el eje X, y la 4 (Error Absoluto) para el eje Y.
# with linespoints -> Dibuja líneas que conectan los puntos, y marca cada punto con un símbolo.
# lw 2           -> "Line Width" 2 (hace la línea un poco más gruesa para que se vea mejor).


plot 'salida_bisec.dat'  using 1:4 with linespoints lw 2 title "Bisección", \
     'salida_secan.dat'  using 1:4 with linespoints lw 2 title "Secante", \
     'salida_regula.dat' using 1:4 with linespoints lw 2 title "Regula Falsi"


# GRÁFICO 2: ERROR RELATIVO (Er)
# Abro una SEGUNDA ventana (qt 1) para el siguiente gráfico.

set terminal qt 1 size 800,600 font "Arial,11"

set title "Problema 3: Iteraciones vs Error Relativo en x"
set xlabel "Número de Iteraciones (N)"
set ylabel "Error Relativo (Er)"

# Aca Cambio "using 1:4" por "using 1:5", porque en el código de Fortran guarde el Error Relativo en la 5ta y última columna del archivo.


plot 'salida_bisec.dat'  using 1:5 with linespoints lw 2 title "Bisección", \
     'salida_secan.dat'  using 1:5 with linespoints lw 2 title "Secante", \
     'salida_regula.dat' using 1:5 with linespoints lw 2 title "Regula Falsi"

# PAUSA PARA EL USUARIO

# Gnuplot dibuja y se cierra. Este comando congela el programa para poder ver los graficos hasta tocar Enter.


pause -1 "Presiona ENTER en esta terminal para cerrar los graficos..."
