%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%     de Energia Exercicio 1       %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 

N=800;      lc=0.36;    lg=0.8e-3; 
Ag=6e-4;    I=1.5;      mu0=4*pi*1e-7;

% Chama os dados disponibilizados:
load('/Users/joaovitor/Documents/MATLAB/Conversao/Dados_Conv_01.mat')

BT1=Dados_Conv_01(:,1);BT2=Dados_Conv_01(:,2);
BT3=Dados_Conv_01(:,3);H1=Dados_Conv_01(:,4); 
H2=Dados_Conv_01(:,5); H3=Dados_Conv_01(:,6);

%% Calcula a reta para os valores de H:

R1=Reta_Carga(H1);
R2=Reta_Carga(H2);
R3=Reta_Carga(H3);

%% Plota todos juntos:
 
figure
subplot(3,1,1);
plot(H1, BT1); hold on; grid on; plot(H1, R1); 
xlabel('H'); ylabel('B')
xlim([0 30]); title('Material 1'); 
legend('Curva de Magnetizacao', 'Reta de Carga')
subplot(3,1,2); 
plot(H2, BT2); hold on; grid on; plot(H2, R2); 
xlabel('H'); ylabel('B')
xlim([0 2e3]); title('Material 2'); legend('hsd', 'hduh')
legend('Curva de Magnetizacao', 'Reta de Carga')
subplot(3,1,3);
plot(H3, BT3); hold on; grid on; plot(H3, R3); 
xlabel('H'); ylabel('B')
xlim([0 5]); title('Material 3'); legend('hsd', 'hduh')
legend('Curva de Magnetizacao', 'Reta de Carga')