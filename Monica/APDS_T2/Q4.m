% -------------------------------------- % 
%          APDS - Trabalho 02            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 04 %

%% 

close all 
clear all

%% Definicoes 

ts=1.e-6;                       % Tamanho do passo 
t=-1.0:ts:1.0;                  % Vetor tempo 

% Ruido gaussiano
sigma2=(0.5)^2;                 % Valor RMS da Gauss
noisg=wgn(1,(2*1/ts+1),sigma2);

% Senoide
sine=1*sin(2*pi*0.03*t);

%% Desenvolvimento

% Gera 10 vetores de 200 amostras do ruido
R1=noisg(1:300);
R2=sine(1:300);
R3=R1+R2;

% Estimativa das funcoes correlação 
ACFR=xcorr(R2,'biased');
CCF1=xcorr(R3,R2,'biased');
CCF2=xcorr(R3,R1,'biased');

% Criando variavel tau
tau=-(length(CCF1)-1)/2:1:(length(CCF1)-1)/2;

% Plot
figure(1)
subplot(3,1,1)
plot(tau,ACFR); title('Autocorrelacao Sinal');
ylabel('Correlacao'); xlabel('Defasagem Tau');
%%%%%
subplot(3,1,2)
plot(tau,CCF1); 
title('Correlacao Cruzada Sinal Ruidoso e Sinal'); 
ylabel('Correlacao'); xlabel('Defasagem Tau');
%%%%%
subplot(3,1,3); plot(tau,CCF2);
title('Correlacao Cruzada Sinal Ruidoso e Ruido');
ylabel('Correlacao'); xlabel('Defasagem Tau');
