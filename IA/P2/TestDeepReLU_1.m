% SEL0362 - Inteligência Artificial
% Prova 2
% Joao Victor Colombari Carlet -- 5274502 

clear all 
close all 
clc

rng(3);

% The problem consists of a picture of four vases, where 
% each have its own color. The input is definined as four 
% 1x4 vectors representing each position of the problem. 
% Output is a one-hot 1x4 vector.

X = zeros(1, 4, 4);

X(:, :, 1) = [1 0 0 0]; % Black
          
X(:, :, 2) = [0 1 0 0]; % Coffee
          
X(:, :, 3) = [0 0 1 0]; % Tan
 
X(:, :, 4) = [0 0 0 1]; % Chocolate 
          
% Desired outputs mapped via one-hot encoding (or 1-of-N encoding):
D =            [1 0 0 0;  % Black 
                0 1 0 0;  % Coffee 
                0 0 1 0;  % Tan
                0 0 0 1]; % Chocolate 
        
          
W1 = 2*rand(25, 4) - 1;    % (hidden neurons) x (inputs) 
W2 = 2*rand(12, 25) - 1;    % (hidden neurons) x (hidden neurons)   
W3 = 2*rand( 4, 12) - 1;    % (outputs) x (hidden neurons)

% Training process: 
max_epoch = 10000;
mse = zeros(1,max_epoch);
for epoch = 1:10000 
    [W1, W2, W3, mse(epoch)] = DeepReLU(W1, W2, W3, X, D);
end

% Inference:
N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 4, 1); % Reorganizes input
    v1 = W1*x;
    y1 = ReLU(v1);
    v2 = W2*y1;
    y2 = ReLU(v2);
    v = W3*y2;
    y(k,:) = softmax(v);
end

disp('Results:'); disp('[desired]:'); 
disp(D); disp('[network output]:'); disp(y)

%% Showing images 
for i = 1:N
    compareImages(X(:,:,i), y(i,:));
end
 
%% Plotting results
figure
plot(1:epoch, mse(1:epoch), 'k', 'LineWidth', 1.5);
title('MSE of training'); xlabel('Epoch'); ylabel('MSE');
xlim([1 epoch]); grid on;
