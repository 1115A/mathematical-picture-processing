function exp3_3_sharpening(rootDir)
img = im2double(imread(fullfile(rootDir, 'materials', 'building.tif')));
if ndims(img) == 3
    img = rgb2gray(img);
end

laplacianKernel = fspecial('laplacian', 0.2);
laplacianResponse = filter2(laplacianKernel, img, 'same');
sharpened = mat2gray(img - laplacianResponse);

meanKernel = fspecial('average', [5 5]);
smoothed = mat2gray(filter2(meanKernel, img, 'same'));

fig = figure('Visible', 'off', 'Color', 'w', 'Position', [100 100 1300 500]);
tiledlayout(1, 3, 'Padding', 'compact', 'TileSpacing', 'compact');
nexttile; imshow(img, []); title('Original building.tif');
nexttile; imshow(sharpened, []); title('Laplacian sharpening');
nexttile; imshow(smoothed, []); title('Mean filtering');
exportgraphics(fig, fullfile(rootDir, 'results', 'exp3_3_sharpening_and_mean.png'), 'Resolution', 180);
close(fig);
end
