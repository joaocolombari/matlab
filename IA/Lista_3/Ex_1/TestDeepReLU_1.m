% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

rng(3);

% The input consists of a picture of billyard balls
% The input set is the collection of 8 3x4 matrixes
% that represent each ball
% Network must find wich is wich

X = zeros(3, 4, 8);

X(:, :, 1) = [1 0 0 0;
              0 0 0 0;
              0 0 0 0]; % Green
          
X(:, :, 2) = [0 1 0 0;
              0 0 0 0;
              0 0 0 0]; % White
          
X(:, :, 3) = [0 0 1 0;
              0 0 0 0;
              0 0 0 0]; % Yellow
 
X(:, :, 4) = [0 0 0 1;
              0 0 0 0;
              0 0 0 0]; % Blue
          
X(:, :, 5) = [0 0 0 0;
              1 0 0 0;
              0 0 0 0]; % Pink
          
X(:, :, 6) = [0 0 0 0;
              0 1 0 0;
              0 0 0 0]; % Red
          
X(:, :, 7) = [0 0 0 0;
              0 0 1 0;
              0 0 0 0]; % Black 
          
X(:, :, 8) = [0 0 0 0;
              0 0 0 0;
              1 0 0 0]; % Brown
          
 % Desired outputs mapped via one-hot encoding (or 1-of-N encoding):
D =            [1 0 0 0 0 0 0 0;  % Green
                0 1 0 0 0 0 0 0;  % White 
                0 0 1 0 0 0 0 0;  % Yellow
                0 0 0 1 0 0 0 0;  % Blue 
                0 0 0 0 1 0 0 0;  % Pink
                0 0 0 0 0 1 0 0;  % Red 
                0 0 0 0 0 0 1 0;  % Black 
                0 0 0 0 0 0 0 1]; % Brown
        
          
W1 = 2*rand(20, 12) - 1;    % (hidden neurons) x (inputs) 
W2 = 2*rand(20, 20) - 1;    % (hidden neurons) x (hidden neurons)    
W3 = 2*rand(20, 20) - 1;    % (hidden neurons) x (hidden neurons)   
W4 = 2*rand( 8, 20) - 1;    % (outputs) x (hidden neurons)

% Training process: 
max_epoch = 10000;
mse = zeros(1,max_epoch);
for epoch = 1:10000 
    [W1, W2, W3, W4, mse(epoch)] = DeepReLU(W1, W2, W3, W4, X, D);
end

N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 12, 1); % Reorganizes input
    v1 = W1*x;
    y1 = ReLU(v1);
    v2 = W2*y1;
    y2 = ReLU(v2);
    v3 = W3*y2;
    y3 = ReLU(v3);
    v = W4*y3;
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
