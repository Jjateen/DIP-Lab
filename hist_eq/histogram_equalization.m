clc;
clear all;
close all;

% Create GUI with increased window size
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

    img_array = double(gray_img(:));
    [unique_vals, ~, idx] = unique(img_array);
    counts = accumarray(idx, 1);

    cdf = cumsum(counts);
    cdf_min = min(cdf);
    L = 255;
    h_v = round(((cdf - cdf_min) / ((m * n) - cdf_min)) * (L - 1));

    equalized_img = h_v(idx);
    equalized_img = reshape(equalized_img, [m, n]);

    % Plot images and histograms
    axes(handles.ax1);
    imshow(gray_img);
    title('Original Image');

    axes(handles.ax2);
    imshow(uint8(equalized_img));
    title('Equalized Image');

    axes(handles.ax3);
    histogram(gray_img(:), 256, 'EdgeColor', 'none', 'FaceColor', 'blue', 'Normalization', 'probability');
    title('Original Histogram');

    axes(handles.ax4);
    histogram(equalized_img(:), 256, 'EdgeColor', 'none', 'FaceColor', 'red', 'Normalization', 'probability');
    title('Equalized Histogram');
end