function [MatrizIntensidadesSuavizadas,VectorMasasSuavizado] = ...
    suavizadoSavitzkyGolay( VectorMasasNormalizadas, ...
    MatrizIntensidadesNormalizadas,gradoPolinomio )
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


fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s        SUAVIZADO SAVITZKY Y GOLAY                  %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Función que elimina los picos de iones falsos      %s\n',20,22)
fprintf('%s reduciendo el ruido y suavizando la curva. Dicha   %s\n',20,22)
fprintf('%s función emplea un filtro Savitzky–Golay, filtro    %s\n',20,22)
fprintf('%s tipo polinomio.                                    %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')

% Función que elimina los picos de iones falsos reduciendo el ruido y 
% suavizando la curva. Dicha función emplea un filtro Savitzky–Golay, 
% filtro tipo polinomio.
% -------------------------------------------------------------------------
%SINTAXIS: [IntensidadGolay] = SuavizadoGolay(VectorMasasNormalizadas,MatrizIntensidadesNormalizadas)
%PARAMETROS:
%   VMasas = Masas remuestreadas a 10000 puntos
%   MatrizIntensidadesNormalizadas=matriz de intensidades normalizadas a 100
%   MatrizIntensidadesSuavizadass= matriz sin ruido
% EJEMPLO:
% load sample_lo_res
% YS = mssgolay(MZ_lo_res,Y_lo_res, 'SPAN',20, 'ShowPlot', 3);
% axis([7500 8500 -1 100])
% IntensidadGolay =  mssgolay(VectorMasasNormalizadas',MatrizIntensidadesNormalizadas');
% IntensidadGolay =  mssgolay(VectorMasasNormalizadas',MatrizIntensidadesNormalizadas','Span', 0.05);

IntensidadGolay =  mssgolay(VectorMasasNormalizadas', ...
    MatrizIntensidadesNormalizadas','Degree', gradoPolinomio);
MatrizIntensidadesSuavizadas = IntensidadGolay';
VectorMasasSuavizado = VectorMasasNormalizadas;

end