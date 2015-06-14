function [] = FeatureValidationArcene()

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
fprintf('%s                 ING. JORGE CARVAJAL, MsC           %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('%s TEMA:                                              %s\n',91,93)
fprintf('%s     DISEÑO DE UN ALGORITMO PARA LA DETECCION Y     %s\n',91,93)
fprintf('%s VALIDACION DE PATRONES DE BIOMARCACION EN CONJUNTOS%s\n',91,93)
fprintf('%s      DE MEDICIONES DE ESPECTROMETRIA DE MASAS      %s\n',91,93)
fprintf('%s           APLICADOS AL ESTUDIO DEL CANCER          %s\n',91,93)
fprintf('%s                                                    %s\n',91,93)
fprintf('======================================================\n')

fprintf('======================================================\n')
fprintf('%s           FEATURE VALIDATION ARCENE              %s\n',20,22)
fprintf('======================================================\n')

clear all  % limpiar todo
%Genera los paths de los datos y el toolbox
ToolboxAndData = CargarToolboxAndData(1); % 1 laptop, 2 pc escritorio
cd(ToolboxAndData.data{7})
load ArceneClass
cd(ToolboxAndData.data{5})

holdoutCVP = cvpartition(grp,'holdout',5)
dataTrain = Y(:,holdoutCVP.training);
dataTest = Y(:,holdoutCVP.test);
grpTrain = grp(holdoutCVP.training,:);
grpTest = grp(holdoutCVP.test,:);

featfull = unique(horzcat(fss))

X = (dataTrain(featfull,:))';
Y = grpTrain; Y=Y';
featfull = unique(horzcat(fss))
X = dataTrain(featfull,:);

rng default % For reproducibility
T = 500;
adaStump = fitensemble(X',Y','AdaBoostM1',T,'Tree');
totalStump = fitensemble(X',Y','TotalBoost',T,'Tree');
lpStump = fitensemble(X',Y','LPBoost',T,'Tree');
figure;
plot(resubLoss(adaStump,'Mode','Cumulative'));
hold on
plot(resubLoss(totalStump,'Mode','Cumulative'),'r');
plot(resubLoss(lpStump,'Mode','Cumulative'),'g');
hold off
xlabel('Number of stumps');
ylabel('Training error');
legend('AdaBoost','TotalBoost','LPBoost','Location','NE');

[adaStump.NTrained totalStump.NTrained lpStump.NTrained]

cvlp = crossval(lpStump,'KFold',2);
cvtotal = crossval(totalStump,'KFold',2);
cvada = crossval(adaStump,'KFold',2);

figure;
plot(kfoldLoss(cvada,'Mode','Cumulative'));
hold on
plot(kfoldLoss(cvtotal,'Mode','Cumulative'),'r');
plot(kfoldLoss(cvlp,'Mode','Cumulative'),'g');
hold off
xlabel('Ensemble size');
ylabel('Cross-validated error');
legend('AdaBoost','TotalBoost','LPBoost','Location','NE');

cada = compact(adaStump);
clp = compact(lpStump);
ctotal = compact(totalStump);

figure
subplot(2,1,1)
plot(clp.TrainedWeights)
title('LPBoost weights')
subplot(2,1,2)
plot(ctotal.TrainedWeights)
title('TotalBoost weights')

cada = removeLearners(cada,150:cada.NTrained);
clp = removeLearners(clp,60:clp.NTrained);
ctotal = removeLearners(ctotal,40:ctotal.NTrained);

[loss(cada,X',Y') loss(clp,X',Y') loss(ctotal,X',Y')]

figure
hold on
plot(loss(cada,X',Y','Mode','Cumulative'),'--b','LineWidth',2)
plot(loss(clp,X',Y','Mode','Cumulative'),'-r','LineWidth',2)
plot(loss(ctotal,X',Y','Mode','Cumulative'),'-m','LineWidth',2)
grid on
xlabel('Ensemble size');
ylabel('Cross-validated error');
legend('AdaBoost','TotalBoost','LPBoost','Location','NE');
title('validacion usando adaboost varianten')
hold off

%%
cd(ToolboxAndData.data{2})
load arcene_test.data
cd(ToolboxAndData.data{5})
deteccion = predict(cada,(arcene_test(:,featfull)))
positiv = length(deteccion(find(deteccion>0)))
negativ = length(deteccion(find(deteccion<0)))

%%
clear all
load ArceneData
load ArceneFeatures
load ArceneClass

%figure
xAxisLabel = 'Mass/Charge (M/Z)';       % x label for plots
yAxisLabel = 'Relative Ion Intensity';  % y label for plots
fig = figure; hax = axes; hold on;
hC = plot(MZ,Y(:,1:15) ,'b');
hN = plot(MZ,Y(:,141:155),'g');
SP = MZ(horzcat(fss,fssw));
fxx = horzcat(fss,fssw);
hG = plot(MZ(fxx(ceil((1:3*length(fxx) )/3))), max(max(dataReagrupado))...
    *repmat([0 1 NaN],1,length(fxx)),'r');
hXLabel = xlabel(xAxisLabel); hYLabel = ylabel(yAxisLabel);
axis('tight');
legend([hN(1),hC(1),hG(1)],{'Control','Ovarian Cancer',...
    'New Discriminative Features'},2);
% title('Mass Spectrometry Data with Discriminative Features found 
% by Wilcoxon-test');
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.0 .0 .0], ...
  'YColor'      , [.0 .0 .0], ...
  'YTick'       , 0:100:900, ...
  'XTick'       , 0:500:10000, ...
  'LineWidth'   , 1         );
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );


%%
clear all
load DataArcene
load ArceneFeatures
load ArceneClass

fxx = horzcat(fss,fssw);
xAxisLabel = 'Mass/Charge (M/Z)';       % x label for plots
yAxisLabel = 'Relative Ion Intensity';  % y label for plots
fig = figure; hax = axes; hold on;
Y = Y(fxx,:);
hC = stem(MZ(horzcat(fss,fssw)),(Y(:,1:15)) ,'b');
hN = stem(MZ(horzcat(fss,fssw)),Y(:,141:155),'g');
SP = MZ(horzcat(fss,fssw));
hXLabel = xlabel(xAxisLabel); hYLabel = ylabel(yAxisLabel);

legend([hN(1),hC(1)],{'Control','Ovarian Cancer'},2);
% title('Mass Spectrometry Data with Discriminative Features found 
% by Wilcoxon-test');
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.0 .0 .0], ...
  'YColor'      , [.0 .0 .0], ...
  'YTick'       , 0:100:900, ...
  'XTick'       , 0:500:10000, ...
  'LineWidth'   , 1         );
set( gca                       , ...
    'FontName'   , 'Helvetica' );
set([hXLabel, hYLabel]  , ...
    'FontSize'   , 10          );
axis('tight');
