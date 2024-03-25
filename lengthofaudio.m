clc;
clear all;
close all;
normalFolder = "E:\Project MATLAB\LUNG DISEASE\normalFolder";
asthmaFolder ="E:\Project MATLAB\LUNG DISEASE\asthmaFolder" ;
heartfailureFolder = "E:\Project MATLAB\LUNG DISEASE\heartfailureFolder";

normallength = [];
asthmalength = [];
heartfailurelength = [];

normalFiles = dir(fullfile(normalFolder, '*.wav'));
for i = 1:length(normalFiles)
    filePath = fullfile(normalFolder, normalFiles(i).name);
    [y, Fs] = audioread(filePath);
    siz = audioread(filePath,'size');
    normallength = [siz(1)/Fs];
end
normallength