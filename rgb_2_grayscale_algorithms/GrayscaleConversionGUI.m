% MATLAB GUI Application for Grayscale Conversion
% Modernized by Jjateen Gundesha
% Roll Number: BT22ECI002
% Description: This application allows the user to browse and select an image, 
%              apply a grayscale conversion algorithm chosen from a dropdown menu, 
%              and display the output image with its formula.

clc;
clear all;
close all;

% Create the GUI figure
hFig = figure('Name', 'Grayscale Converter', 'NumberTitle', 'off', ...
              'Position', [100, 100, 1200, 600], 'Color', [0.9 0.9 0.9]);

% Axes for displaying the original image
hOriginalAxes = axes('Parent', hFig, 'Position', [0.05, 0.3, 0.4, 0.6]);
title(hOriginalAxes, 'Original Image', 'FontSize', 12, 'FontWeight', 'bold');
xlabel(hOriginalAxes, 'Displayed: Original Image');

% Axes for displaying the output grayscale image
hOutputAxes = axes('Parent', hFig, 'Position', [0.55, 0.3, 0.4, 0.6]);
title(hOutputAxes, 'Grayscale Image', 'FontSize', 12, 'FontWeight', 'bold');
xlabel(hOutputAxes, 'Displayed: Grayscale Image and Formula');

% Dropdown menu for selecting the grayscale algorithm
uicontrol('Style', 'text', 'String', 'Select Grayscale Algorithm:', ...
          'Position', [500, 120, 200, 20], 'FontSize', 10, ...
          'HorizontalAlignment', 'left', 'BackgroundColor', [0.9 0.9 0.9]);
hDropdown = uicontrol('Style', 'popupmenu', ...
                      'String', {'Average Method', 'Weighted Average Method', ...
                                 'Luminosity Method', 'Desaturation Method'}, ...
                      'Position', [500, 90, 200, 25], 'FontSize', 10);

% Button to browse and load the image
uicontrol('Style', 'pushbutton', 'String', 'Browse Image', ...
          'Position', [500, 40, 150, 40], 'FontSize', 10, ...
          'Callback', @(~, ~) browseAndConvertImage(hOriginalAxes, hOutputAxes, hDropdown));

% Callback function for browsing and converting the image
function browseAndConvertImage(hOriginalAxes, hOutputAxes, hDropdown)
    % Open file browser
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'});
    if isequal(file, 0)
        return; % User canceled
    end

    % Read and process the selected image
    fullFileName = fullfile(path, file);
    image = imread(fullFileName);
    image = imresize(image, [224, 224]);

    % Display the original image
    axes(hOriginalAxes); % Activate the original image axes
    imshow(image);

    % Get the selected algorithm
    selectedAlgorithm = hDropdown.Value;

    % Perform grayscale conversion based on the selected algorithm
    switch selectedAlgorithm
        case 1 % Average Method
            grayscaleImage = mean(image, 3);
            formulaText = '$$Gray = \frac{Red + Green + Blue}{3}$$';
        case 2 % Weighted Average Method
            grayscaleImage = 0.3 * image(:, :, 1) + 0.59 * image(:, :, 2) + 0.11 * image(:, :, 3);
            formulaText = '$$Gray = 0.3 \times Red + 0.59 \times Green + 0.11 \times Blue$$';
        case 3 % Luminosity Method
            grayscaleImage = 0.21 * image(:, :, 1) + 0.72 * image(:, :, 2) + 0.07 * image(:, :, 3);
            formulaText = '$$Gray = 0.21 \times Red + 0.72 \times Green + 0.07 \times Blue$$';
        case 4 % Desaturation Method
            grayscaleImage = (max(image, [], 3) + min(image, [], 3)) / 2;
            formulaText = '$$Gray = \frac{Max(Red, Green, Blue) + Min(Red, Green, Blue)}{2}$$';
    end

    % Display the grayscale image
    axes(hOutputAxes); % Activate the output image axes
    imshow(grayscaleImage, []);
    title(hOutputAxes, 'Grayscale Image', 'FontSize', 12, 'FontWeight', 'bold');
    xlabel(hOutputAxes, ['Algorithm: ', hDropdown.String{selectedAlgorithm}], 'FontSize', 10, 'FontWeight', 'bold');
    ylabel(hOutputAxes, formulaText, 'Interpreter', 'latex', 'FontSize', 12, 'Color', 'black');
end