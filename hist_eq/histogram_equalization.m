% MATLAB GUI Application for Histogram Equalization 
% by Jjateen Gundesha
% Roll Number: BT22ECI002
% Description: This application allows the user to browse and select an image, 
%              and display its histogram and equalized histogram.

clc;
clear all;
close all;

% Create GUI
fig = figure('Name', 'Histogram Equalization', 'NumberTitle', 'off', ...
             'Position', [100, 100, 1000, 800]); 

% Add button to browse image
browse_button = uicontrol('Style', 'pushbutton', 'String', 'Browse Image', ...
                          'Position', [450, 20, 100, 40], 'Callback', @browse_image);

% Axes for displaying images and histograms
handles.ax1 = axes('Parent', fig, 'Position', [0.1, 0.6, 0.35, 0.35]);
handles.ax2 = axes('Parent', fig, 'Position', [0.55, 0.6, 0.35, 0.35]);
handles.ax3 = axes('Parent', fig, 'Position', [0.1, 0.2, 0.35, 0.35]);
handles.ax4 = axes('Parent', fig, 'Position', [0.55, 0.2, 0.35, 0.35]);

guidata(fig, handles);

% Browse and process image
function browse_image(~, ~)
    handles = guidata(gcbo);
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'});
    if isequal(file, 0)
        return;
    end
    img = imread(fullfile(path, file));
    gray_img = rgb2gray(img);
    [m, n] = size(gray_img);

    % Compute counts
    img_array = double(gray_img(:));
    counts_original = histcounts(img_array, 0:256);

    % Histogram Equalization
    cdf = cumsum(counts_original);
    cdf_min = min(cdf(cdf > 0));
    L = 256;
    h_v = round(((cdf - cdf_min) / ((m * n) - cdf_min)) * (L));
    disp("max(cdf) = "+ max(cdf));

    equalized_img = h_v(gray_img + 1);
    counts_equalized = histcounts(equalized_img(:), 0:256); % Equalized histogram

    % Plot original and equalized images
    axes(handles.ax1);
    imshow(gray_img);
    title('Original Image');

    axes(handles.ax2);
    imshow(uint8(equalized_img));
    title('Equalized Image');

    % Plot original histogram
    axes(handles.ax3);
    bar(0:255, counts_original, 'FaceColor', 'blue', 'EdgeColor', 'none');
    title('Original Histogram');
    ylabel('Count');
    xlabel('Pixel Intensity');
    xlim([0, 255]);

    % Plot equalized histogram
    axes(handles.ax4);
    bar(0:255, counts_equalized, 'FaceColor', 'red', 'EdgeColor', 'none');
    title('Equalized Histogram');
    ylabel('Count');
    xlabel('Pixel Intensity');
    xlim([0, 255]);
end