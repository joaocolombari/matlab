% -------------------------------------- % 
%          APDS - Trabalho 02            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 03 %

%% 

close all 
clear all

%% Definicoes 

ts=1.e-6;                       % Tamanho do passo 
t=-1.0:ts:1.0;                  % Vetor tempo 

% Ruido uniforme 
noisu=[-0.5+(1)*rand(length(t),1)];

% Ruido gaussiano
sigma2=4;                       % Valor RMS da Gauss
noisg=wgn(1,(2*1/ts+1),sigma2);

%% Desenvolvimento

% Gera vetores de 200 amostras do ruido
Ru=noisu(1:200);
Rg=noisg(1:200);

% Estimativa da funcao de autocorrelação do ruido
CCF=xcorr(Ru,Rg,'biased');

% Criando variavel tau
tau=-(length(CCF)-1)/2:1:(length(CCF)-1)/2;

%% Dados dos outros exercicios

load('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Q3data1.mat')
load('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Q3data2.mat')

% Plot 
figure
% title('Funcoes de Correlacao'); 
subplot(3,1,1)
plot(tau,ACF1_1,tau,MACF_1); 
title('1'); legend('Amostra','Media');
ylabel('Correlacao'); xlabel('Defasagem Tau');
subplot(3,1,2)
plot(tau,ACF1_2,tau,MACF_2); 
title('2'); legend('Amostra','Media');
ylabel('Correlacao'); xlabel('Defasagem Tau');
subplot(3,1,3); plot(tau,CCF); ylim([-0.2 1])
title('3'); legend('Correlacao Cruzada');
ylabel('Correlacao'); xlabel('Defasagem Tau');

%% Arquivos sig

% Importando
[y1,ts1]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/a01.WAV');
[y2,ts2]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/a02.WAV');
[y3,ts3]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/sinal04.WAV');

% Gerando vetores tempo
x1=linspace(0, length(y1)/ts1, length(y1));
x2=linspace(0, length(y2)/ts2, length(y2));
x3=linspace(0, length(y3)/ts3, length(y3));

% Gera vetores de 1000 amostras de cada sinal
Rx1=y1(1001:2000);  % Comeca com um breve silencio!!
Rx2=y2(1:1000);     % Caso nao atrasasse a amostra,
Rx3=y3(1:1000);     % nao haveria correlacao!!

% Estimativa das funcoes correlação 
ACFy1=xcorr(Rx1,'biased');
ACFy2=xcorr(Rx2,'biased');
ACFy3=xcorr(Rx2,'biased');
CCF=xcorr(Rx2,Rx3,'biased');

% Vetores Tau
tau=-(length(CCF)-1)/2:1:(length(CCF)-1)/2;

% Plot
figure(2)
subplot(2,2,1); plot(tau,ACFy1); 
ylim([-0.2 0.2]); title('Amostra 1'); 
ylabel('Correlacao'); xlabel('Defasagem Tau');
%%%%
subplot(2,2,2); plot(tau,ACFy2); 
ylim([-0.2 0.2]); title('Amostra 2'); 
ylabel('Correlacao'); xlabel('Defasagem Tau');
%%%%
subplot(2,2,3); plot(tau,ACFy3);
ylim([-0.2 0.2]); title('Amostra 3');
ylabel('Correlacao'); xlabel('Defasagem Tau');
%%%%
subplot(2,2,4); plot(tau,CCF); 
ylim([-0.2 0.2]); title('Correlacao Cruzada'); 
ylabel('Correlacao'); xlabel('Defasagem Tau');
