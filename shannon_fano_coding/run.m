clc; clear all; close all;

% User input for probabilities
probabilities = input('Enter the probabilities as a row vector (e.g., [0.4, 0.2, 0.2, 0.1, 0.1]): ');
% probabilities = [0.3 0.2 0.2 0.1 0.1 0.05 0.05];
% Validate that probabilities sum to 1
if abs(sum(probabilities) - 1) > 1e-6
    error('The probabilities must sum to 1.');
end

% Call the ShannonFano function to get the codes and average length
[codewords, average_length] = ShannonFano(probabilities);

% Display results
fprintf('Symbol\tProbability\tCode\n');
for i = 1:length(probabilities)
    fprintf('%d\t%.4f\t\t%s\n', i, probabilities(i), codewords{i});
end

% Display the average codeword length
fprintf('\nAverage Codeword Length: %.4f\n', average_length);