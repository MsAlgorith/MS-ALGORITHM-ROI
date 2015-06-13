function [] = arceneProcessing()

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
fprintf('%s                 ARCENE PROCESSING                  %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%sEstos datos son la fusion de tres conjuntos de datos%s\n',20,22)
fprintf('%s de espectrometria de masas para tener suficientes  %s\n',20,22)
fprintf('%s datos de entrenamiento y realizar una prueba de un %s\n',20,22)
fprintf('%s especifico. Son obtenidos a traves de la tecnica de%s\n',20,22)
fprintf('%s SELDI.                                             %s\n',20,22)
fprintf('%s Number of variables/features/attributes:           %s\n',20,22)
fprintf('%s Real: 7000                                         %s\n',20,22)
fprintf('%s Probes: 3000                                       %s\n',20,22)
fprintf('%s Total: 10000                                       %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%sFunción que carga matriz de datos y vector etiquetas%s\n',20,22)
fprintf('%s almacenados en formato ASCII                       %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('========================================================\n')

%% CONJUNTO DE DATOS ARCENE
%
% DESCRIPCION DEL CONJUNTO
% Estos datos son la fusion de tres conjuntos de datos de espectrometria 
% de masas para tener suficientes datos de entrenamiento y realizar una 
% prueba de un punto de especifico. Son obtenidos a traves de la tecnica 
% SELDI.
% Number of variables/features/attributes:
% Real: 7000
% Probes: 3000
% Total: 10000

% Función que carga matriz de datos y vector etiquetas almacenados en 
% formato ascii

clear all;  clc; %borrar todo lo anterior y limpiar la pantalla
%anadir el directorio al path de matlab

ToolboxAndData = CargarToolboxAndData(1) % 1 laptop, 2 pc escritorio
clc
addpath(ToolboxAndData.data{1});
cd(ToolboxAndData.data{2});
% Conjunto de datos arcene 200 mediciones y 10000 resolucion
% 100 mediciones para entrenamiento: 44 positivas y 56 negativas
% 100 mediciones para validacion: 44 positivas y 56 negativas
% incluye matriz de datos y vector etiquetas 

fprintf('******************************************************\n')
fprintf('%s                 CARGANDO DE DATOS                %s\n',20,22)
fprintf('******************************************************\n')
load arcene_valid.data  %matriz de validación 100x10000
load arcene_valid_labels.labels %vector etiquetas validacion
load arcene_train.data %matriz de entrenamiento 100x10000
load arcene_train_labels %vector etiquetas entrenamiento 

ConjuntoDatos = vertcat(arcene_train,arcene_valid);
EtiquetasDatos = vertcat(arcene_train_labels,arcene_valid_labels);
IndiceGrupo1 = find(EtiquetasDatos==1);
IndiceGrupo2 = find(EtiquetasDatos==-1);
DatosGrupo1 = ConjuntoDatos(IndiceGrupo1,:);
DatosGrupo2 = ConjuntoDatos(IndiceGrupo2,:);
EtiquetasGrupo2 = EtiquetasDatos(IndiceGrupo2,:);
EtiquetasGrupo1 = EtiquetasDatos(IndiceGrupo1,:);
DatosReagrupados = vertcat(DatosGrupo1,DatosGrupo2);
EtiquetasGrupo1Grupo2 = vertcat(EtiquetasGrupo1,EtiquetasGrupo2);

cd(ToolboxAndData.data{5}); 
cd(ToolboxAndData.data{6});

fprintf('******************************************************\n')
fprintf('%s            GUARDANDO DATOS EN ARCENE.MAT         %s\n',20,22)
fprintf('******************************************************\n')
save Arcene DatosGrupo1 DatosGrupo2 EtiquetasGrupo1 EtiquetasGrupo2
load Arcene


fprintf('******************************************************\n')
fprintf('%s             GRAFICAS DE GRUPO 1 Y GRUPO 2        %s\n',20,22)
fprintf('******************************************************\n')

GraficasPreprocesamientoArcene(DatosGrupo1,DatosGrupo2)
cd(ToolboxAndData.data{5});

clear all

end
