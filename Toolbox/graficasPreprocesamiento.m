function graficasPreprocesamiento(MzRem,IntenRem,IntensCB,IntensAlin,MxInten)


fprintf('========================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s   GRAFICAS PREPROCESAMIENTO OvarianCDPostQAQC      %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Funcion que despliega los graficos de todo el      %s\n',20,22)
fprintf('%s preprocesamiento detallado por etapas.             %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('========================================================\n')

% Funcion que despliega los graficos de todo el preprocesamiento  
% detallado por etapas.
% ------------------------------------------------------------------------
% SINTAXIS: function graficas_preprocesamiento(MzRemBen,...
%    IntenRemBen,IntensCBB,IntensAlinB,IntenNormBen,IntenGolayBen)
% PARAMETROS:
%   MzRemC = Vector masas remuestreadas a 10000 puntos 
%   IntenRemC = Matriz intensidades remuestreadas a 10000 puntos
%   IntensCBCan = matriz con linea de base corregida
%   IntensAlinCan = matriz con picos alineados
%   MxIntenCan = matriz de valores normalizados a un valor maximo de 100
% 
%
set(0,'Units','pixels'); warning('off'); 
scnsize = get(0,'ScreenSize');
P = [4050 4650 8050 8450 9300];

fprintf('======================================================\n')
fprintf('%s          MUESTRAS RE-MUESTREADAS A 10000         %s\n',20,22)
fprintf('======================================================\n')

fig1 = figure;
plot(MzRem,mean(IntenRem'),'b-',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0,0,0])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
title('\bfMUESTRAS RE-MUESTREADAS A 10000',...
    'FontName','Arial','FontSize', 10)
xlabel('M/Z','FontName','Arial','FontSize',8)
ylabel('Intensidad','FontName','Arial','FontSize', 8)
set(gca,'YTick',0:max(mean(IntenRem'))/5:max(mean(IntenRem')), ...
    'fontsize', 8);
set(gca,'XTick',0:max(MzRem)/11:max(MzRem),'fontsize', 8);
tick2text(gca, 'yformat', '%.2f');
axis([min(MzRem), max(MzRem), 0, max(mean(IntenRem'))])
grid on

position = get(fig1,'Position');
outerpos = get(fig1,'OuterPosition');
borders = outerpos - position;

edge = -borders(1)/2;
pos1 = [edge,scnsize(4) * (1/2),scnsize(3)/4 - edge/4,scnsize(4)/2];
set(fig1,'OuterPosition',pos1) 

fprintf('======================================================\n')
fprintf('%s          CORRECCION DE LINEA DE BASE             %s\n',20,22)
fprintf('======================================================\n')

fig2 = msbackadj(MzRem,IntenRem,'WindowSize', 200,'QUANTILE',0.2, 'SHOWPLOT',1);
title('\bfCORRECCION DE LINEA DE BASE','FontName','Arial','FontSize', 10)
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
set(gca, 'fontsize', 10) 

pos2 = [scnsize(3)/4 + edge,pos1(2),pos1(3),pos1(4)];
set(gcf,'OuterPosition',pos2)

fprintf('======================================================\n')
fprintf('%s             ALINEACION                           %s\n',20,22)
fprintf('======================================================\n')

fig3 = msheatmap(MzRem,IntensAlin,'markers',P);
title('\bfALINEACION','FontName','Arial','FontSize', 12)
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
pos3 = [scnsize(3)/2 + edge,pos1(2),pos1(3),pos1(4)];
set(gcf,'OuterPosition',pos3)

fprintf('======================================================\n')
fprintf('%s              MUESTRAS PREPROCESADAS                 %s\n',20,22)
fprintf('======================================================\n')

fig4 = figure;
plot(MzRem, mean(MxInten'),'b-',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0,0,0])
set(gca, ...
  'Box'         , 'on'     , ...
  'TickDir'     , 'in'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
title('\bfMUESTRAS PREPROCESADAS','FontName','Arial','FontSize', 10)
xlabel('M/Z)','FontName','Arial','FontSize',8)
ylabel('Intensidad','FontName','Arial','FontSize', 8)
set(gca,'YTick',0:max(mean(MxInten'))/5:max(mean(MxInten')), ...
    'fontsize', 8);
set(gca,'XTick',0:max(MzRem)/11:max(MzRem),'fontsize', 8);
tick2text(gca, 'yformat', '%.2f');
axis([min(MzRem), max(MzRem), 0, max(mean(MxInten'))])
grid on
pos4 = [scnsize(3)-scnsize(3)/4+edge,pos1(2),pos1(3),pos1(4)];
set(gcf,'OuterPosition',pos4)

fprintf('======================================================\n')
fprintf('%s                 REMUESTREO                       %s\n',20,22)
fprintf('======================================================\n')

fig5 = msheatmap(MzRem,IntenRem);
title('\bfREMUESTREO','FontName','Arial','FontSize', 12)
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
set(gca, 'fontsize', 10) 
pos5 = [edge,scnsize(1) * (1/4),scnsize(3)/4 - edge/4,scnsize(4)/2];
set(gcf,'OuterPosition',pos5)

fprintf('======================================================\n')
fprintf('%s              NORMALIZACION                       %s\n',20,22)
fprintf('======================================================\n')

fig6=msheatmap(MzRem,MxInten,'markers',P);
title('\bfNORMALIZACION','FontName','Arial','FontSize', 12)
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
pos6 = [scnsize(3)/4 + edge,pos5(2),pos5(3),pos5(4)];
set(gcf,'OuterPosition',pos6)

fprintf('======================================================\n')
fprintf('%s                   SUAVIZADO                      %s\n',20,22)
fprintf('======================================================\n')

fig7=mssgolay(MzRem,MxInten,'SHOWPLOT',1,'DEGREE',1);
title('\bfSUAVIZADO','FontName','Arial','FontSize', 12)
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
pos7 = [scnsize(3)/2 + edge,pos5(2),pos5(3),pos5(4)];
set(gcf,'OuterPosition',pos7)
axis([8500 8750 0 2])

fprintf('======================================================\n')
fprintf('%s        DESPUES DEL PRE-PROCESAMIENTO             %s\n',20,22)
fprintf('======================================================\n')

fig8=msheatmap(MzRem,MxInten,'markers',P);
title('\bfDESPUES DEL PRE-PROCESAMIENTO')
xlabel('M/Z','FontName','Arial','FontSize', 12)
ylabel('Número De Mediciones','FontName','Arial','FontSize', 12)
pos8 = [scnsize(3)-scnsize(3)/4+edge,pos5(2),pos5(3),pos5(4)];
set(gcf,'OuterPosition',pos8); warning('on');


end