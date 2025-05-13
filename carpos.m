y = [205,200,195,190,185,180,175,170,165,160,155,150,148,147,146.5,146,145.2,142,141.8,141.7,141.6,141.7,141.8,141.9,142,142.1,142.2,142.3,142.4,142.5,142.6,142.7,142.8,142.9,143,143.2,143.4,143.6,143.8,144,144.3,144.6,144.9,145.2,145.5,145.8,145.8,145.9,146,146.1,146.1,146.1,146.1,146.2,146.2,146.3,146.3,146.4,146.6,146.8,146.9,147,148,149,150,150.2,150.5,150.8,151.3,151.6,151.9,152.2,152.9,153.7,154.5,160,165,174,182,190,196,200,203,203.4,204,204.9,205,205.6,206,206.4,206.5,206.4, 206.2,205.9,205.2,204.7,204.3,204,203.8,203.5,203];
y_filtrada = movmean(y,4);
x_original = linspace(1, 101, 101);
x_interpolado = linspace(1, 101, 1000);
tarso = interp1(x_original, y_filtrada, x_interpolado, 'linear');
figure()
plot(y_filtrada)

%%
% Ejemplo de matriz de señales (reemplázala por tu matriz real)
signal_matrix = signals_matrix; % 15 señales, 98 puntos cada una

% Calcular el promedio de las señales
average_signal = mean(signal_matrix, 1);

% Ajustar la señal para que sea periódica
average_signal(end) = average_signal(1);

% Generar índices originales (1 a 98, ya que hay 98 puntos)
original_indices = linspace(1, 98, 98);

% Crear nuevos índices para interpolar a 1000 puntos
new_indices = linspace(1, 98, 1000);

% Interpolación
interpolated_signal = interp1(original_indices, average_signal, new_indices, 'linear');

% Graficar el promedio original y el promedio interpolado
figure;
plot(original_indices, average_signal, 'o-', 'LineWidth', 1.5); hold on;
plot(new_indices, interpolated_signal, '-', 'LineWidth', 1.5);
legend('Promedio Original', 'Promedio Interpolado');
xlabel('Índice');
ylabel('Amplitud');
title('Promedio e Interpolación Periódica de Señales');
grid on;

%%
tarsofinal = interpolated_signal'

%%
 % Ejemplo de señal entre 0 y 1

% Rango objetivo
min_target = -0.10;
max_target = 0.10;

% Normalización lineal
p1_scaled = min_target + (stifle - 0) * (max_target - min_target) / (1 - 0);



