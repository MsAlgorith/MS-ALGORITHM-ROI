%% Ovarian Data WCX2 CSV
function [] = OvarianDataWCX2CSVProcessing()
% DESCRIPCION DEL CONJUNTO
% Datos obtenidos de un conjunto de estudio de cáncer de ovario, a través
% de la técnica SELDI-TOF y el chip WCX2 para la recopilación de datos el
% 03/04/2002.
% Se asigna G1 para el grupo cáncer que consta de 100 muestras 
% y G2 para el grupo control con 100 muestras y G3 con 16 muestras. 
% Son datos de baja resolución.

fprintf('======================================================\n')
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
fprintf('======================================================\n')


fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s        OvarianDataWCX2CSVProcessing                %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')


clear all; clc; % borra y limpia la pantalla

ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio

addpath(ToolboxAndData.data{1})

fprintf('Leyendo datos del Grupo CANCER\n')
cd(ToolboxAndData.data{8})
[DatosA, nA] = CargarDatos(2);
cd(ToolboxAndData.data{9})
[DatosB, nB] = CargarDatos(2);
fprintf('Leyendo datos del Grupo CONTROL\n')
cd(ToolboxAndData.data{10});
[DatosC, nC] = CargarDatos(2);
cd(ToolboxAndData.data{11});
[DatosD, nD] = CargarDatos(2);
cd(ToolboxAndData.data{5}); 

% Remuestreado a 10000, eliminado valores negativos
%[ MzRemBen,IntenRemBen] = Remuestreo( DatosBe, nBe )
[ VectorMasasRemuestreadaGrupoA,MatrizIntensidadRemuestreadaGrupoA ] = Remuestreo( DatosA, nA,2);
[ VectorMasasRemuestreadaGrupoB,MatrizIntensidadRemuestreadaGrupoB ] = Remuestreo( DatosB, nB,2);
[ VectorMasasRemuestreadaGrupoC,MatrizIntensidadRemuestreadaGrupoC ] = Remuestreo( DatosC, nC,2);
[ VectorMasasRemuestreadaGrupoD,MatrizIntensidadRemuestreadaGrupoD ] = Remuestreo( DatosD, nD,2);

%comentado por pruebas
%MatrizIntensidadRemuestreadaGrupo1 = vertcat(MatrizIntensidadRemuestreadaGrupoA,MatrizIntensidadRemuestreadaGrupoB);
MatrizIntensidadRemuestreadaGrupo1 = vertcat(MatrizIntensidadRemuestreadaGrupoA);

%comnetado por pruebas
%MatrizIntensidadRemuestreadaGrupo2 = vertcat(MatrizIntensidadRemuestreadaGrupoC,MatrizIntensidadRemuestreadaGrupoD);
MatrizIntensidadRemuestreadaGrupo2 = vertcat(MatrizIntensidadRemuestreadaGrupoC);

MatrizIntensidadesRemuestreadas = vertcat(MatrizIntensidadRemuestreadaGrupo1,MatrizIntensidadRemuestreadaGrupo2);
VectorMasasRemuestreadaGrupo1 = mean(vertcat(VectorMasasRemuestreadaGrupoA,VectorMasasRemuestreadaGrupoB));
VectorMasasRemuestreadaGrupo2 = mean(vertcat(VectorMasasRemuestreadaGrupoC,VectorMasasRemuestreadaGrupoD));
VectorMasasRemuestreadas = mean(vertcat(VectorMasasRemuestreadaGrupo1,VectorMasasRemuestreadaGrupo2));

clear DatosGrupo1 nG1 DatosGrupo2 nG2
clear VectorMasasRemuestreadaGrupo1 VectorMasasRemuestreadaGrupo2

%Correccion de linea de base 
ventana=95;
[MatrizIntesidadesCorregidas ] = CorreccionLineaBase( VectorMasasRemuestreadas,MatrizIntensidadesRemuestreadas, ventana);

% Alineación 
P = [4050 4650 8050 8450 9300];

[IntensAlinG1G2] = alineacion( VectorMasasRemuestreadas,MatrizIntesidadesCorregidas,P);

% Normalización
[ IntenNormG1G2 ] = normalizacion( VectorMasasRemuestreadas,IntensAlinG1G2,100 );

% Suavizado: Reduccion de ruido y nitidez
[MxIntenG1G2] = suavizadoSavitzkyGolay( VectorMasasRemuestreadas,IntenNormG1G2,3 );

% GRÁFICAS DE TODO EL PREPROCESAMIENTO
graficasPreprocesamiento(VectorMasasRemuestreadas',MatrizIntensidadesRemuestreadas',MatrizIntesidadesCorregidas',IntensAlinG1G2',MxIntenG1G2');
% 
%Creación de etiquetas 
%G1 cancer, G2 control
% Creación de etiquetas G1 cancer, G2 normal2d
EtiquetasGrupo1= repmat('cancer',length(mean(MatrizIntensidadRemuestreadaGrupo1')),1);
EtiquetasGrupo1 = cellstr(EtiquetasGrupo1);
EtiquetasGrupo2 = repmat('control',length(mean(MatrizIntensidadRemuestreadaGrupo2')),1);
EtiquetasGrupo2 = cellstr(EtiquetasGrupo2);

datosG1G2 = MxIntenG1G2';
cd(ToolboxAndData.data{6})
save OvarianDataWCX2CSV.mat  datosG1G2 EtiquetasGrupo1 EtiquetasGrupo2 VectorMasasRemuestreadas
cd(ToolboxAndData.data{5})
clear all
end
