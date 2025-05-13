% Cargar los datos normalizados
load('intentosimulacion.mat'); % Carga promedio_cadera y promedio_rodilla

% Rango de ángulos en radianes
cadera_min = -0.10; % Ángulo mínimo para la cadera (-45° en radianes)
cadera_max = 0.10;  % Ángulo máximo para la cadera (45° en radianes)

rodilla_min = -0.25;    % Ángulo mínimo para la rodilla (0° en radianes)
rodilla_max = -0.10; % Ángulo máximo para la rodilla (90° en radianes)

% Desnormalizar promedio_cadera
promedio_cadera_radianes = senal_desplazada * (cadera_max - cadera_min) + cadera_min;

% Desnormalizar promedio_rodilla
promedio_rodilla_radianes = promedio_rodilla * (rodilla_max - rodilla_min) + rodilla_min;

% Guardar los nuevos datos desnormalizados en un archivo .mat
save('PromedioDatosintent5.mat', 'promedio_cadera_radianes', 'promedio_rodilla_radianes');
