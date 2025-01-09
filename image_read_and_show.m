clc 
clear all 
close all

image = imread('cat.jpg');
image = imresize(image, [224,224]);
imshow(image);