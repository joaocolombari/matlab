% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  
%%  Definição da função sigmoide
function sigmoid = sigmoid(x)
     sigmoid = 1./(1+exp(-x));
end 