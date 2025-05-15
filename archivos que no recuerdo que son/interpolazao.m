% Suponiendo que p1_normalized ya está definido y es de tamaño 1057x1
original_length = length(p1_normalized); % Longitud original del array
new_length = 1000; % Longitud deseada

% Crear el vector de índices original y los nuevos índices interpolados
x_original = linspace(1, original_length, original_length);
x_new = linspace(1, original_length, new_length);

% Realizar la interpolación
p1_interpolated = interp1(x_original, p1_normalized, x_new, 'linear'); % 'linear' es el método de interpolación
p1_interpolated = p1_interpolated';