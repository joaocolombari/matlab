% SEL0362 - Intelig�ncia Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  
%%  Defini��o da fun��o sigmoide
function sigmoid = sigmoid(x)
     sigmoid = 1./(1+exp(-x));
end 