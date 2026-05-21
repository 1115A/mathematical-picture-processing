function exp3_2_spatial_denoising(rootDir)
rng(20260521);
img = im2double(imread(fullfile(rootDir, 'materials', 'electric.tif')));
if ndims(img) == 3
    img = rgb2gray(img);
end

densityList = [0.2, 0.5, 0.8];
fig1 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1300 850]);
tiledlayout(2, 3, 'Padding', 'compact', 'TileSpacing', 'compact');
for k = 1:numel(densityList)
    noisy = imnoise(img, 'salt & pepper', densityList(k));
    filtered = medfilt2(noisy, [3 3]);
    nexttile; imshow(noisy, []); title(sprintf('Noisy, density = %.1f', densityList(k)));
    nexttile(k + 3); imshow(filtered, []); title('3x3 median filtering');
end
exportgraphics(fig1, fullfile(rootDir, 'results', 'exp3_2_median_same_template.jpg'), 'Resolution', 180);
close(fig1);

noisy05 = imnoise(img, 'salt & pepper', 0.5);
templateList = [3, 5, 9];
fig2 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1200 800]);
tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(noisy05, []); title('Salt & pepper noise, density = 0.5');
for k = 1:numel(templateList)
    filtered = medfilt2(noisy05, [templateList(k), templateList(k)]);
    nexttile; imshow(filtered, []); title(sprintf('%dx%d median filtering', templateList(k), templateList(k)));
end
exportgraphics(fig2, fullfile(rootDir, 'results', 'exp3_2_median_different_templates.jpg'), 'Resolution', 180);
close(fig2);

gaussianNoisy = imnoise(img, 'gaussian', 0, 0.2);
saltPepperNoisy = imnoise(img, 'salt & pepper', 0.2);
meanKernel = ones(3, 3) / 9;
gaussianMean = imfilter(gaussianNoisy, meanKernel, 'replicate');
gaussianMedian = medfilt2(gaussianNoisy, [3 3]);
spMean = imfilter(saltPepperNoisy, meanKernel, 'replicate');
spMedian = medfilt2(saltPepperNoisy, [3 3]);

fig3 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1300 850]);
tiledlayout(2, 3, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(gaussianNoisy, []); title('Gaussian noise');
nexttile; imshow(gaussianMean, []); title('3x3 mean filtering');
nexttile; imshow(gaussianMedian, []); title('3x3 median filtering');
nexttile; imshow(saltPepperNoisy, []); title('Salt & pepper noise');
nexttile; imshow(spMean, []); title('3x3 mean filtering');
nexttile; imshow(spMedian, []); title('3x3 median filtering');
exportgraphics(fig3, fullfile(rootDir, 'results', 'exp3_2_mean_vs_median.jpg'), 'Resolution', 180);
close(fig3);
end
