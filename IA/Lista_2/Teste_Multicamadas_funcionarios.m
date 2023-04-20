% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

rng(3);

X = zeros(4, 1, 4);

X(:, :, 1) =   [1 0 1 0];%g1
X(:, :, 2) =   [0 1 0 1];%g2
X(:, :, 3) =   [0 1 1 1];%g3
X(:, :, 4) =   [1 0 0 0];%g4

% Desired outputs mapped via one-hot encoding (or 1-of-N encoding):
D =            [1 0 0 0; %1
                0 1 0 0; %2 
                0 0 1 0; %3 
                0 0 0 1];%4 
          
%% Weights initialization:
W1 = 2*rand(20, 4) - 1; %(hidden neurons) x (inputs) 
W2 = 2*rand( 4, 20) - 1; %(outputs) x (hidden neurons)

% Training process:
max_epoch = 10000;
for epoch = 1:max_epoch
    [W1, W2] = Multicamadas_funcionarios(W1, W2, X, D);
end

% Inference:
N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 4, 1); 
    v1 = W1*x;
    y1 = sigmoid(v1);
    v = W2*y1;
    y(k,:) = softmax(v);    
end

disp('Results:'); disp('[desired]:'); 
disp(D); disp('[network output]:'); disp(y)
