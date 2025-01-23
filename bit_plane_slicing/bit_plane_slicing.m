% MATLAB Script for Bit Plane Slicing 
% by Jjateen Gundesha
% Roll Number: BT22ECI002
% Description: This application allows the user to browse and select an image, 
%              and display its Bit Plane Slices.

clc;
clear all;
close all;

% Bit Plane Slicing in MATLAB

% Prompt user to select an image file
[file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'}, 'Select an Image');
if isequal(file, 0)
    disp('No file selected.');
    return;
end

% Read the selected image
imagePath = fullfile(path, file);
img = imread(imagePath);

% Convert to grayscale if the image is not already grayscale
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Get the size of the image
[rows, cols] = size(img);

% Initialize a figure for displaying the results
figure;
sgtitle('Bit Plane Slicing');

% Display the original grayscale image
subplot(3, 3, 1);
imshow(img);
title('Original Grayscale Image');

% Perform bit-plane slicing and display them in the grid
for i = 1:8
    % Extract the ith bit-plane
    bitPlane = bitget(img, i);
    
    % Display the bit-plane
    subplot(3, 3, i + 1);
    imshow(logical(bitPlane));
    title(['Bit Plane ', num2str(i)]);
end