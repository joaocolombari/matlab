%%%%%%%%%%%%%%%%
% Atividade    %
%Jo�o Colombari%
%%%%%%%%%%%%%%%%

% Representa��o em fun��o de transf:  %

num=[21.6];
den=[1 4.7 0.9];

systf=tf(num,den);

% Resposta em freq:                   %

figure
bode(systf)

