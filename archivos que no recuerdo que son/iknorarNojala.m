% Parámetros
alpha = 0.99; % Cambia este valor para observar diferentes comportamientos
tspan = [0, 20]; % Intervalo de tiempo
x0 = [2; 0]; % Condiciones iniciales [x(0); y(0)]

% Define el sistema de ecuaciones diferenciales
vdp = @(t, X) [X(2); alpha * (1 - X(1)^2) * X(2) - X(1)];

% Resuelve la ecuación diferencial
[t, X] = ode45(vdp, tspan, x0);

% Grafica los resultados
figure;
plot(t, X(:,1), 'r', 'LineWidth', 1.5);
hold on;
plot(t, X(:,2), 'b', 'LineWidth', 1.5);
xlabel('Tiempo');
ylabel('Amplitud');
legend('x(t)', 'y(t)');
title('Oscilador de Van der Pol');
grid on;
