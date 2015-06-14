% Proposito de la funcion
function [] = mainAlgoritmoDeteccionZonasBiomarcacion()
% Descripcion de la funcion
clc; clear all; close all; 

ToolboxAndData = CargarToolboxAndData(1); clc

fprintf('======================================================\n')
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
fprintf('%s                 ING. JORGE CARVAJAL, M.Sc.         %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s TEMA:                                              %s\n',91,93)
fprintf('%s     DISEÑO DE UN ALGORITMO PARA LA DETECCION Y     %s\n',91,93)
fprintf('%s VALIDACION DE PATRONES DE BIOMARCACION EN CONJUNTOS%s\n',91,93)
fprintf('%s      DE MEDICIONES DE ESPECTROMETRIA DE MASAS      %s\n',91,93)
fprintf('%s           APLICADOS AL ESTUDIO DEL CANCER          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('======================================================\n')

fprintf('======================================================\n')
fprintf('%s                 ALGORITMO DE DATOS             %s\n',20,22)
fprintf('======================================================\n')
% 

fprintf('1. Deteccion de Zonas de Biomarcacion en conjunto\n')
fprintf('   ARCENE\n')
fprintf('2. Deteccion de Zonas de Biomarcacion en conjunto\n')
fprintf('   OvarianCDPostQAQC\n')
fprintf('3. Deteccion de Zonas de Biomarcacion en conjunto\n')
fprintf('   OvarianData WCX2 CSV\n')
fprintf('4. Deteccion de Zonas de Biomarcacion en conjunto\n')
fprintf('   OvarianDataset8-7-02\n')


%=========================================================================%
 
addpath(ToolboxAndData.data{1});

n = input('Ingrese una opcion: ');
switch n
   case 1

       
%============================= CONJUNTO ARCENE ===========================%
fprintf('======================================================\n')
fprintf('%s                 CONJUNTO ARCENE             %s\n',20,22)
fprintf('======================================================\n') 
      
       clear n;
       
       fprintf('\n 1. Procesamiento \n')
       fprintf('\n 2. Selección de Características \n')
       fprintf('\n 3. Validación \n')
       fprintf('\n')
       n = input('Ingrese una opcion: '); 
       switch n
           case 1
               %Se cargan y agrupan las mediciones del conjunto arcene 
               %disponible en la pagina web 
               % 
               %              
               
               % Estos datos son finalmente agrupados Y guardados
               % en el archivo de la carpeta datos procesados
               % arcene.mat
               arceneProcessing()
           
           case 2
               FeatureSelectionArcene()
           
           case 3
               FeatureValidationArcene()
               
           otherwise
               fprintf('No es una opcion valida')
       end
       
    case 2
       
%============================ CONJUNTO OvarianCDPostQAQC =================%

fprintf('======================================================\n')
fprintf('%s            CONJUNTO OvarianCDPostQAQC            %s\n',20,22)
fprintf('======================================================\n') 
       
       clear n;
       
       fprintf('\n 1. Procesamiento \n')
       fprintf('\n 2. Selección de Características \n')
       fprintf('\n 3. Validación \n')
       fprintf('\n')
      
       n = input('Ingrese una opción: '); 
       
       switch n
       
           case 1
               % Datos obtenidos de un conjunto de estudio de cáncer de 
               % ovario, a través de la técnica SELDI-TOF para la 
               % recopilación de datos.
               %
               % Se asigna G1 para el grupo cáncer que consta de 121 
               % muestras y G2 para el grupo normal con 95 muestras.
             
               OvarianCDPostQAQCProcessing()
           
           case 2
               
               FeatureSelectionOvarianCDPostQAQC()
           
           case 3
               
               FeatureValidationOvarianCDPostQAQC()
               
           otherwise
               fprintf('No es una opcion válida')
       end
       %==================================================================%
       
       case 3
       
%============================ CONJUNTO OvarianDataWCX2CSV =================%

fprintf('======================================================\n')
fprintf('%s            CONJUNTO OvarianDataWCX2CSV            %s\n',20,22)
fprintf('======================================================\n') 
       
       clear n;
       
       fprintf('\n 1. Procesamiento \n')
       fprintf('\n 2. Selección de Características \n')
       fprintf('\n 3. Validación \n')
       fprintf('\n')
      
       n = input('Ingrese una opción: '); 
       
       switch n
       
           case 1
               % Datos obtenidos de un conjunto de estudio de cáncer de 
               % ovario, a través de la técnica SELDI-TOF para la 
               % recopilación de datos.
               %
               % Se asigna G1 para el grupo cáncer que consta de 100 
               % muestras y G2 para el grupo normal con 100 muestras.
             
               OvarianDataWCX2CSVProcessing()
           
           case 2
               
               FeatureSelectionOvarianDataWCX2CSV()
           
           case 3
               
               FeatureValidationOvarianDataWCX2CSV()
               
           otherwise
               fprintf('No es una opcion válida')
       end
       
   case 4
     