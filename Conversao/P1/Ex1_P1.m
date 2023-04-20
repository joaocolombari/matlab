%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%     de Energia Prova 1           %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 

% Chama os dados disponibilizados:
load('/Users/joaovitor/Documents/MATLAB/Conversao/matl07.mat')
load('/Users/joaovitor/Documents/MATLAB/Conversao/matl16.mat')

B07=matl07(:,2);
H07=matl07(:,1);
B16=matl16(:,2);
H16=matl16(:,1);

%% Plota todos juntos:
 
figure
title('Meus Materiais'); hold on; grid on; 
subplot(2,1,1); hold on; grid on; 
plot(H07, B07); xlim([0 400])
xlabel('H[A/m]'); ylabel('B[T]'); title('Material 07'); 
legend('Curva de Magnetizacao')
subplot(2,1,2); hold on; grid on; 
plot(H16, B16); xlim([0 200])
xlabel('H[A/m]'); ylabel('B[T]'); title('Material 16'); 
legend('Curva de Magnetizacao')
