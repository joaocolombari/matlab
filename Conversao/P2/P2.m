%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%      de Energia - Prova 2        %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 

% Chama os dados do enunciado:
load('/Users/joaovitor/Documents/MATLAB/Conversao/P2/dados.mat')

p=polyfit(If,Ea,7);
y=polyval(p,If);

%% Plota todos juntos:
 
figure
plot(If, Ea,'o'); hold on; grid on;  
plot(If,y); xlabel('If[A]'); ylabel('Ea[V]');
title('Curvas de Magnetização'); 
legend('Dados','Regressão Polinomial de grau 7');
legend('Location','southeast')
