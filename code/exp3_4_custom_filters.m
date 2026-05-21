function exp3_4_custom_filters(rootDir)
rng(20260521);
img = im2double(imread(fullfile(rootDir, 'materials', 'electric.tif')));
if ndims(img) == 3
    img = rgb2gray(img);
end

gaussianNoisy = imnoise(img, 'gaussian', 0, 0.2);
saltPepperNoisy = imnoise(img, 'salt & pepper', 0.2);
templateSizes = [3, 5, 9];

fig1 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1400 900]);
tiledlayout(2, 4, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(gaussianNoisy, []); title('Gaussian noise');
for k = 1:numel(templateSizes)
    n = templateSizes(k);
    filtered = local_mean_filter(gaussianNoisy, n);
    nexttile; imshow(filtered, []); title(sprintf('%dx%d custom mean', n, n));
end
nexttile; imshow(saltPepperNoisy, []); title('Salt & pepper noise');
for k = 1:numel(templateSizes)
    n = templateSizes(k);
    filtered = local_mean_filter(saltPepperNoisy, n);
    nexttile; imshow(filtered, []); title(sprintf('%dx%d custom mean', n, n));
end
exportgraphics(fig1, fullfile(rootDir, 'results', 'exp3_4_custom_mean_filter.png'), 'Resolution', 180);
close(fig1);

fig2 = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1400 900]);
tiledlayout(2, 4, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(gaussianNoisy, []); title('Gaussian noise');
for k = 1:numel(templateSizes)
    n = templateSizes(k);
    filtered = local_median_filter(gaussianNoisy, n);
    nexttile; imshow(filtered, []); title(sprintf('%dx%d custom median', n, n));
end
nexttile; imshow(saltPepperNoisy, []); title('Salt & pepper noise');
for k = 1:numel(templateSizes)
    n = templateSizes(k);
    filtered = local_median_filter(saltPepperNoisy, n);
    nexttile; imshow(filtered, []); title(sprintf('%dx%d custom median', n, n));
end
exportgraphics(fig2, fullfile(rootDir, 'results', 'exp3_4_custom_median_filter.png'), 'Resolution', 180);
close(fig2);
end

function out = local_mean_filter(img, n)
pad = floor(n / 2);
padded = padarray(img, [pad pad], 'replicate', 'both');
out = zeros(size(img));
for r = 1:size(img, 1)
    for c = 1:size(img, 2)
        block = padded(r:r+n-1, c:c+n-1);
        out(r, c) = sum(block(:)) / (n * n);
    end
end
end

function out = local_median_filter(img, n)
pad = floor(n / 2);
padded = padarray(img, [pad pad], 'replicate', 'both');
out = zeros(size(img));
for r = 1:size(img, 1)
    for c = 1:size(img, 2)
        block = padded(r:r+n-1, c:c+n-1);
        out(r, c) = median(block(:));
    end
end
end
