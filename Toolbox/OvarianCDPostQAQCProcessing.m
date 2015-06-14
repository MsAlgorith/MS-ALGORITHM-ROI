%% OvarianCDPostQAQC
function [] = OvarianCDPostQAQCProcessing()

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
fprintf('%s          OvarianCDPostQAQCProcessing               %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Datos obtenidos de un conjunto de estudio de cáncer%s\n',20,22)
fprintf('%s de ovario, a través de la técnica SELDI-TOF para la%s\n',20,22)
fprintf('%s recopilación de datos. Se asigna G1 para el grupo  %s\n',20,22)
fprintf('%s cáncer que consta de 121 muestras y G2 para el     %s\n',20,22)
fprintf('%s grupo normal con 95 muestras.                      %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')

% DESCRIPCION DEL CONJUNTO
% Datos obtenidos de un conjunto de estudio de cáncer de ovario, a través
% de la técnica SELDI-TOF para la recopilación de datos.
% Se asigna G1 para el grupo cáncer que consta de 121 muestras 
% y G2 para el grupo normal con 95 muestras.

clear all; clc; % borra y limpia la pantalla
ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio

addpath(ToolboxAndData.data{1})

fprintf('Leyendo datos del Grupo CANCER\n')
cd(ToolboxAndData.data{3})
[DatosGrupo1, nG1] = CargarDatos(1);

fprintf('Leyendo datos del Grupo NORMAL\n')
cd(ToolboxAndData.data{4});
[DatosGrupo2, nG2] = CargarDatos(1);
cd(ToolboxAndData.data{5}); 

% Remuestreado a 10000, eliminado valores negativos

[ VectorMasasRemuestreadaGrupo1,MatrizIntensidadRemuestreadaGrupo1] = Remuestreo(DatosGrupo1,nG1,1,10e3);
[ VectorMasasRemuestreadaGrupo2,MatrizIntensidadRemuestreadaGrupo2] = Remuestreo(DatosGrupo2,nG2,1,10e3);

%clear DatosGrupo1 nG1 DatosGrupo2 nG2

MatrizIntensidadesRemuestreadas = vertcat(MatrizIntensidadRemuestreadaGrupo1,MatrizIntensidadRemuestreadaGrupo2);
VectorMasasRemuestreadas = mean((vertcat( VectorMasasRemuestreadaGrupo1, VectorMasasRemuestreadaGrupo2)));

clear  VectorMasasRemuestreadaGrupo1  VectorMasasRemuestreadaGrupo2

%Correccion de linea de base 
ventana=50;
[MatrizIntesidadesCorregidas ] = CorreccionLineaBase( VectorMasasRemuestreadas,MatrizIntensidadesRemuestreadas,ventana);

% Alineación 
P = [4050 4650 8050 8450 9300];
% P=input('Ingrese vector P (picos de referencia): ')
[IntensAlinG1G2] = alineacion( VectorMasasRemuestreadas,MatrizIntesidadesCorregidas,P);

% Normalización
[ IntenNormG1G2 ] = normalizacion( VectorMasasRemuestreadas,MatrizIntesidadesCorregidas,100);

% Suavizado: Reduccion de ruido y nitidez
[MxIntenG1G2] = suavizadoSavitzkyGolay( VectorMasasRemuestreadas,IntenNormG1G2,3 );

% GRÁFICAS DE TODO EL PREPROCESAMIENTO
graficasPreprocesamiento(VectorMasasRemuestreadas',MatrizIntensidadesRemuestreadas',MatrizIntesidadesCorregidas',IntensAlinG1G2',MxIntenG1G2');

%Creación de etiquetas 
%G1 cancer, G2 normal
EtiquetasGrupo1= repmat('Cancer',length(mean(MatrizIntensidadRemuestreadaGrupo1')),1);
EtiquetasGrupo1 = cellstr(EtiquetasGrupo1);
EtiquetasGrupo2 = repmat('Normal',length(mean(MatrizIntensidadRemuestreadaGrupo2')),1);
EtiquetasGrupo2 = cellstr(EtiquetasGrupo2);

datosG1G2 = MxIntenG1G2;
cd(ToolboxAndData.data{6});
save OvarianCD_PostQAQC.mat  datosG1G2  EtiquetasGrupo1 EtiquetasGrupo2 VectorMasasRemuestreadas

clear all
end
