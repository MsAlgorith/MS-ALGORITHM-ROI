%proposito de la funcion
function [] = FeatureSelectionArcene()
%descripcion
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
fprintf('%s            FEATURE SELECTION ARCENE                %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Funcion que primero carga los datos de los archivos%s\n',20,22)
fprintf('%s arcene.mat, agrupando los datos y las matrices para%s\n',20,22)
fprintf('%s de esta forma ir tomando un rango de valores        %s\n',20,22)
fprintf('%s aleatoriamente para realizar las pruebas y el      %s\n',20,22)
fprintf('%s entrenamiento en cada uno de los conjuntos por medio%s\n',20,22)
fprintf('%s del t-test se obtiene un P-valor luego filtra,     %s\n',20,22)
fprintf('%s ordena y evalua el overfifting y asi repite n veces %s\n',0,22)
fprintf('%s para seleccionar un subconjunto y definir fronteras%s\n',20,22)
fprintf('%s con espacios comunes y validar finalmente con el   %s\n',20,22)
fprintf('%s algoritmo Adaboost M1                              %s\n',20,22)
fprintf('%s %s\n',20,22)
fprintf('%s %s\n',20,22)

fprintf('======================================================\n')

% Descripcion
%
clc; clear all; close all;

%genera los paths de los datos y el toolbox
ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio
addpath(ToolboxAndData.data{1});
cd(ToolboxAndData.data{6});

% carga
load Arcene.mat
%estructura de path de directorios
cd(ToolboxAndData.data{5});

%http://www.mathworks.com/help/stats/examples/selecting-features-for-classifying-high-dimensional-data.html
%Agrupo datos 
AgruparEtiquetas= vertcat(EtiquetasGrupo1,EtiquetasGrupo2);
%agrupo matrices datos
Mediciones = vertcat(DatosGrupo1,DatosGrupo2);

%generador de numeros aleatorios

% division de conjuntos en entrenamiento y test
[IndicesParticionConjunto,  ...
    DatosEntrenamiento, DatosPrueba,  EtiquetasDatosEntrenamiento, ...
    EtiquetasDatosPrueba ] = DivisionConjuntoTrainAndTest(Mediciones, ...
    AgruparEtiquetas,5000,50);

DatosEntrenamientoG1 = DatosEntrenamiento(grp2idx(EtiquetasDatosEntrenamiento)==1,:);
DatosEntrenamientoG2 = DatosEntrenamiento(grp2idx(EtiquetasDatosEntrenamiento)==2,:);

