% Faça um código que inicialize x = 0 e realize um loop em que o valor 1/5
% e adicionado a x 30 vezes. Dentro do loop, somente quando o valor de x 
% for um número inteiro (1,2,3,4,5,6) ou igual a 3.6, o valor de x deve ser 
% impresso na tela.

clear all 

% x=0-1/5;
% y=0;
% c=30;
% 
% for i=1:1:c
%     x=x+1/5;
%     if floor(x)-x==0||x==3.6
%         x
%     end
% end

% Desta forma o codigo nao funciona devido ao erro relacionado a
% representacao do numero. Para que o codigo funcione vou arredondar para a
% quarta casa decimal

x=0-1/5;
y=0;
c=30;

for i=1:1:c
    x=x+1/5;
    x=round(x,4);
    if floor(x)-x==0||x==3.6
        x
    end
end
