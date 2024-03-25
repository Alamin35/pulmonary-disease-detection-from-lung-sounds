clc;
close all;
clear;

%% Extract

normalFolder = "E:\Project MATLAB\LUNG DISEASE\normalFolder";
asthmaFolder ="E:\Project MATLAB\LUNG DISEASE\asthmaFolder" ;
heartfailureFolder = "E:\Project MATLAB\LUNG DISEASE\heartfailureFolder";


% Define function to calculate features
calculateFeatures = @(audio) [std(audio), rms(audio), max(audio)-min(audio), -sum(abs(audio).^2 .* log(abs(audio+0.00000000001).^2))];

% Initialize feature matrices
normalFeatures = [];
asthmaFeatures = [];
%bronchitisFeatures = [];
heartfailureFeatures = [];

% Process normal folder
normalFiles = dir(fullfile(normalFolder, '*.wav'));
for i = 1:length(normalFiles)
    filePath = fullfile(normalFolder, normalFiles(i).name);
    [y, ~] = audioread(filePath);
    features = calculateFeatures(y);
    normalFeatures = [normalFeatures; features];
end

% Process asthma folder
asthmaFiles = dir(fullfile(asthmaFolder, '*.wav'));
for i = 1:length(asthmaFiles)
    filePath = fullfile(asthmaFolder, asthmaFiles(i).name);
    [y, ~] = audioread(filePath);
    features = calculateFeatures(y);
    asthmaFeatures = [asthmaFeatures; features];
end

heartfailureFiles = dir(fullfile(heartfailureFolder, '*.wav'));
for i = 1:length(heartfailureFiles)
    filePath = fullfile(heartfailureFolder, heartfailureFiles(i).name);
    [y, ~] = audioread(filePath);
    features = calculateFeatures(y);
    heartfailureFeatures = [heartfailureFeatures; features];
end

% Calculate average features for each class
avgNormalFeatures = mean(normalFeatures, 1);
avgAsthmaFeatures = mean(asthmaFeatures, 1);
avgheartfailureFeatures = mean(heartfailureFeatures, 1);

% Display average features
disp('Average Features for Normal Class:');
disp(avgNormalFeatures);

disp('Average Features for Asthma Class:');
disp(avgAsthmaFeatures);

disp('Average Features for Heart Failure Class:');
disp(avgheartfailureFeatures);

%% Determine

% Load the audio file
filename = "E:\Project MATLAB\LUNG DISEASE\Audio Files Test\BP19_heart failure,C,P R U,70,F - Copy_middle10sec.wav";
[y, Fs] = audioread(filename);

% Calculate the peak-to-peak value
peak_to_peak = max(y) - min(y);

% Calculate the RMS (Root Mean Square)
rms_value = rms(y);

% Calculate the standard deviation
std_deviation = std(y);

% Calculate the Shannon energy
shannon_energy =-sum(abs(y).^2 .* log(abs(y+0.001).^2));

%Create a vector with the extracted features
audio_features = [peak_to_peak, rms_value, std_deviation, shannon_energy];

% Display the results
fprintf('Peak-to-Peak Value: %.4f\n', peak_to_peak);
fprintf('RMS Value: %.4f\n', rms_value);
fprintf('Standard Deviation: %.4f\n', std_deviation);
fprintf('Shannon Energy: %.4f\n', shannon_energy);

% Plot the audio signal
t = (0:length(y)-1) / Fs;
figure;
subplot(211);
plot(t, y);
title('Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(212);
histogram(y, 100);
title('Amplitude Histogram');
xlabel('Amplitude');
ylabel('Frequency');

% Wait for user input before closing the plots
% An amplitude histogram, also known as a signal histogram or amplitude distribution, is a graphical representation of the distribution of signal amplitudes in a dataset. In the context of audio signals or any other type of signal, the histogram provides insights into the distribution of signal strengths or magnitudes.
%
% In an amplitude histogram:
%
% The x-axis represents the range of signal amplitudes.
% The y-axis represents the frequency or count of occurrences of each amplitude value.
% Each bar in the histogram indicates how many samples or data points have an amplitude within a certain range. The histogram helps visualize the spread of amplitude values, providing information about the intensity or energy distribution within the signal.
%
% Amplitude histograms are used for various purposes:
%
% Signal Analysis: By examining the histogram, you can identify the presence of noise, distortion, or other irregularities in the signal. Unusual patterns in the histogram might indicate problems or characteristics of the signal that need attention.
%
% Characterization: Histograms help in understanding the overall characteristics of a signal. For example, in audio signals, a symmetrical histogram might indicate a balanced mix of positive and negative amplitudes, while an asymmetric one might imply a DC offset or bias.
%
% Dynamic Range Analysis: Histograms provide insights into the dynamic range of a signal, which is the range between the highest and lowest amplitudes. This is crucial in understanding how well a signal can capture subtle details as well as handle loud sounds.
%
% Normalization and Processing: Histograms can be used to normalize or adjust signal amplitudes to ensure they fall within a desired range, which is especially useful in audio processing.
%
% Comparisons: Comparing histograms before and after signal processing can show how the processing has affected the amplitude distribution, helping you analyze the impact of various modifications.
%
% Anomaly Detection: Sudden spikes or gaps in the histogram might indicate anomalies or unexpected events in the signal. This can be particularly useful for identifying glitches or errors.

%% Compare

% Calculate Euclidean distances between audio features and each class
dist_normal = norm(audio_features - normalFeatures)/length(normalFiles);
dist_asthma = norm(audio_features - asthmaFeatures)/length(asthmaFiles);
dist_heartfailure = norm(audio_features - heartfailureFeatures)/length(heartfailureFiles);


%% Calculate the probabililty of the audio file belonging to each class
%% Assuming higher similarity corresponding to higher probabilty
total_similarity = dist_normal + dist_asthma + dist_heartfailure;
probabilty = zeros(1,3);
probabilty(1) = 1 - (dist_normal/total_similarity);
probabilty(2) = 1 - (dist_asthma/total_similarity);
probabilty(3) = 1 - (dist_heartfailure/total_similarity);

%% Display the probabilities for each class
disp('Probabilities: ');
disp(['Normal: ',num2str(probabilty(1))]);
disp(['Asthma: ',num2str(probabilty(2))]);
disp(['Heart Failure: ', num2str(probabilty(3))]);

%% Display the predicted class
if (max(probabilty) < 0.6)
    disp('The sample is : Unknown');
    return
else
    [M,I] = max(probabilty);
    disp('The sample is: ');
    if I==1
        disp('Normal')
    elseif I==2
        disp('Asthma')
    elseif I==3
        disp('Heart Failure')
    end
end