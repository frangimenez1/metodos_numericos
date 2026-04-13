set title "Comparacion"
set xlabel "x"
set ylabel "y"
# "with points" asegura que solo se usen puntos para los datos
plot "datos.dat" 1:2 with points title "Datos 2 vs 1" , \
"datos.dat" 2:3 with points tite "Datos 3 vs 1"
