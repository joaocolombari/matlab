% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  
%% Definiçao da função de ajuste de pesos fbatch

function [w,e] = fbatch(w,I,O)
N_outputs = size(O);N_outputs = N_outputs(2);
N_inputs = size(I);N_inputs = N_inputs(2);
N_trei =size(I);N_trei = N_trei(1);
alfa = 0.5; %taxa de aprendizado
w0 = zeros(N_outputs,N_inputs); %inicializa uma matriz 1x8 de zeros

for k = 1:N_trei
    input_T = I(k,:)'; %transpõe a K-ésima camada de input
    v = w*input_T; %soma ponderada pelos pesos Wij de cada input no neuronio de saida
    output = sigmoid(v); %saída considerando a função de ativação
    d = O(k,:)'; %saída desejada para a k-ésima camada de inputs
    e = d - output; %erro
    delta = output.*(1-output).*e;
    deltaW = alfa*delta*input_T';
    w0 = w0 + deltaW;
end%for

W_medio = 1/N_inputs*w0; %calcula o ajuste médio antes de ajustar individualmente
for i = 1:N_outputs %ajusta cada peso individualmente
    w(i,:) = w(i,:)+W_medio(i,:);
end%for 

end%function
