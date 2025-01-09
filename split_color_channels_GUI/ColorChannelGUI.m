% MATLAB GUI Application for Color Channel Viewer
% Author: Jjateen Gundesha
% Roll Number: BT22ECI002
% Description: This application allows the user to browse and select an image, 
%              display the original image on the left, and display a montage 
%              of color channels (Red, Green, Blue, and Original) on the right.

clc;
clear all;
close all;

% Create the GUI figure
hFig = figure('Name', 'Color Channel Viewer', 'NumberTitle', 'off', ...
              'Position', [100, 100, 1000, 500]);

% Axes for displaying the original image
hOriginalAxes = axes('Parent', hFig, 'Position', [0.05, 0.2, 0.4, 0.6]);
title(hOriginalAxes, 'Original Image');
xlabel(hOriginalAxes, 'Displayed: Original Image');

% Axes for displaying the montage
hMontageAxes = axes('Parent', hFig, 'Position', [0.55, 0.2, 0.4, 0.6]);
title(hMontageAxes, 'Color Channels Montage');
xlabel(hMontageAxes, 'Displayed: Red, Green, Blue, and All Channels');

% Button to browse and load the image (footer position)
uicontrol('Style', 'pushbutton', 'String', 'Browse Image', ...
          'Position', [450, 20, 100, 30], ...
          'Callback', @(~, ~) browseImage(hOriginalAxes, hMontageAxes));

% Callback function for the Browse Image button
function browseImage(hOriginalAxes, hMontageAxes)
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

    % Extract RGB channels
    [r, g, b] = imsplit(image);

    % Create all black channel
    allBlack = zeros(size(image, 1), size(image, 2), class(image));

    % Combine channels to create color-separated images
    justRed = cat(3, r, allBlack, allBlack);
    justGreen = cat(3, allBlack, g, allBlack);
    justBlue = cat(3, allBlack, allBlack, b);

    % Display the montage of color channels
    axes(hMontageAxes); % Activate the montage axes
    montage({justRed, justGreen, justBlue, image}, 'ThumbnailSize', [224, 224]);

    % Add labels to the montage display
    xlabel(hMontageAxes, ...
        '1: Red Channel, 2: Green Channel, 3: Blue Channel, 4: All Channels');
end