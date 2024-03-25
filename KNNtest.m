clc;
clear all;
close all;
load ("KNN.mat"); % Load the KNN Model File

% Example: Extract features from a new audio file
newFilePath = "H:\L3T1\EEE312\Project\LungDiseaseFinal\bronchitisFolder\BP28_BRON,Crep,P L U,68,F_middle10sec.wav"; % Replace with the path to your new audio file
[newAudio, fs] = audioread(newFilePath);
targetFs = 44100;
newAudio = resample(newAudio, targetFs, fs);
fs = targetFs;

% Extract MFCC features (using the same parameters as during training)
newFeatures = mfcc(newAudio, fs, "LogEnergy", "ignore");
newFeatures(:, 1) = []; % Remove the first coefficient (energy) if applicable

% Normalize the features using the same normalization parameters
newNormalizedFeatures = normalizeFeatures(newFeatures);
plotMFCC(newFeatures, 'Test Sample');

% Make predictions using the trained KNN model
predictedLabel = predict(knnModel, newNormalizedFeatures);

[prediction, occurrences] = maxoccurrences(predictedLabel);

% Interpret the predicted label
if prediction == 1 
    disp('The patient is healthy.');
elseif prediction == 2 
    disp('The patient has asthma.');
elseif prediction == 3 
    disp('The patient has heart failure.');
elseif prediction == 4 
    disp('The patient has COPD.');
elseif prediction == 5 
    disp('The patient has Bronchitis.');
else
    disp('Invalid predicted label.');
end
