# --- SOLUCIÓN AL PROBLEMA 4 (d): SCRIPT DE EXPORTACIÓN ---

set xlabel "x"
set ylabel "y"
set grid
# SINTAXIS: 'set grid' activa la rejilla visual, facilitando la lectura de coordenadas.

set title "Funciones lineales"

# --- COMANDO DE DIBUJO MULTI-FUENTE ---
plot "datos.dat" using 1:2 with points title "Columna 2", \
     "datos.dat" using 1:3 with points title "Columna 3", \
     0.5*x + 1 title "y = 0.5x + 1", \
     0.4*x + 1.2 title "y = 0.4x + 1.2"

# ANÁLISIS SINTÁCTICO RIGUROSO:
# 1. '"datos.dat"': REGLA OBLIGATORIA. Los nombres de archivos van entre comillas.
# 2. 'using 1:2': SINTAXIS PARA ARCHIVOS. Define qué columna es X y cuál es Y.
# 3. 'with points': Modificador de estilo (puntos sueltos, no líneas).
# 4. ',': REGLA CRÍTICA. Cada curva se separa obligatoriamente por una coma.
# 5. '\': SINTAXIS DE CONTINUIDAD. Permite seguir el comando en la línea de abajo.

# --- EXPORTACIÓN A FORMATOS (PIPELINE ESTRICTO) ---

# 1. Exportar a PNG
set terminal png
set output "p4.png"
replot
# REGLA: 'replot' vuelve a graficar lo anterior pero hacia el nuevo destino (el archivo).

# 2. Exportar a PDF
set terminal pdf
set output "p4.pdf"
replot

# 3. Exportar a PostScript (Color)
set terminal postscript color
set output "p4_color.ps"
replot

# 4. Exportar a PostScript (B/N)
set terminal postscript
set output "p4_byn.ps"
replot

# --- RESTAURACIÓN ---
set terminal qt
# REGLA DE ORO: Siempre devuelve el terminal a la pantalla ('qt' o 'x11')
# para cerrar correctamente los flujos de escritura de los archivos anteriores.
