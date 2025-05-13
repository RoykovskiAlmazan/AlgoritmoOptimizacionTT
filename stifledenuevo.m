y = [152,151.4,151.2,151,150.8,150.6,150.4,150.4,150.2,150,150,149.8,149.7,149.7,149.6,149.4,149.3,149.3,149.1,149,148.8,148.6,148.4,148.2,148,148,147.8,147.8,147.6,147.4,147.1,147,147,146.9,146.9,146.8,146.7,146.6,146.6,146.5,146.4,146.4,146.3,146.2,146.1,146,145.7,145.6,145.5,145.4,145.4,145.3,145.1,144.8,144.5,144.2,144,143.7,143.6,143.4,143.1,143,142.9,142.7,142.4,142.2,142.1,142,142,142,142.1,142.2,142.3,142.4,142.4,142.5,142.5,142.4,142.3,142.2,142.1,142,141.8,141.6,141.3,141.1,141,140.7,140.4,140.1,140,139.9,139.6,139.3,139.2,139.2,139,139,139.1,139.1,139.2,139.2,139.4,139.5,139.7,139.9,140.2,140.5,140.9,141.5,141.9,142.5,143.1,143.9,144.6,145,145.8,146.6,147.3,148.1,149,150.3,150.9,151.4,151.9,152,152];

%%
y_filtrada = movmean(y,4);
plot(y_filtrada)
%%
x_original = linspace(1, 128, 128);
x_interpolado = linspace(1, 128, 1000);
stifle = interp1(x_original, y_filtrada, x_interpolado, 'linear');
figure()
plot(y_filtrada)

%%
stifle = promedio_tobillo_radianes
min_target = -0.25;
max_target = -0.10;

% Calcular el rango actual del vector
min_input = min(stifle);
max_input = max(stifle);

% Normalización lineal
stifle_normalized = min_target + (stifle - min_input) * (max_target - min_target) / (max_input - min_input);
%%
promedio_corvejon_radianes = promedio_corvejon_radianes'

%%

% Supongamos que cadera_ang es tu señal de 1000x1
% Ejemplo: cadera_ang = rand(1000, 1); % Reemplázalo con tu señal real
cadera_ang =  cadera_ang; % Ejemplo de señal

% Índice actual y deseado
indice_actual = 949;
indice_deseado = 800;

% Calcular el desplazamiento necesario
desplazamiento = indice_deseado - indice_actual;

% Desplazar la señal circularmente
cadera_ang_desplazada = circshift(cadera_ang, desplazamiento);

% Mostrar resultados
disp('Señal desplazada:');
disp(cadera_ang_desplazada);

% Graficar para comparar
figure;
subplot(2, 1, 1);
plot(cadera_ang, 'b', 'LineWidth', 1.5);
hold on;
plot(indice_actual, cadera_ang(indice_actual), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
title('Señal original');
xlabel('Índice');
ylabel('Amplitud');
legend('Señal', 'Valor en índice 949');
grid on;

subplot(2, 1, 2);
plot(cadera_ang_desplazada, 'r', 'LineWidth', 1.5);
hold on;
plot(indice_deseado, cadera_ang_desplazada(indice_deseado), 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);
title('Señal desplazada');
xlabel('Índice');
ylabel('Amplitud');
legend('Señal desplazada', 'Valor en índice 800');
grid on;

%%

