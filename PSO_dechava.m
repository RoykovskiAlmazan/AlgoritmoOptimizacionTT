clear all
load('Datos1000Normalizados01.mat') %el patron normalizado NORMALIZADO KAREN, NORMALIZADO
close all;
%clearvars -except p1_normalized;  

target = promedio_hock_1000_normalizado;
%target = segmento_normalizado;
CI=target(1);


lb_a =[-200,-200,-200,-200];
ub_a =[200,200,200,200];   %limites para ai GRADIENT DESCENT WHIT MOMENTUM
lb_b =[0,0,0,0];
ub_b =[15,15,15,15];  %limites para bi
lb_t =[0,0,0,0];
ub_t =[2*pi,2*pi,2*pi,2*pi];  %limites para thetai
lb_be =-50;
ub_be =0;

m = 4;  % Num de atractores
a0 = rand(1, m) .* (ub_a - lb_a) + lb_a;
b0 = rand(1, m) .* (ub_b - lb_b) + lb_b;
      % Val aleatorios para b
theta0 = 2*pi*rand(1, m);
bet=rand;
%%

params_in = [a0, b0, theta0,bet];  % Vector aleatorio de parámetros iniciales
% PARAMETROS
numParticulas = 600; % num de partículas
d = length(params_in); % dimensión del problema GRADIENTE DESCENDIENTE CON MOMENTUM
  %limites para thetai
%Limites
lb=[lb_a,lb_b,lb_t,lb_be];
ub=[ub_a,ub_b,ub_t,ub_be];

k = 1; %num it
kmax = 100; % paro
w_initial= 0.98;
w_final = 0.2;

c1 = 2; % constante cognitiva
c2 = 1.5; % constante social



%INICIO PART Y VELOCIDADES
pos = rand(numParticulas, d).*(ub - lb) + lb;  % POSIICION
 vel = rand(numParticulas, d).*(ub - lb) / 2;  % Velocidad inicial ajustada según los límites
         % VELOCIDAD
vel = vel';
pos = pos';     
pBest = pos; % POSICION DE CADA PART INICIAL

% INICIALIZACION DE FITNESS
pBestFitness = zeros(1, numParticulas);  
fitness = zeros(1, numParticulas);       
%gBestFitness = Inf;                      

%ALMACENA EL MEJOR FITNESS DE CADA ITERACION
gBestFitnessIter = zeros(1, kmax);

%FITNESS DE CADA PART
for i = 1:numParticulas
    fitness(i) = sistemaOscilatorio_eval(pos(:, i), target,CI); %FITNESS PARA MIS PRIMERAS 100 PART
    pBestFitness(i) = fitness(i);  
end

% Inicializar gBest como la mejor partícula inicial
[gBestFitness, ind] = min(pBestFitness); % MEJOR FITNESS INICIAL
gBest = pBest(:, ind);  % LOCALIZA LA POSICION DEL MEJOR FIT

% Actualización de la velocidad y posición
for iter = 1:kmax
    w = w_initial - (w_initial - w_final) * (iter / kmax); %peso inercial
    for i = 1:numParticulas
        % Actualización de la velocidad
        vel(:, i) = w * vel(:, i) + ...
                    c1 * rand() * (pBest(:, i) - pos(:, i)) + ...
                    c2 * rand() * (gBest - pos(:, i));

        if rand() < 0.4  % Probabilidad del 10% de aplicar perturbación a las part culas
             perturbation_strength = 0.9 + rand * 2.9;
            vel(:, i) = vel(:, i) + randn(size(vel(:, i))) * perturbation_strength;
        end

        
        if norm(vel(:, i)) < 1e-3
            vel(:, i) = rand(size(vel(:, i))) * 2 - 1; % Reinicia la velocidad si es muy baja
        end

        % Inicialización del ciclo while
        fueraLimites = true;
        
        % Ciclo while para verificar si la posición sale de los límites
        while fueraLimites
            % Calcula la nueva posición tentativa
            nueva_pos = pos(:, i) + vel(:, i);

            % Revisa si alguna componente de la nueva posición sale de los límites
            if any(nueva_pos < lb') || any(nueva_pos > ub') 
                % Si la posición sale de los límites, reduce la velocidad a la mitad
                vel(:, i) = vel(:, i) * 0.5;
            else
                % Verifica las restricciones de theta
                a_pos = nueva_pos(1:4);  % Extraer los valores de 'a'

                % Verificar restricciones de signos y condiciones específicas
                if a_pos(1) < 0  && a_pos(2) > 0  
                    % Si cumple las restricciones, actualizar posición
                    pos(:, i) = nueva_pos;
                    fueraLimites = false;  % Sal del ciclo while
                else
                    % Generar nuevos valores de 'a' que respeten las restricciones
                    a1 = -rand * (abs(lb_a(1)));       % Generar valor negativo para a1
                    a2 = rand * (ub_a(2));            % Generar valor positivo para a2
                    a3 = rand * (abs(lb_a(3)));      % Generar valor negativo para a3
                    a4 = -rand * (ub_a(4));            % Generar valor positivo para a4
                
                    % Actualizar nueva posición con valores corregidos de 'a'
                    nueva_pos(1:4) = [a1,a2,a3,a4];
                    pos(:, i) = nueva_pos;
                    fueraLimites = false;
                end

            end
        end

        % Evaluación de la función objetivo
        fitness(i) = sistemaOscilatorio_eval(pos(:, i), target, CI);

        % Actualización de los mejores valores locales
        if fitness(i) < pBestFitness(i)
            pBest(:, i) = pos(:, i);
            pBestFitness(i) = fitness(i);
        end

        % Actualización de los mejores valores globales
        if fitness(i) < gBestFitness
            gBest = pos(:, i);
            gBestFitness = fitness(i);
        end
    end
    
    % Almacenamiento del mejor fitness en cada iteración
    gBestFitnessIter(iter) = gBestFitness;

    fprintf('Iteración %d: Mejor fitness = %f\n', iter, gBestFitness);
end



%PART CON MEJOR FITNESS
fprintf('La partícula con el mejor fitness tiene parámetros:\n');
disp(gBest);
fprintf('Mejor fitness = %f\n', gBestFitness);

%CONVERGENCIA
figure;
plot(1:kmax, gBestFitnessIter, 'LineWidth', 2);
xlabel('Iteración');
ylabel('Mejor Fitness (Error)');
title('Convergencia del PSO');
grid on;

%SIMULADA VS TARGET

%%
z_sim =sistemaOscilatorio(gBest,CI);x|
%%

figure;
hold on;
plot3(z_sim(2,:), z_sim(3,:), z_sim(1,:), 'k', 'LineWidth', 2)
view(3)
%plot3(z_sim(2,:),z_sim(3,:),target(:)');
xlabel('x');
ylabel('y');
zlabel('zeta');
legend('Oscilador');
grid on
grid minor
title('optimizada vs target 3D');

%%

eje = linspace(0,2*pi,1000);
figure;
hold on
plot(eje,z_sim(1,:), 'LineWidth', 3)
plot(eje,target, 'LineWidth', 3)
legend('Optimización', 'Patron Angular');
grid on
grid minor
title('Optimizacion vs target')


