function plotMFCC(features, className)
    figure;
    colormap('jet');
    imagesc(features');
    title(['MFCC Coefficients - ' className]);
    xlabel('Frame');
    ylabel('MFCC Coefficient');
    colorbar;
    axis xy;
end