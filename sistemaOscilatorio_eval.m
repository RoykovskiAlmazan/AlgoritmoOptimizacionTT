function error = sistemaOscilatorio_eval(params, target,ci)
    % Parámetros del sistema
    n = 1000;
    a = params(1:4);        % Eliminar ":," ya que params es un vector de 9x1
    b = params(5:8);        % Eliminar ":," para asegurar que params es un vector de 9x1
    thetai = params(9:12);   % Eliminar ":," para mantener consistencia
    ts = 0.001;             % Paso de tiempo
    om = 2*pi;               % Frecuencia angular
    beta = params(13);             % Parámetro beta
    z0 = ci;               % Valor de referencia z_0

    % Inicializar variables
    x = zeros(1, n);        % Inicialización de x
    y = zeros(1, n);        % Inicialización de y
    theta = zeros(1, n);    % Inicialización de theta
    z = zeros(1, n);        % Inicialización de z
    x(1) = 1;               % Valor inicial de x
    y(1) = 0;               % Valor inicial de y
    z(1) = ci;               % Valor inicial de z

    % Dimensiones de los coeficientes
    m = length(a);          % El tamaño de a, b, y thetai

    % Iteración usando el método de Euler
    for i = 2:n
        % Cálculo de alpha
        alpha = 1 - sqrt(x(i-1)^2 + (y(i-1))^2);

        % Actualización de x y y
        x(i) = x(i-1) + ts * (alpha * x(i-1) - om * y(i-1));
        y(i) = y(i-1) + ts * (alpha * y(i-1) + om * x(i-1));

        % Calcular el ángulo theta
        theta(i) = atan2(y(i), x(i));
        if theta(i) < 0
            theta(i) = 2 * pi + theta(i);
        end

        % Cálculo de z
        primerTermino = -beta * (z(i-1) - z0); 
        atractores = 0;

        % Cálculo de la suma de los atractores
        for j = 1:m
            atractores = atractores + a(j) * exp(-b(j) * abs(theta(i) - thetai(j)));
        end

        dzdt = -primerTermino + atractores;  % Derivada de z en el tiempo

        % Actualizar z usando el método de Euler
        z(i) = z(i-1) + dzdt * ts;
    end

    % Asegurarse que target y z sean vectores columna para la operación correcta
    z = z(:);      % Convertir z a vector columna
    target = target(:);  % Asegurarse que target es vector columna

    % Calcular el error cuadrático total (suma de los errores cuadráticos)
    %error = sum((z - target).^2);   % Devolver un escalar
    error = trapz(ts, abs(z - target));
    % Si deseas el error cuadrático medio (opcional)
    %error = mean((z - target).^2);
end
