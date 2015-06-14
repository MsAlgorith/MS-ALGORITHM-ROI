function [datos,n] = CargarDatos(flag)

fprintf('********************************************************\n')
fprintf('%s                                                    %s\n',91,93)
fprintf('%s                 PROYECTO DE TITULACION,            %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s REALIZADO POR:                                     %s\n',91,93)
fprintf('%s                 * SOFIA JAZMINA CALLE J.           %s\n',91,93)
fprintf('%s                 * SILVIA S. CHASILUIZA P.          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s DIRECTOR:                                          %s\n',91,93)
fprintf('%s                 ING. ROBERTO HERRERA LARA          %s\n',91,93)
fprintf('%s CODIRECTOR:                                        %s\n',91,93)
fprintf('%s                 ING. JORGE CARVAJAL, MsC           %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s TEMA:                                              %s\n',91,93)
fprintf('%s     DISEÑO DE UN ALGORITMO PARA LA DETECCION Y     %s\n',91,93)
fprintf('%s VALIDACION DE PATRONES DE BIOMARCACION EN CONJUNTOS%s\n',91,93)
fprintf('%s      DE MEDICIONES DE ESPECTROMETRIA DE MASAS      %s\n',91,93)
fprintf('%s           APLICADOS AL ESTUDIO DEL CANCER          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('********************************************************\n')

fprintf('======================================================\n')
fprintf('%s                 CARGAR DATOS                     %s\n',20,22)
fprintf('======================================================\n')

% Cargar Datos de archivos 
% --------------------------------
%SINTAXIS: function [datos,n] = CargarDatos(   )
%PARAMETROS: 
%   datos = cell array cada uno con dos vectores columna: m/z e intensidad
%   n = numero de archivos.csv
%EJEMPLO:
% sample = importdata('mspec01.csv')
% MZ = sample.data(:,1)
% Y  = sample.data(:,2);
%
% Con flag declaramos dos funciones. 
% Si flag es 1 para cargar archivos .txt o 
% si flag es 2 cargar archivos en texto plano .csv

if flag == 1 % CARGAR ARCHIVOS .txt
    d = dir(['*.txt']);  
    n = length(d);
    datos{1} = [0 0]; 
    namesC{1} = '';
    
    for i=1:n
        datos{i} = (load([d(i).name]));  
        name = d(i).name;  
        a = regexp(name, '.txt');
        namesC{i} = name(1:a-1);  
        if i == n
            fprintf([blanks(1) '%d\n' blanks(1) '\n'],i)
        else
            if (( 12 * round(double(i)/12) == i ))
                fprintf([blanks(1) '%d' blanks(1) '\n'],i)
            else
                fprintf([blanks(1) '%d' blanks(1)],i)
            end
        end
    end
    
elseif flag == 2 % carga archivos .csv

d = dir(['*.csv']);  
n = length(d);
datos{1} = [0 0];

fprintf('Cargando archivos\n\n')
    for i=1:n
    datos{i} = importdata([d(i).name]);  
    fprintf('%s\n',d(i).name)
    end
end

