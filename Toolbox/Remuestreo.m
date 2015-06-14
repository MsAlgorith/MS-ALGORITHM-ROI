function [ VectorMasasRemuestreada,MatrizIntensidadRemuestreada ] = Remuestreo( Datos,n,flag,frecuencia)

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


fprintf('+++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')
fprintf('%s                                                    %s\n',20,22)
fprintf('%s                    REMUESTREO                      %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)
fprintf('%s Proceso de remuestreo para homogeneizar el vector  %s\n',20,22)
fprintf('%s masa/ carga (M/Z).                                 %s\n',20,22)
fprintf('%s Eliminación de valores negativos                   %s\n',20,22)
fprintf('%s Eliminación de frecuencias bajas(ruido) y          %s\n',20,22)
fprintf('%s frecuencias altas.                                 %s\n',20,22)
fprintf('%s                                                    %s\n',20,22)     
fprintf('++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n')

% Proceso de remuestreo para homogeneizar el vector m/z
% Eliminación de valores negativos
% Eliminación de frecuencias bajas(ruido)y frecuencias altas
% --------------------------------
%SINTAXIS: functión [MasasRem,MatrizIntensidadRemuestreada] = Remuestreo(datos, n)
%PARAMÉTROS:
%   datos = cell array cada uno con dos vectores columna: mz e intensidad
%   n = vector que contiene numero de archivos.csv
%   VectorMasasRemuestreada =Vector de Masas remuestreadas a 10000 puntos
%   MatrizIntensidadRemuestreada = Intensidades remuestreadas a 10000 puntos
%EJEMPLO
% load sample_hi_res;
% mz = MZ_hi_res;
% y = Y_hi_res;
% plot(mz, y, '.')
%[mz1,y1]=msresample(mz, y, 10000, 'range',[2000 max(mz)],'SHOWPLOT',true);
%
R = [2000 11000]; % rango valido

if flag == 1 % remuestreo archivos.txt
    
for i=1:n
    %vectoresIntesidades
    vectInx = find((Datos{1,i}(:,2))>0);
    %punteroVector
    auxVect = Datos{1,i}(:,2);
    % guardo auxvector en datosN.data ya como matriz
    datosN{1,i}.data(:,2) = auxVect(vectInx,:);
    %Limpio punteroVector
    clear auxVect;
    %punteroVector
    auxVect = Datos{1,i}(:,1);
    % guardo auxVector en estructura datosN.data, como matriz 
    datosN{1,i}.data(:,1) = auxVect(vectInx,:);
    [VectorMasasRemuestreada(i,:),MatrizIntensidadRemuestreada(i,:)] = ...
        msresample(datosN{1,i}.data(:,1),...
        datosN{1,i}.data(:,2),frecuencia,'RANGE',R);
close 
  if i == n
      fprintf([blanks(1) '%d\n' blanks(1) '\n'],i)
  else
      if (( 12 * round(double(i)/12) == i ))
        fprintf([blanks(1) '%d' blanks(1) '\n'],i)
      else
        fprintf([blanks(1) '%d' blanks(1)],i)
      end
  end
   
end
VectorMasasRemuestreada = mean(VectorMasasRemuestreada);

elseif flag == 2 % remuestreo archivos .csv
    
    for i=1:n
    vectInx = find((Datos{1,i}.data(:,2))>0);
    auxVect = Datos{1,i}.data(:,2);
    datosN{1,i}.data(:,2) = auxVect(vectInx,:);
    clear auxVect;
    auxVect = Datos{1,i}.data(:,1);
    datosN{1,i}.data(:,1) = auxVect(vectInx,:);
    [VectorMasasRemuestreada(i,:),MatrizIntensidadRemuestreada(i,:)] = msresample(datosN{1,i}.data(:,1),...
        datosN{1,i}.data(:,2),10000,'RANGE',R);
    
    close 
    if i == n
      fprintf([blanks(1) '%d\n' blanks(1) '\n'],i)
    else
        if (( 12 * round(double(i)/12) == i ))
            fprintf([blanks(1) '%d' blanks(1) '\n'],i)
        else
            fprintf([blanks(1) '%d' blanks(1)],i)
        end
    end
    end
    VectorMasasRemuestreada = mean(VectorMasasRemuestreada);
end