% Cargamos los datos desde el archivo pat1.mat
load('tarsofinal.mat');

% Calculamos el mínimo y el máximo de la variable
min_val = min(tarsofinal);
max_val = max(tarsofinal);

% Normalizamos la variable al rango [0, 2*pi]
p1_normalized = (tarsofinal - min_val) / (max_val - min_val) * (1);

% Verificamos que los valores estén ahora en el rango [0, 2*pi]
disp(['Valor mínimo después de normalización: ', num2str(min(p1_normalized))]);
disp(['Valor máximo después de normalización: ', num2str(max(p1_normalized))]);
