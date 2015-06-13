function [MatrizIntesidadesCorregidas ] = ...
    CorreccionLineaBase( VectorMasasRemuestreadas, ...
    MatrizIntensidadesRemuestreadas, ...
    ventana )

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
fprintf('%s     DISE�O DE UN ALGORITMO PARA LA DETECCION Y     %s\n',91,93)
fprintf('%s VALIDACION DE PATRONES DE BIOMARCACION EN CONJUNTOS%s\n',91,93)
fprintf('%s      DE MEDICIONES DE ESPECTROMETRIA DE MASAS      %s\n',91,93)
fprintf('%s           APLICADOS AL ESTUDIO DEL CANCER          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('********************************************************\n')

fprintf('========================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s             CORRECION LINEA DE BASE                %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Funci�n para eliminar ruido qu�mico en la matriz o %s\n',20,22)
fprintf('%s ruido causado por sobrecarga de iones. Esta funci�n%s\n',20,22)
fprintf('%s calcula una l�nea de base de baja frecuencia, que  %s\n',20,22)
fprintf('%s se oculta entre ruido y los picos de la se�al de   %s\n',20,22)
fprintf('%s de alta frecuencia.                                %s\n',20,22)
fprintf('%s A continuaci�n, resta la l�nea de base desde el    %s\n',20,22)
fprintf('%s espectrograma.                                     %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('========================================================\n')

% Funci�n para eliminar ruido qu�mico en la matriz o ruido causado por 
% sobrecarga de iones. Esta funci�n calcula una l�nea de base de baja 
% frecuencia, que se oculta entre ruido y los picos de la se�al de alta 
% frecuencia. 
% A continuaci�n, resta la l�nea de base desde el espectrograma.
% -------------------------------------------------------------------------
% SINTAXIS: function[MatrizIntesidadesCorregidas]=CorreccionLineaBase(VectorMasasRemuestreadas,MatrizIntensidadesRemuestreadas)
% PAR�METROS:
%   VectorMasasRemuestreadas =Vector de Masas remuestreadas a 10000 puntos 
%   MatrizIntensidadesRemuestreadas = Intensidades remuestreadas a 10000 puntos
%   MatrizIntesidadesCorregidas = matriz con linea de base corregida
%EJEMPLO
% load sample_lo_res
% YB = msbackadj(MZ_lo_res,Y_lo_res,'SHOWPLOT',3);
% http://www.mathworks.com/help/bioinfo/ref/msbackadj.html
% Substraccion de la linea base

MatrizIntesidadesCorregidas = msbackadj(VectorMasasRemuestreadas',MatrizIntensidadesRemuestreadas','WindowSize', ventana,...
'QUANTILE',0.2);

MatrizIntesidadesCorregidas = MatrizIntesidadesCorregidas';
end