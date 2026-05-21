clear; close all; clc;

rootDir = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(rootDir, 'code'));
if ~exist(fullfile(rootDir, 'results'), 'dir')
    mkdir(fullfile(rootDir, 'results'));
end

exp3_1_noise_generation(rootDir);
exp3_2_spatial_denoising(rootDir);
exp3_3_sharpening(rootDir);
exp3_4_custom_filters(rootDir);

disp('Experiment 3 completed. Results are saved in the results folder.');
