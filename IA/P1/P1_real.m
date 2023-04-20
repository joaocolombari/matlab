% SEL0362 - Inteligência Artificial
% Prova 1
% Joao Victor Colombari Carlet -- 5274502  

clear all 
close all 
clc

rng(3);

% The input set consists of three 4x4 block image;
% User must select the blocks that match the description;
% 0: do not match; 1: do match. 

P1_teste; % gets trained weights W1 and W2.

% Now dummy has provided inputs

X = zeros(4, 4, 3);

X(:, :, 1) =   [1 1 1 1;
                1 1 1 1;
                1 1 1 1;
                1 1 1 1]; % Clouds
X(:, :, 2) =   [0 0 0 0;
                0 0 1 1; 
                0 0 0 0; 
                0 0 0 0]; % Trafic Lights 1
X(:, :, 3) =   [0 1 1 1; 
                0 0 0 0; 
                0 0 0 0;
                1 1 1 1]; % Trafic Lights 2 WRONG!!
            
% Inference:
N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 16, 1); % normalizes ins
    v1 = W1*x;
    y1 = sigmoid(v1);
    v = W2*y1;
    y(k,:) = softmax(v);    
end

disp('Results:'); disp('[desired]:'); 
disp(D); disp('[network output]:'); disp(y)

figure(1)
plot(1:epoch, mse(1:epoch), 'k', 'LineWidth', 1.5);
title('MSE of training with dummy data'); 
xlabel('Epoch'); ylabel('MSE'); xlim([1 epoch]); grid on;