% Suavizado usando media móvil
windowSize = 100; % Tamaño de la ventana para suavizado
p1_suavizada = movmean(p1_normalized, windowSize);

% Graficar la curva original y la suavizada
plot(p1_normalized, 'b-', 'DisplayName', 'Curva original');
hold on;
plot(p1_suavizada, 'r-', 'LineWidth', 2, 'DisplayName', 'Curva suavizada');

legend;
hold off;
