function extractMiddle10Seconds(inputFolder, outputFolder)
    % Read all audio files from the input folder
    audioFiles = dir(fullfile(inputFolder, '*.wav'));

    % Create the output folder if it doesn't exist
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    % Duration of the middle segment to extract (in seconds)
    middleDuration = 10;

    % Loop through each audio file
    for i = 1:length(audioFiles)
        filePath = fullfile(inputFolder, audioFiles(i).name);

        % Read the audio file
        [audio, Fs] = audioread(filePath);

        % Check if the duration is greater than 10 seconds
        if length(audio) / Fs > middleDuration
            % Calculate the start and end indices for the middle 10 seconds
            startIdx = floor((length(audio) - middleDuration * Fs) / 2) + 1;
            endIdx = startIdx + middleDuration * Fs - 1;

            % Extract the middle 10 seconds
            middleSegment = audio(startIdx:endIdx, :);

            % Save the truncated audio to the output folder
            [~, fileName, ext] = fileparts(audioFiles(i).name);
            outputFilePath = fullfile(outputFolder, [fileName, '_middle10sec', ext]);
            audiowrite(outputFilePath, middleSegment, Fs);

            disp(['Saved middle 10 seconds of ', audioFiles(i).name, ' to ', outputFilePath]);
        else
            disp(['Skipping ', audioFiles(i).name, ' (duration less than 10 seconds)']);
        end
    end

    disp('Extraction complete.');
end
