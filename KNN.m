clc;
clear all;
close all;
load("lungmfcc.mat"); %to load features into workspace
% Combine features and labels
normalLabels = ones(size(normalFeatures, 1), 1);  % Assign label 1 to 'normal'
asthmaLabels = 2 * ones(size(asthmaFeatures, 1), 1);  % Assign label 2 to 'asthma'
heartfailureLabels = 3 * ones(size(heartfailureFeatures, 1), 1);  % Assign label 3 to 'heartfailure'
copdLabels = 4 * ones(size(copdFeatures, 1), 1);  % Assign label 4 to 'copd'
bronLabels = 5 * ones(size(bronFeatures, 1), 1);  % Assign label 4 to 'copd'

data = [normalFeatures; asthmaFeatures; heartfailureFeatures; copdFeatures; bronFeatures];
labels = [normalLabels; asthmaLabels; heartfailureLabels; copdLabels; bronLabels];

rng(1);  % Set random seed for reproducibility
shuffledIndices = randperm(length(labels));
shuffledData = data(shuffledIndices, :);
shuffledLabels = labels(shuffledIndices);

% Split the data (e.g., 80% training, 20% testing)
splitRatio = 0.8;
splitIndex = round(splitRatio * length(labels));

trainData = shuffledData(1:splitIndex, :);
trainLabels = shuffledLabels(1:splitIndex);

testData = shuffledData(splitIndex+1:end, :);
testLabels = shuffledLabels(splitIndex+1:end);

knnModel = fitcknn(trainData, trainLabels, 'NumNeighbors', 10);

predictedLabels = predict(knnModel, testData);

% Evaluate accuracy
accuracy = sum(predictedLabels == testLabels) / numel(testLabels);
disp(['Accuracy: ', num2str(accuracy)]);

% Confusion matrix
confMat = confusionmat(testLabels, predictedLabels);
disp('Confusion Matrix:');
disp(confMat);

