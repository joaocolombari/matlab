% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  
clear all
%% Treinamento da rede neural - método batch
%variáveis iniciais:
%  --2--
% |     |
% 1     3
% |--0--|
% 6     4
% |     |
%  --5--
% imputs possíveis (o ultimo dígito é a polarização, sempre igual a 1)
inputs = [0 1 1 1 1 1 1 1; %0
          0 0 0 1 1 0 0 1; %1
          1 0 1 1 0 1 1 1; %2
          1 0 1 1 1 1 0 1; %3
          1 1 0 1 1 0 0 1; %4
          1 1 1 0 1 1 0 1; %5
          1 1 1 0 1 1 1 1; %6
          0 1 1 1 1 0 0 1; %7
          1 1 1 1 1 1 1 1; %8
          1 1 1 1 1 0 0 1; %9
          ];
% outputs para cada input
O_c = [1 0 0 0 0 0 0 0 0 0; %0
       0 1 0 0 0 0 0 0 0 0; %1
       0 0 1 0 0 0 0 0 0 0; %2
       0 0 0 1 0 0 0 0 0 0; %3
       0 0 0 0 1 0 0 0 0 0; %4
       0 0 0 0 0 1 0 0 0 0; %5
       0 0 0 0 0 0 1 0 0 0; %6
       0 0 0 0 0 0 0 1 0 0; %7
       0 0 0 0 0 0 0 0 1 0; %8
       0 0 0 0 0 0 0 0 0 1; %9
       ];
%inicializando os pesos com números aleatórios entre -1 e 1
N_outputs = size(O_c);N_outputs = N_outputs(2);
N_inputs = size(inputs);N_inputs = N_inputs(2);
N_trei =size(inputs);N_trei = N_trei(1);
w = 2*rand(N_outputs,N_inputs)-1;
%% Treinamento
Nepoca = 10000;
for epoca = 1:Nepoca
    [w,e] = fbatch(w,inputs,O_c);
    e1(epoca) = 1/length(e)*sum(e);
    X(epoca) = epoca;
end
y = zeros(N_trei,1);
%% Teste
for k = 1:N_trei
    x = inputs(k,:)';
    v = w*x;
    y = sigmoid(v)
    outputs(k) = find(O_c(k,:) == max(O_c(k,:)))-1;
    resp(k) = find(y == max(y))-1;
end

plot(X,abs(e1),'r-')

 disp('Results:');
 disp('desejado obtido');
 disp([outputs' resp']);