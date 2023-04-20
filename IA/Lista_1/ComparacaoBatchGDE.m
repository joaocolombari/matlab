% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  
clear all
%% Comparação dos Métodos
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
N_outputs = size(O_c);N_outputs = N_outputs(2);
N_inputs = size(inputs);N_inputs = N_inputs(2);
N_trei =size(inputs);N_trei = N_trei(1);
w1 = 2*rand(N_outputs,N_inputs)-1; %inicializando os pesos com números aleatórios entre -1 e 1
w2 = w1;
%% Treinamentos 
Nepoca = 50000;
for epoca = 1:Nepoca
    [w1,e1] = fbatch(w1,inputs,O_c);
    [w2,e2] = fGDE(w2,inputs,O_c);
    E1(epoca) = 1/length(e1)*sum(e1.^2);
    E2(epoca) = 1/length(e2)*sum(e2.^2);
end
X = 1:Nepoca;
%% Execução dos métodos
y1 = zeros(N_trei,1);
y2 = y1;
for k = 1:N_trei
    x = inputs(k,:)';
    v1 = w1*x;
    y1 = sigmoid(v1);
    v2 = w2*x;
    y2 = sigmoid(v2);
    output(k) = find(O_c(k,:) == max(O_c(k,:)))-1;
    resp_batch(k) = find(y1 == max(y1))-1;
    resp_GDE(k) = find(y2 == max(y2))-1;
end

 disp('w1 w2');
 disp([w1' w2']);

figure(1)
plot(X,abs(E1),'--')
hold on
plot(X,abs(E2))
title('Comparação do método batch e do método GDE')
xlabel('Época')
ylabel('|Erro|')
legend('Batch','GDE')
