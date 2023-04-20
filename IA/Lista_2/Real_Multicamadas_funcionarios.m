% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all 
close all 
clc

Teste_Multicamadas_funcionarios; %get trained weights W1 and W2.

X = zeros(4, 1, 4);

%zero if does not like, one if does

X(:, :, 1) =   [1 0 1 0];%g1
X(:, :, 2) =   [0 1 0 1];%g2
X(:, :, 3) =   [1 1 1 1];%g3 is now corrupted
X(:, :, 4) =   [0 0 0 0];%g4 is also corrupted
       
% Inference:
N = size(X,3);
y = zeros(N,4); 
for k = 1:N
    x = reshape(X(:, :, k), 4, 1); 
    v1 = W1*x;
    y1 = sigmoid(v1);
    v = W2*y1;
    y(k,:) = softmax(v);
end

disp('Results:');
disp('[network output]:'); disp(y);
