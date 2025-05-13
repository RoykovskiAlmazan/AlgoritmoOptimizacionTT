figure;
hold on;

% Crear el objeto animatedLine
h = animatedline('LineWidth', 2, 'Color', 'k');

xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
zlim([-0.5 1.2]);
% Configurar vista 3D y etiquetas
xlabel('x');
ylabel('y');
zlabel('zeta');
legend('Oscilador');
grid on;
grid minor;
view(50, 10);
title('Oscilador');

% Datos
x_data = z_sim(2, :);
y_data = z_sim(3, :);
z_data = z_sim(1, :);

% Nombre del archivo GIF
filename = 'Tarso.gif';

% Animación
for i = 1:length(x_data)
    % Agregar puntos al animatedLine
    addpoints(h, x_data(i), y_data(i), z_data(i));
    
    % Capturar el cuadro actual
    frame = getframe(gcf); % Captura la figura actual como un frame
    img = frame2im(frame); % Convierte el frame en una imagen
    [imind, cm] = rgb2ind(img, 256); % Convierte la imagen a formato indexado (GIF)
    
    % Guardar el GIF
    if i == 1
        % Crear el archivo GIF en la primera iteración
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.005);
    else
        % Añadir nuevos cuadros al GIF
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.005);
    end
    
    % Actualizar la animación
    drawnow;
     pause(0.001)
end
