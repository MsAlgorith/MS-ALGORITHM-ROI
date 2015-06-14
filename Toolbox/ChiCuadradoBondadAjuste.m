function [ p, h ] = ChiCuadradoBondadAjuste( DatosGrupo1,DatosGrupo2 )

%chi2 prueba inicio ---
aux = vertcat(DatosGrupo1,DatosGrupo2); % datosPrueba;%DatosEntrenamiento([1:140],[1:10000]);

for i=1:length(aux(1,:));
    warning('off','all');
    [h(i),p(i)] = chi2gof(aux(:,i),'NParams',5);
    warning('on','all');
  
end

% max(p_chi2)
% ecdf(p_chi2)% el 95%de los datos son utilizables, en teoria no esta mal.
%la prueba no es sensible para este conjunto



end

