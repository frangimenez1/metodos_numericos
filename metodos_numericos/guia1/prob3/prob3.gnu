# --- SOLUCIÓN AL PROBLEMA 3: GRÁFICO DE FUNCIÓN SENO ---

set samples 500
# SINTAXIS: 'set' es el comando de configuración global.
# REGLA: 'samples' define la resolución. Al ser una función oscilatoria (2*pi*x),
# subir a 500 puntos asegura que la curva sea suave y no se vea "pixelada".

set xlabel "Eje x"
set ylabel "Eje y"
# REGLA SINTÁCTICA OBLIGATORIA: Los nombres de los ejes DEBEN ir entre comillas.
# Sin las comillas, gnuplot intenta interpretar 'Eje' como una variable.

set title "Grafico de la funcion seno"
# SINTAXIS: Define el título superior del gráfico.

plot [0:5] sin(2*pi*x) title "f(x)"
# ANÁLISIS SINTÁCTICO RIGUROSO:
# 1. 'plot': Comando de ejecución para gráficos 2D.
# 2. '[0:5]': REGLA OBLIGATORIA. Si defines el rango en la misma línea de plot,
#    DEBE ir entre corchetes [] y los límites separados por dos puntos (:).
# 3. 'sin(...)': Función intrínseca. El argumento DEBE ir entre paréntesis ().
# 4. '2*pi*x': REGLA DE OPERADORES. El asterisco '*' es obligatorio.
#    'pi' y 'x' son constantes y variables predefinidas en el entorno de gnuplot.
# 5. 'title "f(x)"': Parámetro que define el texto de la leyenda (key).
