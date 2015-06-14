function [IndicesParticionConjunto,  ...
    DatosEntrenamiento, DatosPrueba,  EtiquetasDatosEntrenamiento, ...
    EtiquetasDatosPrueba ] = DivisionConjuntoTrainAndTest(Mediciones, ...
    AgruparEtiquetas,semilla,porcion)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rng(semilla,'multFibonacci');
IndicesParticionConjunto = cvpartition(AgruparEtiquetas,'holdout',porcion);
DatosEntrenamiento = Mediciones(IndicesParticionConjunto.training,:);
DatosPrueba = Mediciones(IndicesParticionConjunto.test,:);
EtiquetasDatosEntrenamiento = AgruparEtiquetas(IndicesParticionConjunto.training);
EtiquetasDatosPrueba = AgruparEtiquetas(IndicesParticionConjunto.test);
end

