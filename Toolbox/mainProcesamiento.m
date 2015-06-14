function [] = mainProcesamiento()
% mainProcesamiento.m : Procesamiento de los datos

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

%clc; clear all; close all; % limpiar y cerrar la pantalla
%clear all;  clc;
addpath('C:\Users\USUARIO\Desktop\DocumentacionYdatosTesisMS\Dropbox\Tesis y Documentacion\TesisDatosAlgoritmos\Toolbox')

fprintf('******************************************************\n')
fprintf('%s                 PROCESAMIENTO DE DATOS           %s\n',20,22)
fprintf('******************************************************\n')
%                                                                         %                                                                    %
fprintf('1. Conjunto de datos ARCENE\n')
fprintf('2. Conjunto de datos OvarianCDPostQAQC\n')
%=========================================================================%

cd('C:\Users\USUARIO\Desktop\DocumentacionYdatosTesisMS\Dropbox\Tesis y Documentacion\TesisDatosAlgoritmos\Toolbox')
n = input('Ingrese una opcion: ');
switch n
   case 1
       fprintf('******************************************************\n')
       fprintf('%s             CONJUNTO ARCENE                %s\n',20,22)
       fprintf('******************************************************\n')
       fprintf('\nProcesamiento del Conjunto ARCENE\n')
       arceneProcessing()
   
    case 2
       fprintf('******************************************************\n')
       fprintf('%s         CONJUNTO OvarianCDPostQAQ           %s\n',20,22)
       fprintf('******************************************************\n')
       fprintf('\nProcesamiento del Conjunto OvarianCDPostQAQC\n')
       OvarianCDPostQAQCProcessing()
   
    otherwise
      fprintf('No es una opcion valida')

end
%=========================================================================%