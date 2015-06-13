function [] = FeatureSelectionOvarianDataWCX2CSV ()

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
fprintf('%s                 ING. JORGE CARVAJAL, MSC           %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s TEMA:                                              %s\n',91,93)
fprintf('%s     DISEÑO DE UN ALGORITMO PARA LA DETECCION Y     %s\n',91,93)
fprintf('%s VALIDACION DE PATRONES DE BIOMARCACION EN CONJUNTOS%s\n',91,93)
fprintf('%s      DE MEDICIONES DE ESPECTROMETRIA DE MASAS      %s\n',91,93)
fprintf('%s           APLICADOS AL ESTUDIO DEL CANCER          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('********************************************************\n')

fprintf('======================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s    FEATURE SELECTION OvarianCDPostQAQC             %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s %s\n',20,22)
fprintf('%s %s\n',20,22)
fprintf('%s        %s\n',20,22)
fprintf('%s    %s\n',20,22)
fprintf('%s %s\n',20,22)
fprintf('%s     %s\n',20,22)
fprintf('%s  %s\n',0,22)
fprintf('%s %s\n',20,22)
fprintf('%s    %s\n',20,22)
fprintf('%s                               %s\n',20,22)
fprintf('%s %s\n',20,22)
fprintf('%s %s\n',20,22)

fprintf('======================================================\n')

% Descripcion
%

% carga
clc; clear all; close all;

%genera los paths de los datos y el toolbox
ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio
addpath(ToolboxAndData.data{1});
cd(ToolboxAndData.data{6});

load OvarianDataWCX2CSV.mat
%estructura de path de directorios
cd(ToolboxAndData.data{5});

%http://www.mathworks.com/help/stats/examples/selecting-features-for-classifying-high-dimensional-data.html
%Agrupo datos 

AgruparEtiquetas = vertcat(EtiquetasGrupo1,EtiquetasGrupo2);
%agrupo matrices datos

Mediciones = datosG1G2;

%generador de numeros aleatorios

% division de conjuntos en entrenamiento y test
[IndicesParticionConjunto,  ...
    DatosEntrenamiento, DatosPrueba,  EtiquetasDatosEntrenamiento, ...
    EtiquetasDatosPrueba ] = DivisionConjuntoTrainAndTest(Mediciones', ...
    AgruparEtiquetas,5000,50);

DatosEntrenamientoG1 = DatosEntrenamiento(grp2idx(EtiquetasDatosEntrenamiento)==1,:);
DatosEntrenamientoG2 = DatosEntrenamiento(grp2idx(EtiquetasDatosEntrenamiento)==2,:);

%Pruebas estadisticas
[h_ttest,p_ttest,ci_ttest] = ttest2(DatosEntrenamientoG1, ...
    DatosEntrenamientoG2 ,'Vartype','equal');
%
[ p_Wilcoxon, h_Wilcoxon ] = PruebaWilcoxon(DatosEntrenamientoG1,DatosEntrenamientoG2);
%
[ p_chi2, h_chi2 ] = ChiCuadradoBondadAjuste(DatosEntrenamientoG1,DatosEntrenamientoG2);

%%
figure
ecdf(p_ttest)% el 95%de los datos son utilizables, en teoria no esta mal.
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad T-test OvarianDataWCX2CSV')


figure
ecdf(p_Wilcoxon)% el 95%de los datos son utilizables, en teoria no esta mal.
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad Wilcoxon OvarianDataWCX2CSV')

figure
ecdf(p_chi2)% el 95%de los datos son utilizables, en teoria no esta mal.
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad Chi2 OvarianDataWCX2CSV')

%%

[~,CoeficientesIndicesP_ttest]= sort(p_ttest,2); % sort the features(ORDENAR indices)

[~,CoeficientesIndicesP_Wilcoxon]= sort(p_Wilcoxon,2); % sort the features(ORDENAR indices)

[~,CoeficientesIndicesP_chi2]= sort(p_chi2,2); % sort the features(ORDENAR indices)



GruposDeBusquedaSobreentrenamiento = 100:100:2000; %20% DE 10000   
rng(3000,'multFibonacci');

%busqueda inflexion sobreentrenamiento
ErroresClasificacion_ttest = [];
for i=1:20;
    i
    fs_ttest = CoeficientesIndicesP_ttest(1:GruposDeBusquedaSobreentrenamiento(i));
    %crea clasificador Clasificador
    Clasificador_ttest = fitensemble(DatosEntrenamiento(:,fs_ttest),...
        EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');
    %error de clasificacion ttest
    hold on
    ErrorClasificador_ttest = loss(Clasificador_ttest,DatosPrueba(:,fs_ttest),...
        EtiquetasDatosPrueba,'mode','cumulative');
    ErroresClasificacion_ttest(i) = mean(ErrorClasificador_ttest);
    bar(i,mean(ErrorClasificador_ttest));
    xlabel('Number of Rundes');
    ylabel('Generalization Error');
    hold off
end


ErroresClasificacion_Wilcoxon = [];
GruposDeBusquedaSobreentrenamiento = 100:100:3500; %20% DE 10000   
rng(3000,'multFibonacci');
%busqueda inflexion sobreentrenamiento
for i=1:35;
    i
    fs_Wilcoxon = CoeficientesIndicesP_Wilcoxon(1:GruposDeBusquedaSobreentrenamiento(i));
    %crea clasificador Clasificador
    Clasificador_Wilcoxon = fitensemble(DatosEntrenamiento(:,fs_Wilcoxon),...
        EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');

    %error de clasificacion
    hold on
    %figure
    ErrorClasificador_Wilcoxon = loss(Clasificador_Wilcoxon,DatosPrueba(:,fs_Wilcoxon),...
        EtiquetasDatosPrueba,'mode','cumulative');
    ErroresClasificacion_Wilcoxon(i) = mean(ErrorClasificador_Wilcoxon);
    bar(i,mean(ErrorClasificador_Wilcoxon));
    xlabel('Number of Rundes');
    ylabel('Generalization Error');
    hold off
end


%%
% Busqueda de Minimo relativo ttest
for i=1:length(ErroresClasificacion_ttest)
    if ErroresClasificacion_ttest(i+1)> ErroresClasificacion_ttest(i)
        Iteracion_ttest = i;
            break
    end
end; clear auxMin;
% Busqueda de Minimo relativo _Wilcoxon
for i=1:length(ErroresClasificacion_Wilcoxon)
    if ErroresClasificacion_Wilcoxon(i+1)> ErroresClasificacion_Wilcoxon(i)
        Iteracion_Wilcoxon = i;
            break
    end
end; clear auxMin;
% Busqueda de Minimo relativo _chi2
for i=1:length(ErroresClasificacion_chi2)
    if ErroresClasificacion_chi2(i+1)> ErroresClasificacion_chi2(i)
        Iteracion_chi2 = i;
            break
    end
end; clear auxMin;