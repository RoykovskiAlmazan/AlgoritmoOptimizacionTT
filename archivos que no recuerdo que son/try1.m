% Parámetros
ts = 0.001; 
om = 10*pi; % Frecuencia angular
n = 1000; % Número de iteraciones

% Inicialización
x = zeros(1, n);
y = zeros(1, n);
x(1) = 1; % Condiciones iniciales
y(1) = 0;

% Iteración
for i = 2:n
    alpha = 1 - sqrt(x(i-1)^2 + y(i-1)^2);
    x(i) = x(i-1) + ts * (alpha * x(i-1) - om * y(i-1));
    y(i) = y(i-1) + ts * (alpha * y(i-1) + om * x(i-1));
end

% Eje temporal
t = 1:n;

% Graficar trayectoria en 3D
figure;
plot3(x, y, z_sim(1,:), 'b', 'LineWidth', 1.5); % Línea azul para trayectoria
grid on;
title('Trayectoria de (x, y) en 3D');
xlabel('x');
ylabel('y');
zlabel('Iteraciones (t)');
view(45, 30); % Ajustar la perspectiva
