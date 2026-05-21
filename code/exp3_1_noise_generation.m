function exp3_1_noise_generation(rootDir)
rng(20260521);
img = im2double(imread(fullfile(rootDir, 'materials', 'electric.tif')));
if ndims(img) == 3
    img = rgb2gray(img);
end

gaussianVars = [0.2, 0.5, 0.8];
saltPepperDensity = [0.2, 0.5, 0.8];

fig1 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1200 800]);
tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(img, []); title('Original electric.tif');
for k = 1:numel(gaussianVars)
    noisy = imnoise(img, 'gaussian', 0, gaussianVars(k));
    nexttile; imshow(noisy, []); title(sprintf('Gaussian noise, variance = %.1f', gaussianVars(k)));
end
exportgraphics(fig1, fullfile(rootDir, 'results', 'exp3_1_gaussian_noise.jpg'), 'Resolution', 180);
close(fig1);

fig2 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1200 800]);
tiledlayout(2, 2, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(img, []); title('Original electric.tif');
for k = 1:numel(saltPepperDensity)
    noisy = imnoise(img, 'salt & pepper', saltPepperDensity(k));
    nexttile; imshow(noisy, []); title(sprintf('Salt & pepper noise, density = %.1f', saltPepperDensity(k)));
end
exportgraphics(fig2, fullfile(rootDir, 'results', 'exp3_1_salt_pepper_noise.jpg'), 'Resolution', 180);
close(fig2);
end
