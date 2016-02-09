clear all
close all
alpha_maxima = 85; % Grados; esta puede ir de 46 a 89
Ganancia_dBi = 50; %dBi
EficienciaP = 75; % '%'
Frecuencia = 2.5e9; % 'Hz'

% Parametros Necesarios
Eficiencia = EficienciaP/100; % sin porcentaje
C = 3e8; % velocidad de la luz m/s
Ganancia = 10^(Ganancia_dBi/10);% Watts
alpha = [0:alpha_maxima]; %Grados

LongitudDeOnda = C/Frecuencia % metros
D = (LongitudDeOnda/pi)*(sqrt(Ganancia/Eficiencia)) % Diametro metros

% Cuando alpha es maxima se podra conocer la distancia focal
% partiendo dela ecuacion de Ganancia que define Y = (diametro/2)
alpha_max = max(alpha)
Y_max = D/2
Distancia_focal = Y_max/(2*(tand(alpha_max/2)))

for i=1: length(alpha)
    r(i) = Distancia_focal/((cosd(alpha(i)/2))^2);
    x(i) = Distancia_focal*((tand(alpha(i)/2))^2);
    y(i) = (2*Distancia_focal)*(tand(alpha(i)/2));
end

figure
plot(x,y)
hold on
plot(x,-y)
plot(Distancia_focal,0,'ro')
str2 = '\leftarrow F';
text(Distancia_focal,0,str2)
plot(max(x),max(y),'bo')
plot(max(x),-max(y),'bo')
line([0 Distancia_focal],[0 0],'Color','r')
plot([max(x),max(x)],[max(y),-max(y)],'m--')
plot([max(x),Distancia_focal],[max(y),0],'g--')
plot([max(x),Distancia_focal],[-max(y),0],'g--')

A = [alpha;r;x;y];
fileID = fopen('Resultados Tarea individual.txt','w');
fprintf(fileID,'%s\n\n%s %f %s\n%s %f %s\n%s %f %s\n%s %f %s\n\n%s\n\n%s %f %s\n%s %f %s\n%s %f %s\n%s %f %s\n\n',...
    'DATOS',...
    'Angulo Maximo = ',alpha_maxima,...
    '°',...
    'Ganancia = ',Ganancia_dBi,...
    'dBi',...
    'Eficiencia = ',EficienciaP,...
    '%',...
    'Frecuencia = ',Frecuencia,...
    'Hz',...
    'RESULTADOS',...
    'Longitud de Onda = ',LongitudDeOnda,...
    'm',...
    'Diametro = ',D,...
    'm',...
    'Angulo maximo = ',alpha_max,...
    '°',...
    'Distancia focal = ',Distancia_focal,...
    'm');
fprintf(fileID,'%4s %4s %4s %4s\n','alpha','r','x','y');
fprintf(fileID,'%4.4f %4.4f %4.4f %4.4f\n',A);
fclose(fileID);
