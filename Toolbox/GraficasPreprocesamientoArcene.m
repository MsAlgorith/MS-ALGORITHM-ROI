function [] =GraficasPreprocesamientoArcene(DatosGrupo1,DatosGrupo2)

fprintf('========================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s     GRAFICAS PREPROCESAMIENTO ARCENE               %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Funcion que despliega los graficos de todo el      %s\n',20,22)
fprintf('%s preprocesamiento detallado por etapas.             %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('======================================================\n')

% Funcion que despliega los graficos de todo el preprocesamiento  
% detallado por etapas.
% --------------------------------
%SINTAXIS: function graficas_preprocesamiento(MzRemBen,...
%    IntenRemBen,IntensCBB,IntensAlinB,IntenNormBen,IntenGolayBen)
%PARAMETROS:
%   MzRemC = Vector masas remuestreadas a 10000 puntos 
%   IntenRemC = Matriz intensidades remuestreadas a 10000 puntos
%   IntensCBCan = matriz con linea de base corregida
%   IntensAlinCan = matriz con picos alineados
%   MxIntenCan = matriz de valores normalizados a un valor maximo de 100
% 
set(0,'Units','pixels'); 
scnsize = get(0,'ScreenSize');
vectormasas = 1:10000;
MapaCalorArcene = msheatmap((vectormasas)',vertcat(DatosGrupo1,DatosGrupo2)');
title('\bfImpresion de Datos del Grupo Arcene', 'FontName','Courier',...
    'FontSize', 10) 

position = get(MapaCalorArcene,'Position');
outerpos = get(MapaCalorArcene,'OuterPosition');
borders = outerpos - position;

edge = -borders(1)/2;
Posicion1 = [edge,...
        scnsize(4) * (1/2),...
        scnsize(3) - edge,...
        scnsize(4)/2];
set(gcf,'OuterPosition',Posicion1)

CargarDatosGrupo1Grupo2 = figure;
subplot(2,1,1)
plot((1:10000),(mean(DatosGrupo1)))
xlabel(' MASA / CARGA (M/Z)','FontSize', 10, 'FontName', 'Times')
ylabel('Intensidad', 'FontSize', 10)
title('\bfCargar Datos Grupo 1', 'FontName','Courier', 'FontSize', 10) 

subplot(2,1,2)
plot((1:10000),(mean(DatosGrupo2)))
xlabel(' MASA / CARGA (M/Z)','FontSize', 10, 'FontName', 'Times')
ylabel('Intensidad', 'FontSize', 10)
title('\bfCargar Datos Grupo 2', 'FontName','Courier', 'FontSize', 10)

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
Posicion2 = [scnsize(1),...
        scnsize(1),...
        scnsize(3),...
        scnsize(4)/2];
set(gcf,'OuterPosition',Posicion2)

end