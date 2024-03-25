function normalizedFeatures = normalizeFeatures(features)
    % Normalize the features to [0, 1] range
    minVals = min(features);
    maxVals = max(features);
    
    % Handle the case where min and max are equal (preventing division by zero)
    maxVals(maxVals == minVals) = minVals(maxVals == minVals) + 1;

    normalizedFeatures = (features - minVals) ./ (maxVals - minVals);
end
