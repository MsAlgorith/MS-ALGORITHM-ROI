function [ p, h ] = PruebaWilcoxon(DatosGrupo1,DatosGrupo2)

for i=1:length(DatosGrupo1(1,:))
    [p(i),h(i)] = ranksum(DatosGrupo1(:,i), ...
        DatosGrupo2(:,i));
end


end

