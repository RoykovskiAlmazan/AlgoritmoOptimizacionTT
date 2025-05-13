% Suponiendo que 'senalquenosalio' es un arreglo 1000x1 con datos originales
N = 5; % Número de señales que queremos generar
senal_origen = senalquenosalio;

% Inicializar señales
senales_variadas = zeros(length(senal_origen), N);

% Parámetros de variación
amplitud_variacion = 0.1; % Variación del 10% en la amplitud
desfase_variacion = 0.1; % Desfase máximo en radianes

% Generar N señales similares con ligeras variaciones
for i = 1:N
    % Escalar la amplitud ligeramente
    factor_amplitud = 1.6 + amplitud_variacion * (rand() - 0.2); % +/- 10% de variación
    fase_desfase = desfase_variacion * (rand() - 0.2) * 2 * pi; % Desfase aleatorio
    
    % Señal variada (cortar para mantener inicio y fin originales)
    senales_variadas(:, i) = factor_amplitud * senal_origen + sin(1:length(senal_origen)) * fase_desfase;
end

% Graficar señales
figure;
hold on;
plot(senales_variadas);
title('Señales Variadas con Restricciones de Inicio y Fin');
xlabel('Índice');
ylabel('Amplitud');
legend(arrayfun(@(i) ['Señal ' num2str(i)], 1:N, 'UniformOutput', false));
grid on;
hold off;
