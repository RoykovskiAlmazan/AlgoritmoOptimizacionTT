function [z] = sistemaOscilatorio(params,ci)
    % Parámetros del sistema
    n=1000;
    a=params(1:4,:);
    b=params(5:8,:); %ajustar esto al reves
    thetai=params(9:12,:);
    ts = 0.001;              % Paso de tiempo
    om = 2*pi;               % Frecuencia angular
    beta = params(13);             % Parámetro beta
    z0 =ci ;               % Valor de referencia z_0

    % Inicializar variables
    x = zeros(1, n);        % Inicialización de x
    y = zeros(1, n);        % Inicialización de y
    theta = zeros(1, n);    % Inicialización de theta
    z = zeros(3, n);        % Inicialización de z
    x(1) = 1;               % Valor inicial de x
    y(1) = 0;               % Valor inicial de y
    z(1, 1) = ci;               % Valor inicial de z

    % Dimensiones de los coeficientes
    m = length(a);          % El tamaño de a, b, y thetai

    % Iteración usando el método de Euler
    for i = 2:n
        % Cálculo de alpha
        alpha = 1 - sqrt(x(i-1)^2 + (y(i-1)-1)^2);

        % Actualización de x y y
        x(i) = x(i-1) + ts * (alpha * x(i-1) - om * y(i-1));
        y(i) = y(i-1) + ts * (alpha * y(i-1) + om * x(i-1));

        % Calcular el ángulo theta
        theta(i) = atan2(y(i), x(i));
        if theta(i) < 0
            theta(i) = 2 * pi + theta(i);
        end

        % Cálculo de z
        primerTermino = -beta * (z(1, i-1) - z0); 
        atractores = 0;

        % Cálculo de la suma de los atractores
        for j = 1:m
            atractores = atractores + a(j) * exp(-b(j) * abs(theta(i) - thetai(j)));
        end

        dzdt = -primerTermino + atractores;  % Derivada de z en el tiempo

        % Actualizar z usando el método de Euler
        z(1, i) = z(1, i-1) + dzdt * ts;
        z(2, i) = x(i);
        z(3, i) = y(i);

    end
end

