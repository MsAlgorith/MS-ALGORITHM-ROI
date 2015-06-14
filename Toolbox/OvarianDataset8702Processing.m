%% OvarianDataset8-7-02
function [] = OvarianDataset8702Processing()
% DESCRIPCION DEL CONJUNTO
% Datos obtenidos de un conjunto de estudio de cáncer de ovario, a través
% de la técnica SELDI-TOF y el chip WCX2 para la recopilación de datos el
% 08/07/2002.
% Se asigna G1 para el grupo control que consta de 91 muestras 
% y G2 para el grupo cancer con 162 muestras. Son datos de baja resolución.

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


fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s         OvarianDataset8702Processing               %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')

clear all; clc; % borra y limpia la pantalla

ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio

addpath(ToolboxAndData.data{1})

fprintf('Leyendo datos del Grupo CONTROL\n')
cd(ToolboxAndData.data{12})
[DatosGrupo1, nG1] = CargarDatos(2);
fprintf('Leyendo datos del Grupo CANCER\n')
cd(ToolboxAndData.data{13});
[DatosGrupo2, nG2] = CargarDatos(2);
cd(ToolboxAndData.data{5}); 

% Remuestreado a 10000, eliminado valores negativos

[VectorMasasRemuestreadaGrupo1,MatrizIntensidadRemuestreadaGrupo1] = Remuestreo(DatosGrupo1,nG1,2);
[VectorMasasRemuestreadaGrupo2,MatrizIntensidadRemuestreadaGrupo2] = Remuestreo(DatosGrupo2,nG2,2);
MatrizIntensidadesRemuestreadas = vertcat(MatrizIntensidadRemuestreadaGrupo1,MatrizIntensidadRemuestreadaGrupo2);
VectorMasasRemuestreadas = mean((vertcat(VectorMasasRemuestreadaGrupo1,VectorMasasRemuestreadaGrupo2)));

%Correccion de linea de base 
ventana=1000;
[MatrizIntesidadesCorregidas ] = CorreccionLineaBase( VectorMasasRemuestreadas,MatrizIntensidadesRemuestreadas,ventana);

% Alineación 
P = [4050 4650 8050 8450 9300];
% PBen=input('Ingrese vector P (picos de referencia): ')
[IntensAlinG1G2] = alineacion( VectorMasasRemuestreadas,MatrizIntesidadesCorregidas,P);

% Normalización
[ IntenNormG1G2 ] = normalizacion(VectorMasasRemuestreadas,IntensAlinG1G2,100);

% Suavizado: Reduccion de ruido y nitidez
[MxIntenG1G2]=suavizadoSavitzkyGolay( VectorMasasRemuestreadas,IntenNormG1G2,3 );

% GRÁFICAS DE TODO EL PREPROCESAMIENTO
graficasPreprocesamiento(VectorMasasRemuestreadas',MatrizIntensidadesRemuestreadas',MatrizIntesidadesCorregidas',IntensAlinG1G2',MxIntenG1G2')

% Creación de etiquetas G1 cancer, G2 normal
EtiqG1= repmat('control',length(mean(MatrizIntensidadRemuestreadaGrupo1')),1);
EtiqG1 = cellstr(EtiqG1);
EtiqG2 = repmat('cancer',length(mean(MatrizIntensidadRemuestreadaGrupo2')),1);
EtiqG2 = cellstr(EtiqG2);

datosG1G2=MxIntenG1G2;
cd(ToolboxAndData.data{6})
save OvarianDataset8-7-02.mat  datosG1G2  EtiqG1 EtiqG2 VectorMasasRemuestreadas
clear all
end
