function [IntensAlin] = alineacion(VectorMasasRemuestreadas,MatrizIntesidadesCorregidas,P)

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

fprintf('========================================================\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s                 ALINEACION DE PICOS                %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%sFunción que alinea los picos en los datos de señales%s\n',20,22) 
fprintf('%sruidosas Consiste en desplazar los valores de m/z de%s\n',20,22)
fprintf('%smismo valor de m/z msalign funciona mejor con 3 a 5 %s\n',20,22)
fprintf('%spicos de referencia que aparecerán en la señal.     %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('========================================================\n')

%
%SINTAXIS: function [IntenNorm ] = Normalizacion( MzRem,IntensAlineadas )
%PARAMETROS:
%   MzRem = Masas remuestreadas a 10000 puntos
%   IntensCB = matriz con linea de base corregida
%   IntensAlin=matriz de datos con picos alineados
    
fprintf('SE ESTA ALINEANDO CON VALORES REFERENCIALES \n');
for i=1:length(P)
    fprintf('P(%d) = %d\n',i,P(i))
end
%EJEMPLO:
% load sample_lo_res
% R = [3991.4 4598 7964 9160];
% W = [60 100 60 100];
% msheatmap(MZ_lo_res,Y_lo_res,'markers',R,'range',[3000 10000])
% title('before alignment')
%
% YA = msalign(MZ_lo_res,Y_lo_res,R,'weights',W);
% msheatmap(MZ_lo_res,YA,'markers',R,'range',[3000 10000])
% title('after alignment')

% P = [4050 4650 8050 8450 9300];

IntensAlin = msalign(VectorMasasRemuestreadas',MatrizIntesidadesCorregidas',P);

IntensAlin = IntensAlin';
end