%Pruebas estadisticas
[h_ttest,p_ttest,ci_ttest] = ttest2(DatosEntrenamientoG1,DatosEntrenamientoG2,'Vartype','unequal');
%`
[ p_Wilcoxon, h_Wilcoxon ] = PruebaWilcoxon(DatosGrupo1,DatosGrupo2);
%
[ p_chi2, h_chi2 ] = ChiCuadradoBondadAjuste( DatosGrupo1,DatosGrupo2);

%%+



figure
ecdf(p_ttest); % funcion empirica acumulada de distribuciuón de los p valores  
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad T-test Arcene')

figure
ecdf(p_Wilcoxon)% el 95%de los datos son utilizables, en teoria no esta mal.
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad Wilcoxon Arcene')

figure
ecdf(p_chi2)% el 95%de los datos son utilizables, en teoria no esta mal.
h1 = get(gca,'children'); %
set(h1,'LineWidth',2,'Color','r');
xlabel('P value');
ylabel('CDF value');
title('Funcion de Probabilidad Chi2 Arcene')


[~,CoeficientesIndicesP_ttest]= sort(p_ttest,2); % sort the features(ORDENAR indices)

[~,CoeficientesIndicesP_Wilcoxon]= sort(p_Wilcoxon,2); % sort the features(ORDENAR indices)

[~,CoeficientesIndicesP_chi2]= sort(p_chi2,2); % sort the features(ORDENAR indices)



GruposDeBusquedaSobreentrenamiento = 100:100:2000; %20% DE 10000   

rng(7000,'multFibonacci');
%busqueda inflexion sobreentrenamiento
ErroresClasificacion_ttest = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% este esl el codigo nuevo
% entender por favor y replicar
for i=1:20
   i
   fs_ttest = CoeficientesIndicesP_ttest(1:GruposDeBusquedaSobreentrenamiento(i));
   %rng(5000,'multFibonacci'); %GENERADOR DE NUMEROS ALEATORIOS
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_ttest),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree','CrossVal','on');
   testMCE_ttest(i) = kfoldLoss(ClassTreeEns);
   clear ClassTreeEns
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_ttest),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');
   resubMCE_ttest(i) = resubLoss(ClassTreeEns,'mode','ensemble','learners',100);
   clear ClassTreeEns
end
 plot(GruposDeBusquedaSobreentrenamiento(1:20), testMCE_ttest,'-o', ...
     GruposDeBusquedaSobreentrenamiento(1:20),resubMCE_ttest,'-r^');
 xlabel('Number of Features');
 ylabel('MCE');
 legend({'MCE on the test set' 'Resubstitution MCE'},'location','SE');
 title('Simple Filter Feature Selection Method');
 
 
 
 for i=1:20
   i
  fs_Wilcoxon = CoeficientesIndicesP_Wilcoxon(1:GruposDeBusquedaSobreentrenamiento(i));
   %rng(5000,'multFibonacci'); %GENERADOR DE NUMEROS ALEATORIOS
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_Wilcoxon),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree','CrossVal','on');
   testMCE_Wilcoxon(i) = kfoldLoss(ClassTreeEns);
   clear ClassTreeEns
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_Wilcoxon),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');
   resubMCE_Wilcoxon(i) = resubLoss(ClassTreeEns,'mode','ensemble','learners',100);
   clear ClassTreeEns
end
 plot(GruposDeBusquedaSobreentrenamiento(1:20), testMCE,'-o', ...
     GruposDeBusquedaSobreentrenamiento(1:20),resubMCE,'-r^');
 xlabel('Number of Features');
 ylabel('MCE');
 legend({'MCE on the test set' 'Resubstitution MCE'},'location','SE');
 title('Simple Filter Feature Selection Method');
 
 
  for i=1:20
   i
  fs_chi2 = CoeficientesIndicesP_chi2(1:GruposDeBusquedaSobreentrenamiento(i));
   %rng(5000,'multFibonacci'); %GENERADOR DE NUMEROS ALEATORIOS
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_chi2),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree','CrossVal','on');
   testMCE_chi2(i) = kfoldLoss(ClassTreeEns);
   clear ClassTreeEns
   ClassTreeEns = fitensemble(DatosEntrenamiento(:,fs_chi2),EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');
   resubMCE_chi2(i) = resubLoss(ClassTreeEns,'mode','ensemble','learners',100);
   clear ClassTreeEns
end
 plot(GruposDeBusquedaSobreentrenamiento(1:20), testMCE,'-o', ...
     GruposDeBusquedaSobreentrenamiento(1:20),resubMCE,'-r^');
 xlabel('Number of Features');
 ylabel('MCE');
 legend({'MCE on the test set' 'Resubstitution MCE'},'location','SE');
 title('Simple Filter Feature Selection Method');
 
 
%% hasta aqui es el codigo nuevo

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


ErroresClasificacion_chi2 = [];
GruposDeBusquedaSobreentrenamiento = 100:100:8000; %20% DE 10000   
rng(3000,'multFibonacci');
%aplicacion prueba chi2
for i=1:80;
    i
    fs_chi2 = CoeficientesIndicesP_chi2(1:GruposDeBusquedaSobreentrenamiento(i));
    %crea clasificador Clasificador
    Clasificador_chi2 = fitensemble(DatosEntrenamiento(:,fs_chi2),...
        EtiquetasDatosEntrenamiento,'AdaBoostM1',100,'Tree');

    %error de clasificacion
    hold on
    %figure
    ErrorClasificador_chi2 = loss(Clasificador_chi2,DatosPrueba(:,fs_chi2),...
        EtiquetasDatosPrueba,'mode','cumulative');
    ErroresClasificacion_chi2(i) = mean(ErrorClasificador_chi2);
    bar(i,mean(ErrorClasificador_chi2));
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


%%



%%


%imprimo datos
MZ = 1:10000';
Y = abs(Mediciones');
fs = CoeficientesIndicesP(1:GruposDeBusquedaSobreentrenamiento(7));
xAxisLabel = 'Mass/Charge (M/Z)';       % x label for plots
yAxisLabel = 'Relative Ion Intensity';  % y label for plots
fig = figure; 
hax = axes; 
hold on;
hC = plot(MZ,Y(:,1:15) ,'b');
hN = plot(MZ,Y(:,141:155),'g');
SP = MZ(fs);
hG = plot(MZ(fs(ceil((1:3*length(fs) )/3))), max(max(Mediciones))*...
    repmat([0 1 NaN],1,length(fs)),'r');
xlabel(xAxisLabel); 
ylabel(yAxisLabel);
axis('tight');
legend([hN(1),hC(1),hG(1)],{'Control','Ovarian Cancer',...
    'New Discriminative Features'},2);
title('Mass Spectrometry Data with Discriminative Features found by Genetic Algorithm t-test');

cd(ToolboxAndData.data{7})
save ArceneFeatures Y MZ AgruparEtiquetas fs 
cd(ToolboxAndData.data{5})

clear all

%genera los paths de los datos y el toolbox
ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio
cd(ToolboxAndData.data{7});
load ArceneFeatures
cd(ToolboxAndData.data{5});
format long g
bar(1:700,sort(fs));  %226,7454,

fs;
[a,b] = size(fs);
fsord = sort(fs,2);
for i = 1:b-1;
    aux(i) = fsord(i)-fsord(i+1);
    aux = unique(abs(aux));
    size(abs(aux));
end
fss=sort(fs,2);
for j=1:b;
    for i=1:length(aux);
        zonas(i)=length(fss(diff(fss)==aux(i)));
    end
    zonas = unique(zonas);
end
[xx1,xx2] = size(zonas);

agrupar = xx2;

indx = clusterdata(fs',agrupar);
indx = indx';

featMean = [];
for i = 1:agrupar; % 25 numero de zonas
featMean(i) = mean(fs(find(indx==i)));
end

featMean = featMean';
featRed = [];

%CLUSTER GEOMRTRICO
for i = 1:agrupar;
    prueba = featMean(i);
    for j = 1:length(fs);
        indxSup = find(fs>prueba);
        indInf = find(fs<prueba); 
        %clear prueba
    end
    prueba;
    vectOrdenadosS = sort(fs(indxSup),'ascend');
    indxSupM = find(fs==vectOrdenadosS(1));
    %w = waitforbuttonpress;
    vectOrdenadosI = sort(fs(indInf),'descend');
    indInfM = find(fs==vectOrdenadosI(1));
    %w = waitforbuttonpress;
    clear prueba
    featRed(2*i-1) = indxSupM(1); 
    featRed(2*i) = indInfM(1);
    fs(featRed);
end

fss = fs(unique(featRed)); % toma valores q no se repiten

feattFinal = fss;
xAxisLabel = 'Mass/Charge (M/Z)';       % x label for plots
yAxisLabel = 'Relative Ion Intensity';  % y label for plots
fig = figure; hax = axes; hold on;
hC = plot(MZ,Y(:,1:15) ,'b');
hN = plot(MZ,Y(:,141:155),'g');
SP = MZ(feattFinal);
hG = plot(MZ(fss(ceil((1:3*length(fss) )/3))), max(max(Y))*repmat([0 1 NaN],1,length(fss)),'r');
xlabel(xAxisLabel); ylabel(yAxisLabel);
axis('tight');
legend([hN(1),hC(1),hG(1)],{'Control','Ovarian Cancer', 'New Discriminative Features'},2);
title('Mass Spectrometry Data with Discriminative Features found by Genetic Algorithm');

cd(ToolboxAndData.data{7});
save ArceneFeatures Y MZ AgruparEtiquetas fs fss 
cd(ToolboxAndData.data{5});

clear all