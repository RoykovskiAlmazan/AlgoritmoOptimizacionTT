% Datos originales
y = [147,146.91, 146.9 ,146.5, 145.7, 145.4 ,145, 144.2, 142.4, 141, 139, 137, 135, 132, 130, 128, 125, 117, 115, 115.2, 115.3, 123.5, 129, 135, 140, 146.8, 147];
x = 1:length(y);

y_filtered = movmean(y, 6);
% Interpolar datos a 100 puntos
x_interp = linspace(1, length(y), 1000); % 100 puntos interpolados
y_interp = spline(x, y_filtered, x_interp); % Interpolación spline
senalquenosaliobien = y_interp';

offset1 = 20;
offset2 = -15;

senal_offset1 = senalquenosaliobien + offset1; % Señal con offset de +20
senal_offset2 = senalquenosaliobien + offset2; % Señal con offset de -15

% Crear matriz con las señales
matriz_senales = [senalquenosaliobien; senal_offset1; senal_offset2];

% Graficar los datos interpolados
figure;
plot(y_interp); % Línea interpolada con marcadores
title('Gráfica de los datos interpolados');
xlabel('Índice');
ylabel('Valores');
grid on;
