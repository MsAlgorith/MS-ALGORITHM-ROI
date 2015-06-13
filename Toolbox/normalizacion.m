function [ MatrizIntensidadesNormalizadas, VectorMasas ] =  ...
    normalizacion( VectorMasasRemuestreadas, ...
    MatrizIntesidadesAlineadas,maximo)

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


fprintf('========================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s                NORMALIZACION                       %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%sFunción que cambia la escala de la intensidad máxima%s\n',20,22)
fprintf('%s de cada señal en un valor específico,por ejemplo   %s\n',20,22)
fprintf('%s 100.                                               %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('******************************************************\n')

% Función que cambia la escala de la intensidad máxima de cada 
% señal en un valor específico, por ejemplo 100. 
% --------------------------------
%SINTAXIS: function [ IntenNorm ] = Normalizacion( VectorMasasRemuestreadas,MatrizIntesidadesAlineadas )
%PARAMETROS:
%   VectorMasasRemuestreadas = Masas remuestreadas a 10000 puntos
%   MatrizIntesidadesAlineadas=matriz con picos alineados
%   IntenNorm=matriz de valores normalizados a un valor maximo de 100
%EJEMPLO:
% load sample_hi_res
% YN1=msnorm(MZ_hi_res,Y_hi_res,'QUANTILE',1,'LIMITS',[1000 inf],'MAX',100)
% figure
% plot(MZ_hi_res,YN1)
% axis([0 10000 -20 110])
% xlabel('(M/Z)');ylabel('Intensidad')
% title('Normalizado para el pico máximo')
%
P = [4500 7797 8150 8590 8930];

IntenNorm = msnorm(VectorMasasRemuestreadas', ...
    MatrizIntesidadesAlineadas','MAX',maximo,'METHOD','Mean');

VectorMasas = VectorMasasRemuestreadas';
MatrizIntensidadesNormalizadas = IntenNorm';

end

