%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%     de Energia Exercicio 3       %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 

% Chama os dados coletados no vídeo:
load('/Users/joaovitor/Documents/MATLAB/Conversao/Ex3/dados.mat')

I1_1=[];I2_1=[];V1_1=[];V2_1=[];

for i=1:1:15
    I1_1(i)=(I1(i)+I1(32-i))/2;
end
I1_1=[I1_1 I1(16)];

for i=1:1:15
    V1_1(i)=(V1(i)+V1(32-i))/2;
end
V1_1=[V1_1 V1(16)];

for i=1:1:16
    I2_1(i)=(I2(i)+I2(32-i))/2;
end

for i=1:1:16
    V2_1(i)=(V2(i)+V2(32-i))/2;
end

%% Plota todos juntos:
 
figure
plot(I1_1, V1_1); hold on; grid on; plot(I2_1, V2_1); 
xlabel('If[A]'); ylabel('Ea[V]');
title('Curvas de Magnetização'); 
legend('1800rmp', '900rpm')
