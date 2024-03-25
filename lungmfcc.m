clear all,;
close all;
clc;
normalFolder = "H:\L3T1\EEE312\Project\LungDiseaseFinal\normalFolder";
asthmaFolder ="H:\L3T1\EEE312\Project\LungDiseaseFinal\asthmaFolder" ;
heartfailureFolder = "H:\L3T1\EEE312\Project\LungDiseaseFinal\heartfailureFolder";
copdFolder = "H:\L3T1\EEE312\Project\LungDiseaseFinal\copdFolder";
bronFolder = "H:\L3T1\EEE312\Project\LungDiseaseFinal\bronchitisFolder";

normalFeatures = [];
asthmaFeatures = [];
heartfailureFeatures = [];
copdFeatures = [];
bronFeatures = [];

normalFiles = dir(fullfile(normalFolder, '*.wav'));
for i = 1:length(normalFiles)
    filePath = fullfile(normalFolder, normalFiles(i).name);
    [audioIn, fs] = audioread(filePath);
    targetFs = 44100;
    audioIn = resample(audioIn, targetFs, fs);
    fs = targetFs;
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    normalFeatures = [normalFeatures; coff];
end
asthmaFiles = dir(fullfile(asthmaFolder, '*.wav'));
for i = 1:length(asthmaFiles)
    filePath = fullfile(asthmaFolder, asthmaFiles(i).name);
    [audioIn, fs] = audioread(filePath);
    targetFs = 44100;
    audioIn = resample(audioIn, targetFs, fs);
    fs = targetFs;
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    asthmaFeatures = [asthmaFeatures; coff];
end
heartfailureFiles = dir(fullfile(heartfailureFolder, '*.wav'));
for i = 1:length(heartfailureFiles)
    filePath = fullfile(heartfailureFolder, heartfailureFiles(i).name);
    [audioIn, fs] = audioread(filePath);
    targetFs = 44100;
    audioIn = resample(audioIn, targetFs, fs);
    fs = targetFs;
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    heartfailureFeatures = [heartfailureFeatures; coff];
end
copdFiles = dir(fullfile(copdFolder, '*.wav'));
for i = 1:length(copdFiles)
    filePath = fullfile(copdFolder, copdFiles(i).name);
    [audioIn, fs] = audioread(filePath);
    targetFs = 44100;
    audioIn = resample(audioIn, targetFs, fs);
    fs = targetFs;
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    copdFeatures = [copdFeatures; coff];
end
bronFiles = dir(fullfile(bronFolder, '*.wav'));
for i = 1:length(bronFiles)
    filePath = fullfile(bronFolder, bronFiles(i).name);
    [audioIn, fs] = audioread(filePath);
    targetFs = 44100;
    audioIn = resample(audioIn, targetFs, fs);
    fs = targetFs;
    coff=mfcc( audioIn, fs, "LogEnergy","ignore");
    coff( : , 1)=[];
    bronFeatures = [bronFeatures; coff];
end
% Normalize features
normalFeatures = normalizeFeatures(normalFeatures);
asthmaFeatures = normalizeFeatures(asthmaFeatures);
heartfailureFeatures = normalizeFeatures(heartfailureFeatures);
copdFeatures = normalizeFeatures(copdFeatures);
bronFeatures = normalizeFeatures(bronFeatures);

% Plot MFCC coefficients for different classes
plotMFCC(normalFeatures, 'Normal Class');
plotMFCC(asthmaFeatures, 'Asthma Class');
plotMFCC(heartfailureFeatures, 'Heart Failure Class');
plotMFCC(copdFeatures, 'copd Class');
plotMFCC(bronFeatures, 'bron Class');
