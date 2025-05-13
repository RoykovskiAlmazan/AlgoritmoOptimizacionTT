% Array original de tamaño 1x14
y_sin = y; % Sustituye este array con tus valores originales

% Filtrar con media móvil de orden 6
y_filtered = movmean(y_sin, 4);

% Coordenadas originales (14 puntos uniformemente distribuidos)
x_original = linspace(1, 14, 14);

% Nuevas coordenadas para interpolación (1000 puntos)
x_interp = linspace(1, 14, 60);

% Interpolar el array filtrado
y_interp = interp1(x_original, y_filtered, x_interp, 'linear'); % Interpolación lineal
y_interp2 = movmean(y_interp, 20);
% Graficar el resultado
figure;
plot(x_original, y_sin, 'DisplayName', 'Original'); % Puntos originales
hold on;
plot(x_original, y_filtered, 'DisplayName', 'Filtrado (Media Móvil)'); % Filtrado
plot(x_interp, y_interp2, 'LineWidth', 1.5, 'DisplayName', 'Interpolación'); % Curva interpolada
title('Filtrado y Interpolación de Array');
xlabel('Índice');
ylabel('Valores');
legend;
grid on;
hold off;
