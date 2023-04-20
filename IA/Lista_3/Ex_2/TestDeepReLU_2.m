% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

rng(3);

% The input consists of two sets of geometric shapes, 
% been the first made of 3 and the second of 4 and they 
% share same shapes, such as a triangle. 
% The DNN input set is the matrix that represents the shapes.
% If the shape belongs to the first set, it is drawed with
% 1, and if it belongs to the second, with 0.

X = zeros(7, 7, 7);

X(:, :, 1) = [0 0 0 1 0 0 0;
              0 0 1 1 1 0 0;
              0 1 1 1 1 1 0;
              1 1 1 1 1 1 1;
              0 1 1 1 1 1 0;
              0 0 1 1 1 0 0;
              0 0 0 1 0 0 0]; % Orange Rhombus (1st set)
          
X(:, :, 2) = [0 0 0 0 0 0 0;
              0 0 0 0 0 0 0;
              0 0 0 1 0 0 0;
              0 0 1 1 1 0 0;
              0 1 1 1 1 1 0;
              1 1 1 1 1 1 1;
              0 0 0 0 0 0 0]; % Blue Triangle (1st set)
          
X(:, :, 3) = [0 0 1 1 1 0 0;
              0 1 1 1 1 1 0;
              1 1 1 1 1 1 1;
              1 1 1 1 1 1 1;
              1 1 1 1 1 1 1;
              0 1 1 1 1 1 0;
              0 0 1 1 1 0 0]; % Black Circle (1st set)
 
X(:, :, 4) = [1 1 0 0 0 1 1;
              1 0 0 0 0 0 1;
              0 0 0 0 0 0 0;
              0 0 0 0 0 0 0;
              0 0 0 0 0 0 0;
              1 0 0 0 0 0 1;
              1 1 0 0 0 1 1]; % Green Circle (2nd set)
          
X(:, :, 5) = [1 1 1 1 1 1 1;
              1 0 0 0 0 0 1;
              1 0 0 0 0 0 1;
              1 0 0 0 0 0 1;
              1 0 0 0 0 0 1;
              1 0 0 0 0 0 1;
              1 1 1 1 1 1 1]; % Pink Square (2nd set)
          
X(:, :, 6) = [1 1 1 1 1 1 1;
              1 1 1 1 1 1 1;
              0 0 0 0 0 0 0;
              0 0 0 0 0 0 0;
              0 0 0 0 0 0 0;
              1 1 1 1 1 1 1;
              1 1 1 1 1 1 1]; % Yellow Rectangle (2nd set)
          
X(:, :, 7) = [1 1 1 1 1 1 1;
              1 1 1 1 1 1 1;
              1 1 1 0 1 1 1;
              1 1 0 0 0 1 1;
              1 0 0 0 0 0 1;
              0 0 0 0 0 0 0;
              1 1 1 1 1 1 1]; % Blue Triangle (2st set)
          
 % Desired outputs mapped via one-hot encoding (or 1-of-N encoding):
D =            [1 0 0 0 0 0 0;  % Orange Rhombus (1st set)
                0 1 0 0 0 0 0;  % Blue Triangle (1st set)
                0 0 1 0 0 0 0;  % Black Circle (1st set)
                0 0 0 1 0 0 0;  % Green Circle (2nd set)
                0 0 0 0 1 0 0;  % Pink Square (2nd set)
                0 0 0 0 0 1 0;  % Yellow Rectangle (2nd set)
                0 0 0 0 0 0 1]; % Blue Triangle (2st set)
        
          
W1 = 2*rand(30, 49) - 1;    % (hidden neurons) x (inputs) 
W2 = 2*rand(30, 30) - 1;    % (hidden neurons) x (hidden neurons)    
W3 = 2*rand(30, 30) - 1;    % (hidden neurons) x (hidden neurons)   
W4 = 2*rand( 7, 30) - 1;    % (outputs) x (hidden neurons)

% Training process: 
max_epoch = 10000;
mse = zeros(1,max_epoch);
for epoch = 1:10000 
    [W1, W2, W3, W4, mse(epoch)] = DeepReLU(W1, W2, W3, W4, X, D);
end

N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 49, 1); % Reorganizes input
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
