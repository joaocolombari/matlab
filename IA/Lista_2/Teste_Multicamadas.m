% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

rng(3);

% The input set consists of five 5x5 pixel squares;
% 0: white pixel; 1: black pixel. 

X = zeros(5, 5, 7);

X(:, :, 1) =   [0 1 1 0 0;
                0 0 1 0 0;
                0 0 1 0 0;
                0 0 1 0 0;
                0 1 1 1 0]; %1
X(:, :, 2) =   [1 1 1 1 0;
                0 0 0 0 1; 
                0 1 1 1 0; 
                1 0 0 0 0;
                1 1 1 1 1]; %2
X(:, :, 3) =   [1 1 1 1 0; 
                0 0 0 0 1;
                0 1 1 1 0; 
                0 0 0 0 1;
                1 1 1 1 0]; %3
X(:, :, 4) =   [0 0 0 1 0;
                0 0 1 1 0; 
                0 1 0 1 0; 
                1 1 1 1 1;
                0 0 0 1 0]; %4
X(:, :, 5) =   [1 1 1 1 1; 
                1 0 0 0 0; 
                1 1 1 1 0; 
                0 0 0 0 1;
                1 1 1 1 0]; %5
X(:, :, 6) =   [1 1 1 1 1; 
                1 0 0 0 0; 
                1 1 1 1 1; 
                1 0 0 0 1;
                1 1 1 1 1]; %5
X(:, :, 7) =   [1 1 1 1 1; 
                0 0 0 0 1; 
                0 0 0 1 0; 
                0 0 0 1 0;
                0 0 0 1 0]; %5
            
% Desired outputs mapped via one-hot encoding (or 1-of-N encoding):
D =            [1 0 0 0 0 0 0; %1
                0 1 0 0 0 0 0; %2 
                0 0 1 0 0 0 0; %3 
                0 0 0 1 0 0 0; %4 
                0 0 0 0 1 0 0; %5
                0 0 0 0 0 1 0; %6
                0 0 0 0 0 0 1]; %7

% Weights initialization:
W1 = 2*rand(50, 25) - 1; %(hidden neurons) x (inputs) 
W2 = 2*rand( 7, 50) - 1; %(outputs) x (hidden neurons)

% Training process:
max_epoch = 10000;
for epoch = 1:max_epoch
    [W1, W2] = Multicamadas(W1, W2, X, D);
end

% Inference:
N = size(X,3);
y = zeros(N,size(D,2)); 
for k = 1:N
    x = reshape(X(:, :, k), 25, 1); 
    v1 = W1*x;
    y1 = sigmoid(v1);
    v = W2*y1;
    y(k,:) = softmax(v);    
end

disp('Results:'); disp('[desired]:'); 
disp(D); disp('[network output]:'); disp(y)

%% Showing images 
for i = 1:N
    compareImages(X(:,:,i), y(i,:));
end
 