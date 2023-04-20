% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

Teste_Multicamadas; %get trained weights W1 and W2.

X = zeros(5, 5, 7);

X(:, :, 1) =   [0 0 1 0 0; 
                0 0 1 0 0; 
                0 0 1 0 0; 
                0 0 1 0 0;
                0 0 1 0 0]; %1
X(:, :, 2) =   [1 1 1 1 0; 
                0 0 0 0 1; 
                0 1 0 1 0; 
                1 0 1 0 0;
                1 1 0 1 1]; %2
X(:, :, 3) =   [1 1 1 1 0; 
                0 0 0 0 1; 
                1 1 1 1 0; 
                0 0 0 0 1;
                1 1 1 1 0]; %3
X(:, :, 4) =   [0 0 1 1 0; 
                0 1 0 1 0; 
                1 1 1 1 1; 
                0 0 0 1 0;
                0 0 0 1 0]; %4
X(:, :, 5) =   [0 1 1 1 1;  
                0 1 0 0 0; 
                0 1 1 1 0; 
                0 0 0 1 0;
                1 1 1 1 0]; %5
X(:, :, 6) =   [0 1 1 1 1;  
                0 1 0 0 0; 
                1 1 1 1 1; 
                1 0 0 0 1;
                1 1 1 1 1]; %6
X(:, :, 7) =   [1 1 1 1 1;  
                0 0 0 0 1; 
                0 0 0 0 1; 
                0 0 0 0 1;
                0 0 0 0 1]; %7

       
% Inference:
N = size(X,3);
y = zeros(N,7); 
for k = 1:N
    x = reshape(X(:, :, k), 25, 1); 
    v1 = W1*x;
    y1 = sigmoid(v1);
    v = W2*y1;
    y(k,:) = softmax(v);
end

disp('Results:');
disp('[network output]:'); disp(y);

%% Showing images:
for i = 1:N
    compareImages(X(:,:,i), y(i,:));
end
